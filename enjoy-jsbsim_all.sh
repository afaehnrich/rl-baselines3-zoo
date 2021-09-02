#!/bin/bash

sh enjoy-jsb.sh JSBSim-v0 &
sh enjoy-jsb.sh JSBSim-v5 &
sh enjoy-jsb.sh JSBSim-v6 &
sh enjoy-jsb.sh JSBSim-v9
wait

sh enjoy-jsb.sh JSBSim-v13 &
sh enjoy-jsb.sh JSBSim-v14 &
sh enjoy-jsb.sh JSBSim2D-v0 &
sh enjoy-jsb.sh JSBSim2D-v1
wait

# sh enjoy-jsb.sh JSBSim2D-v2 &
# sh enjoy-jsb.sh JSBSim2D-v3 &
# sh enjoy-jsb.sh JSBSim2D-v4
# wait

sh enjoy-jsb.sh JSBSim-v6 rl-trained-agents sde_ep_warmup &
sh enjoy-jsb.sh JSBSim-v6 rl-trained-agents sde_16_warmup &
sh enjoy-jsb.sh JSBSim-v6 rl-trained-agents sde_32_warmup &
sh enjoy-jsb.sh JSBSim-v6 rl-trained-agents sde_64_warmup
wait

sh enjoy-jsb.sh JSBSim-v6 rl-trained-agents sde_8_warmup &
sh enjoy-jsb.sh JSBSim-v6 rl-trained-agents nosde
wait

#python3 train.py --algo sac --env JSBSim-v0 -n 100000 -optimize --n-trials 1000 --sampler random --pruner median --tensorboard-log ./tensorboard/
