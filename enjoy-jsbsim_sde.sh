#!/bin/bash

./enjoy-jsb.sh JSBSim-v6 rl-trained-agents sde_8_nowarmup
./enjoy-jsb.sh JSBSim-v6 rl-trained-agents sde_16_nowarmup
./enjoy-jsb.sh JSBSim-v6 rl-trained-agents sde_32_nowarmup
./enjoy-jsb.sh JSBSim-v6 rl-trained-agents sde_64_nowarmup


# ./enjoy-jsb.sh JSBSim-v6 rl-trained-agents sde_8_warmup
# ./enjoy-jsb.sh JSBSim-v6 rl-trained-agents sde_16_warmup
# ./enjoy-jsb.sh JSBSim-v6 rl-trained-agents sde_32_warmup
# ./enjoy-jsb.sh JSBSim-v6 rl-trained-agents sde_64_warmup
# ./enjoy-jsb.sh JSBSim-v6 rl-trained-agents sde_ep_warmup
# ./enjoy-jsb.sh JSBSim-v6 rl-trained-agents nosde

#python3 train.py --algo sac --env JSBSim-v0 -n 100000 -optimize --n-trials 1000 --sampler random --pruner median --tensorboard-log ./tensorboard/
