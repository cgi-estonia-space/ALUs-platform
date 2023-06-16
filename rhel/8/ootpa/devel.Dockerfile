FROM nvidia/cuda:11.2.2-devel-ubi8

COPY setup_runtime.sh /tmp/
COPY setup_devel.sh /tmp/

RUN /tmp/setup_runtime.sh
RUN /tmp/setup_devel.sh

RUN rm /tmp/setup_runtime.sh
RUN rm /tmp/setup_devel.sh

