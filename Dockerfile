# Latest image from rocker: https://rocker-project.org/
FROM rocker/geospatial:4.3.2

RUN apt-get clean all && \
    apt-get update && \
    apt-get upgrade -y

# Install R packages
RUN install2.r --error \
    rmapshaper \
    patchwork \
    kableExtra \
    prettydoc \
    cowplot \
    here \
    rmdformats

COPY --chown=rstudio:rstudio rstudio-prefs.json \
  /home/rstudio/.config/rstudio

COPY --chown=rstudio:rstudio .Rprofile /home/rstudio/

EXPOSE 8787

WORKDIR /home/rstudio
