FROM tidair/smurf-base:R0.0.0

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y \
    tzdata \
    python3-tk \
 && rm -rf /var/lib/apt/lists/*

RUN pip3 install scipy pandas matplotlib

WORKDIR /usr/local/src
RUN git clone https://github.com/slaclab/pysmurf.git
ENV PYTHONPATH /usr/local/src:${PYTHONPATH}

RUN mkdir -p /usr/local/src/pysmurf_utils
ADD scripts/* /usr/local/src/pysmurf_utils/

ENTRYPOINT ["ipython3", "-i", "/usr/local/src/pysmurf_utils/pysmurf_startup.py"]