FROM afaehnrich/deep-glide:latest

WORKDIR ${CODE_DIR}

# kompatible Versionen von stable-baselines3 und rl-baselines3-zoo von Git holen. Sonst gibts Fehlermeldung.
RUN pip install xlsxwriter
RUN pip uninstall -y sb3-contrib
RUN rm -r stable-baselines3
RUN pip install sb3-contrib==1.0 stable-baselines3==1.1.0a3
RUN rm -r rl-baselines3-zoo
ADD . ${CODE_DIR}/rl-baselines3-zoo
# environment registration für die eigenen environemnts in rl-zoo integrieren
# RUN cp -v -rt ${CODE_DIR}/rl-baselines3-zoo ${CODE_DIR}/deep-glide/rl_zoo/*
# deep-glide als Python-Modul installieren
WORKDIR ${CODE_DIR}/rl-baselines3-zoo
RUN mkdir -p logs
RUN mkdir -p logs_enjoy
# RUN mkdir -p rl-trained-agents
CMD /bin/bash
