FROM gabrieldeblois/mljupylab:latest

COPY ./requirements.txt .
RUN pip install -r requirements.txt
RUN rm -f requirements.txt

# running root commands
USER root
RUN sudo ln -s /usr/local/cuda-10.2/targets/x86_64-linux/lib/libcudart.so.10.2 /usr/lib/x86_64-linux-gnu/libcudart.so.10.1
RUN apt-get update && apt-get upgrade -y

# passing to jovyan user
USER jovyan
WORKDIR /home/jovyan/work

ENV PYTHONPATH /home/jovyan/work
