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
ENV PATH /usr/local/src/pysmurf_utils:${PATH}

# By default EPICS is configured with 'EPICS_CA_AUTO_ADDR_LIST=YES'
# which will cause problems is we have multiple NIC, so let's set it
# to use localhost only for now
ENV EPICS_CA_AUTO_ADDR_LIST NO
ENV EPICS_CA_ADDR_LIST localhost

# Default EPICS prefix value
ENV EPICS_PREFIX "smurf_server"

ENTRYPOINT ["pysmurf_startup.sh"]