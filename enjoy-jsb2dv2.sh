#!/bin/bash

python3 enjoy2.py --algo sac --env JSBSim2D-v2 --folder rl-trained-agents/ -n 100000 --tensorboard-log --render-mode=episode --env-kwargs render_before_reset:True
