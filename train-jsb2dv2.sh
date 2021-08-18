#!/bin/bash
SECONDS=0 
python3 train.py --algo sac --env JSBSim2D-v2 -n 1000000 --eval-freq 10000 --save-freq 50000 --tensorboard-log logs
echo Laufzeit: $SECONDS Sekunden

#python3 train.py --algo sac --env JSBSim-v0 -n 100000 -optimize --n-trials 1000 --sampler random --pruner median --tensorboard-log ./tensorboard/
