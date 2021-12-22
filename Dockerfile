# docker build -t qgis_pp -f Dockerfile_pp .
# docker run -v ${pwd}:/data -it --rm --name qgis_cont -d qgis_pp

# Qgis 3.23.0
FROM qgis/qgis:latest

COPY NRCan-RootCA.cer /usr/local/share/ca-certificates/NRCan-RootCA.crt
RUN chmod 644 /usr/local/share/ca-certificates/NRCan-RootCA.crt && update-ca-certificates

ENV QT_QPA_PLATFORM="offscreen"

RUN git clone --depth=1 https://github.com/NRCan/geo_sim_processing.git -b master /root/.local/share/QGIS/QGIS3/profiles/default/python/plugins/geo_sim_processing \
	&& qgis_process plugins enable geo_sim_processing \
	&& qgis_process plugins enable grassprovider \
	&& qgis_process plugins enable processing

RUN git clone --depth=1 https://gccode.ssc-spc.gc.ca/geobase/innovation-ai/inference_postprocessing.git -b master \
    /root/.local/share/QGIS/QGIS3/profiles/default/processing/models