FROM tidair/smurf-base:R0.0.0

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y \
    python3-gi \
    python3-gi-cairo \
    python3-cairocffi \
    gir1.2-gtk-3.0 \
    python3-matplotlib \
 && rm -rf /var/lib/apt/lists/*

RUN pip3 install scipy pandas

WORKDIR /usr/local/src
RUN git clone https://github.com/slaclab/pysmurf.git -b adding-hb
ENV PYTHONPATH /usr/local/src:${PYTHONPATH}
ENV PYSMURF_TOP /usr/local/src/pysmurf

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

# Set GTK3Agg as the matplotlib backend
ENV MPLBACKEND GTK3Agg

ENTRYPOINT ["pysmurf_startup.sh"]
