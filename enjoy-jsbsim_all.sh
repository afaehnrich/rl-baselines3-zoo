#!/bin/bash

sh enjoy-jsb.sh JSBSim-v0
sh enjoy-jsb.sh JSBSim-v5
sh enjoy-jsb.sh JSBSim-v6
sh enjoy-jsb.sh JSBSim-v9
sh enjoy-jsb.sh JSBSim-v13
sh enjoy-jsb.sh JSBSim-v14
sh enjoy-jsb.sh JSBSim2D-v0
sh enjoy-jsb.sh JSBSim2D-v1
sh enjoy-jsb.sh JSBSim2D-v2
sh enjoy-jsb.sh JSBSim2D-v3
sh enjoy-jsb.sh JSBSim2D-v4


# python3 enjoy2.py --algo sac --env JSBSim-v0 --folder rl-trained-agents/ -n 100000 --tensorboard-log logs_enjoy --render-mode=episode --env-kwargs render_before_reset:True
# python3 enjoy2.py --algo sac --env JSBSim-v1 --folder rl-trained-agents/ -n 100000 --tensorboard-log logs_enjoy --render-mode=episode --env-kwargs render_before_reset:True
# python3 enjoy2.py --algo sac --env JSBSim-v2 --folder rl-trained-agents/ -n 100000 --tensorboard-log logs_enjoy --render-mode=episode --env-kwargs render_before_reset:True
# python3 enjoy2.py --algo sac --env JSBSim-v3 --folder rl-trained-agents/ -n 100000 --tensorboard-log logs_enjoy --render-mode=episode --env-kwargs render_before_reset:True
# python3 enjoy2.py --algo sac --env JSBSim-v4 --folder rl-trained-agents/ -n 100000 --tensorboard-log logs_enjoy --render-mode=episode --env-kwargs render_before_reset:True
# python3 enjoy2.py --algo sac --env JSBSim-v5 --folder rl-trained-agents/ -n 100000 --tensorboard-log logs_enjoy --render-mode=episode --env-kwargs render_before_reset:True
# python3 enjoy2.py --algo sac --env JSBSim-v6 --folder rl-trained-agents/ -n 100000 --tensorboard-log logs_enjoy --render-mode=episode --env-kwargs render_before_reset:True
# python3 enjoy2.py --algo sac --env JSBSim-v7 --folder rl-trained-agents/ -n 100000 --tensorboard-log logs_enjoy --render-mode=episode --env-kwargs render_before_reset:True
# python3 enjoy2.py --algo sac --env JSBSim-v8 --folder rl-trained-agents/ -n 100000 --tensorboard-log logs_enjoy --render-mode=episode --env-kwargs render_before_reset:True
# python3 enjoy2.py --algo sac --env JSBSim-v9 --folder rl-trained-agents/ -n 100000 --tensorboard-log logs_enjoy --render-mode=episode --env-kwargs render_before_reset:True
# python3 enjoy2.py --algo sac --env JSBSim-v10 --folder rl-trained-agents/ -n 100000 --tensorboard-log logs_enjoy --render-mode=episode --env-kwargs render_before_reset:True
# python3 enjoy2.py --algo sac --env JSBSim-v11 --folder rl-trained-agents/ -n 100000 --tensorboard-log logs_enjoy --render-mode=episode --env-kwargs render_before_reset:True
# python3 enjoy2.py --algo sac --env JSBSim-v12 --folder rl-trained-agents/ -n 100000 --tensorboard-log logs_enjoy --render-mode=episode --env-kwargs render_before_reset:True
# python3 enjoy2.py --algo sac --env JSBSim-v13 --folder rl-trained-agents/ -n 100000 --tensorboard-log logs_enjoy --render-mode=episode --env-kwargs render_before_reset:True
# python3 enjoy2.py --algo sac --env JSBSim-v14 --folder rl-trained-agents/ -n 100000 --tensorboard-log logs_enjoy --render-mode=episode --env-kwargs render_before_reset:True
# python3 enjoy2.py --algo sac --env JSBSim2D-v0 --folder rl-trained-agents/ -n 100000 --tensorboard-log logs_enjoy --render-mode=episode --env-kwargs render_before_reset:True
# python3 enjoy2.py --algo sac --env JSBSim2D-v1 --folder rl-trained-agents/ -n 100000 --tensorboard-log logs_enjoy --render-mode=episode --env-kwargs render_before_reset:True
# python3 enjoy2.py --algo sac --env JSBSim2D-v2 --folder rl-trained-agents/ -n 100000 --tensorboard-log logs_enjoy --render-mode=episode --env-kwargs render_before_reset:True
# python3 enjoy2.py --algo sac --env JSBSim2D-v3 --folder rl-trained-agents/ -n 100000 --tensorboard-log logs_enjoy --render-mode=episode --env-kwargs render_before_reset:True
# python3 enjoy2.py --algo sac --env JSBSim2D-v4 --folder rl-trained-agents/ -n 100000 --tensorboard-log logs_enjoy --render-mode=episode --env-kwargs render_before_reset:True
# python3 enjoy2.py --algo sac --env JSBSim2D-v5 --folder rl-trained-agents/ -n 100000 --tensorboard-log logs_enjoy --render-mode=episode --env-kwargs render_before_reset:True


#python3 train.py --algo sac --env JSBSim-v0 -n 100000 -optimize --n-trials 1000 --sampler random --pruner median --tensorboard-log ./tensorboard/
