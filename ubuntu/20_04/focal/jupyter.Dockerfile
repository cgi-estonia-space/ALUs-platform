FROM nvidia/cuda:11.4.2-devel-ubuntu20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN set -e

COPY setup_runtime.sh .
RUN ./setup_runtime.sh

COPY setup_aux_tools.sh .
RUN ./setup_aux_tools.sh

RUN apt -y install curl wget unzip

RUN mkdir alus
ENV VIRTUAL_ENV=/alus/venv
# No need to call activate/deactivate, $VIRTUAL_ENV path precedes system ones.
# See - https://pythonspeed.com/articles/activate-virtualenv-dockerfile/
ENV PATH="/alus:$VIRTUAL_ENV/bin:${PATH}"

RUN python3 -m venv $VIRTUAL_ENV
RUN cd alus && curl -s https://api.github.com/repos/cgi-estonia-space/ALUs/releases/latest | grep "browser_download_url" | cut -d : -f 2,3 | tr -d \" | wget -qi - \
    && unzip alus*.zip && mv alus-*/* .
RUN pip install --upgrade setuptools
RUN pip install wheel
RUN pip install validators
RUN cd alus && pip install -r jupyter-notebook/requirements.txt
RUN cd alus && rm alus-*.zip

