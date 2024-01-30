FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt upgrade -y
RUN apt install sudo -y
RUN apt-get -y update && apt-get install -y --no-install-recommends \
         curl \
         gnupg apt-transport-https \
         wget \
         python3 \
         nginx \
         ca-certificates \
&& rm -rf /var/lib/apt/lists/*
RUN wget https://bootstrap.pypa.io/get-pip.py && python3 get-pip.py

RUN apt-get install curl gnupg apt-transport-https -y 
RUN curl -1sLf "https://keys.openpgp.org/vks/v1/by-fingerprint/0A9AF2115F4687BD29803A206B73A36E6026DFCA" | sudo gpg --dearmor | sudo tee /usr/share/keyrings/com.rabbitmq.team.gpg > /dev/null && \
    curl -1sLf "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xf77f1eda57ebb1cc" | sudo gpg --dearmor | sudo tee /usr/share/keyrings/net.launchpad.ppa.rabbitmq.erlang.gpg > /dev/null && \
    curl -1sLf "https://packagecloud.io/rabbitmq/rabbitmq-server/gpgkey" | sudo gpg --dearmor | sudo tee /usr/share/keyrings/io.packagecloud.rabbitmq.gpg > /dev/null && \
    apt-get update -y
RUN pip install --upgrade pip

##########Edited

# Update the package lists and install software
RUN apt update && apt upgrade -y && \
    apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:graphics-drivers/ppa && \
    apt update -y && \
    apt install nvidia-driver-530 -y && \
    apt install wget curl -y && \
    apt install python3-pip -y
#################

#########   Edited

#RUN pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118 && \
RUN pip3 install torch==2.1.1 && \
    pip3 install torchvision==0.16.1 && \
    pip3 install torchaudio && \
    apt install nvidia-cuda-toolkit -y && \
    pip install cupy-cuda12x && \
    pip install thinc[torch] --no-cache-dir && \
    pip install spacy==3.6.1 --no-cache-dir && \
    pip install spacy-transformers==1.2.4 --no-cache-dir && \
    python3 -m spacy download "en_core_web_trf" && \
    python3 -m spacy download "en_core_web_md" && \
    python3 -m cupyx.tools.install_library --cuda 12.x --library cutensor && \
    pip install pika==1.3.2 && \
    pip install flower

#Installing Nvidia-container Toolkit
RUN curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
&& curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    tee /etc/apt/sources.list.d/nvidia-container-toolkit.list \
&& \
    apt-get update
RUN apt-get install -y nvidia-container-toolkit
RUN nvidia-ctk runtime configure --runtime=docker
RUN pip install numpy

#################################################################################################


COPY . /app
WORKDIR /app

# Run your Python script
#CMD ["bash", "-c", "rabbitmq-server & /opt/program/rclone.sh & /opt/program/dockerrun.sh"]
CMD ["celery", "-A", "celery_tasks", "worker", "--loglevel=info"]
