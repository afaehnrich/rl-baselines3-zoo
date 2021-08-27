import argparse
import importlib
import os
import sys

import numpy as np
import torch as th
import yaml
from stable_baselines3.common.utils import set_random_seed
from stable_baselines3.common import logger, utils as sbcommon_utils

import utils.import_envs  # noqa: F401 pylint: disable=unused-import
from utils import ALGOS, create_test_env, get_latest_run_id, get_saved_hyperparams
from utils.exp_manager import ExperimentManager
from utils.utils import StoreDict
from matplotlib import pyplot as plt
import xlsxwriter

# from torch.utils.tensorboard import SummaryWriter

class Xlsx_Logger():
    
    _keys= {}
    _vals= {}
    SAVE_FREQ = 10
    ep = 0

    def __init__(self, dir, env_id):
        self.dir = dir
        self.filename_step = env_id + '.xlsx'
        self.filename_ep = env_id + '_ep.xlsx'
        print('logging steps to xlsx: ', os.path.join(self.dir, self.filename_step))
        self.workbook = xlsxwriter.Workbook(os.path.join(self.dir, self.filename_step), {'constant_memory': True})
        self.worksheet_step = self.workbook.add_worksheet(name = 'Steps')
        self.worksheet_ep_mean = self.workbook.add_worksheet(name = 'Episode means')
        self.worksheet_ep_std = self.workbook.add_worksheet(name = 'Episode standard deviations')
        self.current_row_step = 0
        self.current_row_ep = 0


    def add_header(self, key, worksheet):
        # self.workbook.close()
        # self.workbook = xlsxwriter.Workbook(os.path.join(self.dir, self.filename_step))
        worksheet.write(0, self._keys[key], key)
        # self.workbook.close()
        # self.workbook = xlsxwriter.Workbook(os.path.join(self.dir, self.filename_step), {'constant_memory': True})

    def log(self, key, value, add_to_mean = True):
        if not key in self._keys:
            self._keys.update({ key: len(self._keys) })            
            self.add_header(key, self.worksheet_step)
        self.worksheet_step.write(self.current_row_step, self._keys[key], value)
        if add_to_mean:
            if not key in self._vals:
                self._vals.update({ key: [] })
                self.add_header(key, self.worksheet_step)
                self.add_header(key, self.worksheet_ep_mean)
                self.add_header(key, self.worksheet_ep_std)
            self._vals[key].append(value)

    def set_step_ep(self, episode, step):
        self.current_row_step +=1        
        self.log('step', step, False)
        if episode != self.ep:
            self.log('episode', episode, True)
            self.log_ep_means()
            self.ep = episode
        else:
            self.log('episode', episode, False)

    def log_ep_means(self):
        self.current_row_ep += 1
        for key, values in self._vals.items():
            mean = np.array(values).mean()
            if np.isfinite(mean): self.worksheet_ep_mean.write(self.current_row_ep, self._keys[key], mean)
            std = np.array(values).std()
            if np.isfinite(std): self.worksheet_ep_std.write(self.current_row_ep, self._keys[key], std)
        for k in self._vals.keys():
            self._vals[k]=[]


    def close(self):
        self.workbook.close()


