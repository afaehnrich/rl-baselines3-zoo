#!/bin/sh
docker run --mount src=$(pwd)/../../rl-baselines3-zoo/logs,target=/root/code/rl-baselines3-zoo/logs,type=bind \
			--mount src=$(pwd)/../../rl-baselines3-zoo/rl-trained-agents,target=/root/code/rl-baselines3-zoo/rl-trained-agents,type=bind \
			--mount src=%$(pwd)/../../rl-baselines3-zoo/logs_enjoy,target=/root/code/rl-baselines3-zoo/logs_enjoy,type=bind \
       afaehnrich/deep-glide-custom-zoo:latest python3 enjoy2.py --algo sac --env JSBSim-v6 --folder rl-trained-agents/ -n 5000