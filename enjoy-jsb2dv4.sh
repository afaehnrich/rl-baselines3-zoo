#!/bin/bash

python3 enjoy2.py --algo sac --env JSBSim2D-v4 --folder rl-trained-agents/ -n 100000 --tensorboard-log logs_enjoy --render-mode=episode --env-kwargs render_before_reset:True
# python3 enjoy.py --algo sac --env JSBSim2D-v0 --folder rl-trained-agents/ -n 5000

#python3 train.py --algo sac --env JSBSim-v0 -n 100000 -optimize --n-trials 1000 --sampler random --pruner median --tensorboard-log ./tensorboard/