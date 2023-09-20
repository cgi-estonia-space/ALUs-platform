FROM nvidia/cuda:11.2.2-devel-ubi8

COPY setup_runtime.sh /tmp/
COPY setup_devel.sh /tmp/

RUN /tmp/setup_runtime.sh
RUN /tmp/setup_devel.sh

RUN mkdir /alus
RUN git clone https://github.com/cgi-estonia-space/skript && mv skript /alus/.
RUN cd /alus/skript && python3 -m venv venv && pip3 install -r requirements.txt
RUN git clone https://github.com/cgi-estonia-space/rastcomp && mv rastcomp /alus/.
RUN cd /alus/rastcomp && cmake -B build . && cd build && make
RUN ln -s /alus/rastcomp/build/rastcomp /usr/bin/rastcomp
RUN ln -s /alus/rastcomp/build/rastcomp/gdal_compare/rast_compare.py /usr/bin/rast_compare.py

RUN rm /tmp/setup_runtime.sh
RUN rm /tmp/setup_devel.sh
