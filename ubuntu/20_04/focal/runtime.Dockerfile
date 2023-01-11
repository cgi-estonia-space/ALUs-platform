FROM nvidia/cuda:11.4.2-devel-ubuntu20.04

# for tzdata installation - https://askubuntu.com/questions/909277/avoiding-user-interaction-with-tzdata-when-installing-certbot-in-a-docker-contai
ENV DEBIAN_FRONTEND=noninteractive

COPY setup_runtime.sh .
RUN ./setup_runtime.sh
