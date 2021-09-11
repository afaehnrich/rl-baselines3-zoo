#!/bin/bash
python3 train.py --algo sac --env JSBSim2D-v4 -n 1000000 --eval-freq 10000 --save-freq 50000 --tensorboard-log logs --env-kwargs terrain:'"ocean"' range_angle:6.28
python3 train.py --algo sac --env JSBSim2D-v4 -n 1000000 --eval-freq 10000 --save-freq 50000 --tensorboard-log logs --env-kwargs terrain:'"ocean"' range_angle:3.14
#python3 train.py --algo sac --env JSBSim2D-v4 -n 1000000 --eval-freq 10000 --save-freq 50000 --tensorboard-log logs --env-kwargs terrain:'"ocean"' range_angle:1.57
#python3 train.py --algo sac --env JSBSim2D-v4 -n 1000000 --eval-freq 10000 --save-freq 50000 --tensorboard-log logs --env-kwargs terrain:'"ocean"' range_angle:0.785
python3 train.py --algo sac --env JSBSim2D-v2 -n 1000000 --eval-freq 10000 --save-freq 50000 --tensorboard-log logs --hyperparams policy_kwargs:"dict(log_std_init=-3, net_arch=[2048, 512, 128])"
python3 train.py --algo sac --env JSBSim2D-v2 -n 1000000 --eval-freq 10000 --save-freq 50000 --tensorboard-log logs --hyperparams policy_kwargs:"dict(log_std_init=-3, net_arch=[1024, 256, 64])"
python3 train.py --algo sac --env JSBSim2D-v2 -n 1000000 --eval-freq 10000 --save-freq 50000 --tensorboard-log logs --hyperparams policy_kwargs:"dict(log_std_init=-3, net_arch=[512, 128, 32])"
python3 train.py --algo sac --env JSBSim-v6 -n 1000000 --eval-freq 10000 --save-freq 50000 --tensorboard-log logs --hyperparams learning_starts:2500
#tensorboard --logdir logs_enjoy --host 0.0.0.0 --port 5006
#tensorboard --logdir logs --host 0.0.0.0 --port 6006

