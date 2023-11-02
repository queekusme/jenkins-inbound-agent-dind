FROM jenkins/inbound-agent:latest
USER root
RUN apt-get update
RUN apt-get -y install ca-certificates curl gnupg
RUN install -m 0755 -d /etc/apt/keyrings
RUN sh -c 'curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg'
RUN chmod a+r /etc/apt/keyrings/docker.gpg
RUN sh -c 'echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  jammy stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null'
RUN apt-get update
RUN apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
USER jenkins
CMD [ "dockerd" ]