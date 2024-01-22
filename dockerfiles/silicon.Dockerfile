# Latest image from rocker: https://rocker-project.org/
FROM --platform=linux/arm64 rocker/rstudio:latest

RUN apt-get clean all && \
    apt-get update && \
    apt-get upgrade -y

# Install R packages
RUN install-silicon.sh

COPY --chown=rstudio:rstudio rstudio-prefs.json \
  /home/rstudio/.config/rstudio

COPY --chown=rstudio:rstudio .Rprofile /home/rstudio/

EXPOSE 8787

WORKDIR /home/rstudio

[/init]
