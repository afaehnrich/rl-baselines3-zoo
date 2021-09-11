#!/bin/bash
python3 train.py --algo sac --env JSBSim2D-v4 -n 1000000 --eval-freq 10000 --save-freq 50000 --tensorboard-log logs --env-kwargs terrain:'"ocean"' range_angle:3.14
#python3 train.py --algo sac --env JSBSim2D-v4 -n 1000000 --eval-freq 10000 --save-freq 50000 --tensorboard-log logs --env-kwargs terrain:'"ocean"' range_angle:1.57
#python3 train.py --algo sac --env JSBSim2D-v4 -n 1000000 --eval-freq 10000 --save-freq 50000 --tensorboard-log logs --env-kwargs terrain:'"ocean"' range_angle:0.785