def main():  # noqa: C901
    parser = argparse.ArgumentParser()
    parser.add_argument("-tb", "--tensorboard-log", help="Tensorboard log dir", default="", type=str)
    parser.add_argument("--env", help="environment ID", type=str, default="CartPole-v1")
    parser.add_argument("-f", "--folder", help="Log folder", type=str, default="rl-trained-agents")
    parser.add_argument("--algo", help="RL Algorithm", default="ppo", type=str, required=False, choices=list(ALGOS.keys()))
    parser.add_argument("-n", "--n-timesteps", help="number of timesteps", default=1000, type=int)
    parser.add_argument("--num-threads", help="Number of threads for PyTorch (-1 to use default)", default=-1, type=int)
    parser.add_argument("--n-envs", help="number of environments", default=1, type=int)
    # parser.add_argument("--exp-id", help="Experiment ID (default: 0: latest, -1: no exp folder)", default=0, type=int)
    parser.add_argument("--exp-id", help="Experiment ID (default: 0: latest, -1: no exp folder)", default=0, type=str)
    parser.add_argument("--verbose", help="Verbose mode (0: no output, 1: INFO)", default=1, type=int)
    parser.add_argument(
        "--no-render", action="store_true", default=False, help="Do not render the environment (useful for tests)"
    )
    parser.add_argument("--render-mode", default='step', help="Whether to render at each step or at the end of an episode")    
    parser.add_argument("--deterministic", action="store_true", default=False, help="Use deterministic actions")
    parser.add_argument(
        "--load-best", action="store_true", default=False, help="Load best model instead of last model if available"
    )
    parser.add_argument(
        "--load-checkpoint",
        type=int,
        help="Load checkpoint instead of last model if available, "
        "you must pass the number of timesteps corresponding to it",
    )
    parser.add_argument("--stochastic", action="store_true", default=False, help="Use stochastic actions")
    parser.add_argument(
        "--norm-reward", action="store_true", default=False, help="Normalize reward if applicable (trained with VecNormalize)"
    )
    parser.add_argument("--seed", help="Random generator seed", type=int, default=0)
    parser.add_argument("--info-freq", help="Frequency on which info valuers are logged", type=int, default=10)
    parser.add_argument("--reward-log", help="Where to log reward", default="", type=str)
    parser.add_argument(
        "--gym-packages",
        type=str,
        nargs="+",
        default=[],
        help="Additional external Gym environemnt package modules to import (e.g. gym_minigrid)",
    )
    parser.add_argument(
        "--env-kwargs", type=str, nargs="+", action=StoreDict, help="Optional keyword argument to pass to the env constructor"
    )
    args = parser.parse_args()

    # Going through custom gym packages to let them register in the global registory
    for env_module in args.gym_packages:
        importlib.import_module(env_module)

    env_id = args.env
    algo = args.algo
    folder = args.folder

    if args.exp_id == '0':
        args.exp_id = get_latest_run_id(os.path.join(folder, algo), env_id)
        print(f"Loading latest experiment, id={args.exp_id}")

    # Sanity checks
    if args.exp_id != '0' and args.exp_id !='-1':
        log_path = os.path.join(folder, algo, f"{env_id}_{args.exp_id}")
    else:
        log_path = os.path.join(folder, algo)

    assert os.path.isdir(log_path), f"The {log_path} folder was not found"

    found = False
    for ext in ["zip"]:
        model_path = os.path.join(log_path, f"{env_id}.{ext}")
        found = os.path.isfile(model_path)
        if found:
            break

    if args.load_best:
        model_path = os.path.join(log_path, "best_model.zip")
        found = os.path.isfile(model_path)

    if args.load_checkpoint is not None:
        model_path = os.path.join(log_path, f"rl_model_{args.load_checkpoint}_steps.zip")
        found = os.path.isfile(model_path)

    if not found:
        raise ValueError(f"No model found for {algo} on {env_id}, path: {model_path}")
    else:
        print(f"Loading model for {algo} on {env_id}, path: {model_path}")

    off_policy_algos = ["qrdqn", "dqn", "ddpg", "sac", "her", "td3", "tqc"]

    if algo in off_policy_algos:
        args.n_envs = 1

    set_random_seed(args.seed)

    if args.num_threads > 0:
        if args.verbose > 1:
            print(f"Setting torch.num_threads to {args.num_threads}")
        th.set_num_threads(args.num_threads)

    is_atari = ExperimentManager.is_atari(env_id)

    stats_path = os.path.join(log_path, env_id)
    hyperparams, stats_path = get_saved_hyperparams(stats_path, norm_reward=args.norm_reward, test_mode=True)

    # load env_kwargs if existing
    env_kwargs = {}
    args_path = os.path.join(log_path, env_id, "args.yml")
    if os.path.isfile(args_path):
        with open(args_path, "r") as f:
            loaded_args = yaml.load(f, Loader=yaml.UnsafeLoader)  # pytype: disable=module-attr
            if loaded_args["env_kwargs"] is not None:
                env_kwargs = loaded_args["env_kwargs"]
    # overwrite with command line arguments
    if args.env_kwargs is not None:
        env_kwargs.update(args.env_kwargs)

    log_dir = args.reward_log if args.reward_log != "" else None

    env = create_test_env(
        env_id,
        n_envs=args.n_envs,
        stats_path=stats_path,
        seed=args.seed,
        log_dir=log_dir,
        should_render=not args.no_render,
        hyperparams=hyperparams,
        env_kwargs=env_kwargs,
    )

    kwargs = dict(seed=args.seed)
    if algo in off_policy_algos:
        # Dummy buffer size as we don't need memory to enjoy the trained agent
        kwargs.update(dict(buffer_size=1))

    # Check if we are running python 3.8+
    # we need to patch saved model under python 3.6/3.7 to load them
    newer_python_version = sys.version_info.major == 3 and sys.version_info.minor >= 8

    custom_objects = {}
    if newer_python_version:
        custom_objects = {
            "learning_rate": 0.0,
            "lr_schedule": lambda _: 0.0,
            "clip_range": lambda _: 0.0,
        }

    model = ALGOS[algo].load(model_path, env=env, custom_objects=custom_objects, **kwargs)

    # tb_path = ''
    # for i in range(0,100000,1):
    #     tb_path = os.path.join(args.tensorboard_log, env_id, algo.upper() + "_" + str(i))
    #     if not os.path.exists(tb_path):
    #         break        
    # print("algo=",algo, "  logdir=", tb_path)
    # writer = SummaryWriter(log_dir=tb_path)

    obs = env.reset()

    # Deterministic by default except for atari games
    stochastic = args.stochastic or is_atari and not args.deterministic
    deterministic = not stochastic

    state = None
    episode_reward = 0.0
    episode_rewards, episode_lengths = [], []
    ep_len = 0
    ep_count = 0
    # For HER, monitor success rate
    successes = []
    sbcommon_utils.configure_logger(args.verbose, os.path.join(args.tensorboard_log, env_id), algo.upper(), reset_num_timesteps=True)
    xlsx_logger = Xlsx_Logger(logger.get_dir(), env_id)
    fig: plt.Figure = None
    info_freq = args.info_freq
    save_freq = 1000
    try:
        for step in range(args.n_timesteps):
            action, state = model.predict(obs, state=state, deterministic=deterministic)
            obs, reward, done, infos = env.step(action)
            episode_reward += reward[0]
            ep_len += 1

            if args.n_envs == 1:

                # log info variables to tensorboard
                if (step % info_freq == 0 or done) and type(infos[0]) is dict:
                    if not args.no_render:
                        if not done and args.render_mode=='step':
                            fig = env.render("human")
                        elif done and args.render_mode=='episode':
                            fig = env.envs[0].rendered_episode
                    xlsx_logger.set_step_ep(ep_count, step)
                    for key in infos[0]:
                        if key == 'episode' or key == 'terminal_observation' or key == 'render': continue
                        val = infos[0].get(key)
                        logger.record("eval/"+key, val, exclude='stdout')
                        xlsx_logger.log(key, val)
                    if fig is not None:
                        log_fig = logger.Figure(fig,False)
                        logger.record("eval/figure", log_fig, exclude='stdout')
                        # writer.add_scalar("eval/"+key, val, step)
                    logger.dump(step=step)

                # For atari the return reward is not the atari score
                # so we have to get it from the infos dict
                if is_atari and infos is not None and args.verbose >= 1:
                    episode_infos = infos[0].get("episode")
                    if episode_infos is not None:
                        print(f"Atari Episode Score: {episode_infos['r']:.2f}")
                        print("Atari Episode Length", episode_infos["l"])

                if done and not is_atari and args.verbose > 0:
                    # NOTE: for env using VecNormalize, the mean reward
                    # is a normalized reward when `--norm_reward` flag is passed
                    
                    print("Episode #{}, step#{}".format(ep_count, step))
                    print(f"  Episode Reward: {episode_reward:.2f}")
                    print("  Episode Length", ep_len)                          
                    episode_rewards.append(episode_reward)
                    logger.record("eval/ep_len", ep_len, exclude='stdout')
                    logger.record("eval/ep_reward", episode_reward, exclude='stdout')
                    xlsx_logger.log('ep_len', ep_len)
                    xlsx_logger.log('reward', episode_reward)
                    logger.dump(step=step)
                    episode_lengths.append(ep_len)
                    episode_reward = 0.0
                    ep_len = 0
                    ep_count +=1
                    state = None

                # Reset also when the goal is achieved when using HER
                if done and infos[0].get("is_success") is not None:
                    if args.verbose > 1:
                        print("Success?", infos[0].get("is_success", False))

                    if infos[0].get("is_success") is not None:
                        successes.append(infos[0].get("is_success", False))
                        episode_reward, ep_len = 0.0, 0
                        ep_count +=1

            # if (not args.no_render) and args.render_mode=='step':
            #     fig = env.render("human")
            # else:
            #     fig = None

    except KeyboardInterrupt:
        pass

    logger.dump(step=step)
    xlsx_logger.close()

    if args.verbose > 0 and len(successes) > 0:
        print(f"Success rate: {100 * np.mean(successes):.2f}%")

    if args.verbose > 0 and len(episode_rewards) > 0:
        print(f"{len(episode_rewards)} Episodes")
        print(f"Mean reward: {np.mean(episode_rewards):.2f} +/- {np.std(episode_rewards):.2f}")

    if args.verbose > 0 and len(episode_lengths) > 0:
        print(f"Mean episode length: {np.mean(episode_lengths):.2f} +/- {np.std(episode_lengths):.2f}")

    env.close()
    # writer.close()


if __name__ == "__main__":
    main()
