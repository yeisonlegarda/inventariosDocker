FROM node:10.16.0

ARG USER_ID

RUN apt-get update && apt-get install -y sudo

RUN export uid=$USER_ID && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:0:developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:0 -R /home/developer
RUN npm install -g @angular/cli
RUN echo '{ "allow_root": true }' > /root/.bowerrc
USER developer
EXPOSE 4200
RUN git config --global user.name "developer"
RUN git config --global user.email "developer@email.com"

WORKDIR /workspace/angular
