#!/bin/bash

python3 train.py --algo sac --env JSBSim-v3 -n 1000000 --eval-freq 10000 --save-freq 50000 --tensorboard-log logs

#python3 train.py --algo sac --env JSBSim-v0 -n 100000 -optimize --n-trials 1000 --sampler random --pruner median --tensorboard-log ./tensorboard/
