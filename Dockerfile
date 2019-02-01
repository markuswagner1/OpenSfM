FROM paulinus/opensfm-docker-base:opencv3

RUN apt-get update && \
    apt-get install -y linux-tools-generic && \
    ln -s --force /usr/lib/linux-tools/*/perf /usr/bin/perf

RUN apt-get install cpio

COPY vtune/* /tmp/

RUN cd /tmp && \
    tar xf vtune_amplifier_2019_update1.tar.gz && \
    cd vtune_amplifier_2019_update1 && \
    ./install.sh -s ../silent.cfg

COPY . /source/OpenSfM

WORKDIR /source/OpenSfM

RUN pip install -r requirements.txt && \
    python setup.py build
