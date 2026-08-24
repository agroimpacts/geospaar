# Pinned for a consistent teaching environment. This tag is linux/amd64.
FROM rocker/geospatial:4.4.2

RUN apt-get clean all && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
        libv8-dev \
        build-essential \
        libcurl4-openssl-dev \
        libssl-dev \
        libxml2-dev && \
    rm -rf /var/lib/apt/lists/*

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
