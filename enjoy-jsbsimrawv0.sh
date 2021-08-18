#!/bin/bash

python3 enjoy.py --algo sac --env JSBSimRaw-v0 --folder rl-trained-agents/ -n 5000

#python3 train.py --algo sac --env JSBSim-v0 -n 100000 -optimize --n-trials 1000 --sampler random --pruner median --tensorboard-log ./tensorboard/
