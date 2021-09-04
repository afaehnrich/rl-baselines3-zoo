#!/bin/bash
SECONDS=0 

python3 train.py --algo sac --env JSBSim2D-v2 -n 1000000 --eval-freq 10000 --save-freq 50000 --tensorboard-log logs --hyperparams policy_kwargs:"dict(log_std_init=-3, net_arch=[64, 32])"
#python3 train.py --algo sac --env JSBSim2D-v2 -n 1000000 --eval-freq 10000 --save-freq 50000 --tensorboard-log logs --hyperparams policy_kwargs:"dict(log_std_init=-3, net_arch=[400, 300])" &
python3 train.py --algo sac --env JSBSim2D-v2 -n 1000000 --eval-freq 10000 --save-freq 50000 --tensorboard-log logs --hyperparams policy_kwargs:"dict(log_std_init=-3, net_arch=[256, 64])" &
python3 train.py --algo sac --env JSBSim2D-v2 -n 1000000 --eval-freq 10000 --save-freq 50000 --tensorboard-log logs --hyperparams policy_kwargs:"dict(log_std_init=-3, net_arch=[1024, 256])" &
python3 train.py --algo sac --env JSBSim2D-v2 -n 1000000 --eval-freq 10000 --save-freq 50000 --tensorboard-log logs --hyperparams policy_kwargs:"dict(log_std_init=-3, net_arch=[2048, 512])"
wait

python3 train.py --algo sac --env JSBSim2D-v2 -n 1000000 --eval-freq 10000 --save-freq 50000 --tensorboard-log logs --hyperparams policy_kwargs:"dict(log_std_init=-3, net_arch=[4096, 1024, 256])" &
python3 train.py --algo sac --env JSBSim2D-v2 -n 1000000 --eval-freq 10000 --save-freq 50000 --tensorboard-log logs --hyperparams policy_kwargs:"dict(log_std_init=-3, net_arch=[2048, 512, 128])" &
python3 train.py --algo sac --env JSBSim2D-v2 -n 1000000 --eval-freq 10000 --save-freq 50000 --tensorboard-log logs --hyperparams policy_kwargs:"dict(log_std_init=-3, net_arch=[1024, 256, 64])" &
python3 train.py --algo sac --env JSBSim2D-v2 -n 1000000 --eval-freq 10000 --save-freq 50000 --tensorboard-log logs --hyperparams policy_kwargs:"dict(log_std_init=-3, net_arch=[512, 128, 32])" &
wait

echo Laufzeit: $SECONDS Sekunden

#python3 train.py --algo sac --env JSBSim-v0 -n 100000 -optimize --n-trials 1000 --sampler random --pruner median --tensorboard-log ./tensorboard/
