#!/bin/bash
SECONDS=0 
python3 train.py --algo sac --env JSBSim-v6 -n 1000000 --eval-freq 10000 --save-freq 50000 --tensorboard-log logs --hyperparams learning_starts:5000
python3 train.py --algo sac --env JSBSim-v6 -n 1000000 --eval-freq 10000 --save-freq 50000 --tensorboard-log logs --hyperparams learning_starts:2500
python3 train.py --algo sac --env JSBSim-v6 -n 1000000 --eval-freq 10000 --save-freq 50000 --tensorboard-log logs --hyperparams learning_starts:1250
python3 train.py --algo sac --env JSBSim-v6 -n 1000000 --eval-freq 10000 --save-freq 50000 --tensorboard-log logs --hyperparams learning_starts:625
python3 train.py --algo sac --env JSBSim-v6 -n 1000000 --eval-freq 10000 --save-freq 50000 --tensorboard-log logs --hyperparams learning_starts:0
echo Laufzeit: $SECONDS Sekunden
