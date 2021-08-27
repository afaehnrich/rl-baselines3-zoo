#!/bin/bash

python3 enjoy2.py --algo sac --env JSBSim-v3 --folder rl-trained-agents/ -n 100000 --render-mode=episode --tensorboard-log logs_enjoy --env-kwargs render_before_reset:True

#python3 train.py --algo sac --env JSBSim-v0 -n 100000 -optimize --n-trials 1000 --sampler random --pruner median --tensorboard-log ./tensorboard/
