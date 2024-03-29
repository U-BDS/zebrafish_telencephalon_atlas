FROM rocker/shiny-verse:4.3.1

LABEL maintainer="Lara Ianov <lianov@uab.edu>"
LABEL description="Dockerized zebrafish telencephalon atlas app"

#ignores conda install prompt from reticulate to keep log cleaner
COPY ./.Renviron /home/shiny/.Renviron

#custom server config:
COPY ./shiny_customized.config /etc/shiny-server/shiny-server.conf

RUN apt-get update && apt-get install -y \
    libhdf5-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libpng-dev \
    libboost-all-dev \
    libxml2-dev \
    openjdk-8-jdk \
    python3-dev \
    python3-pip \
    wget \
    git \
    libfftw3-dev \
    libgsl-dev \
    libbz2-dev \
    liblzma-dev \
    g++ \
    gcc \
    libglpk-dev \
    software-properties-common && add-apt-repository -y ppa:git-core/ppa

# main targets
RUN R -e "install.packages('plotly')"
RUN R -e "install.packages('markdown')"
RUN R -e "install.packages('shinyjs')"
RUN R -e "install.packages('cowplot')"
RUN R -e "install.packages('shinyhelper')"
RUN R -e "install.packages('shinycssloaders')"
RUN R -e "install.packages('dplyr')"
RUN R -e "install.packages('bslib')"
RUN R -e "remotes::install_github('bnprks/BPCells')"

# Seurat V5 (beta for now)
RUN R -e "remotes::install_github('satijalab/seurat', 'seurat5')"

# port container listens to (default R Shiny port)
EXPOSE 3838

# allow permission
RUN sudo chown -R shiny:shiny /srv/shiny-server
RUN sudo chown -R shiny:shiny /var/log/shiny-server/

# remove sample index and apps:
RUN sudo rm /srv/shiny-server/index.html
RUN sudo rm -rf /srv/shiny-server/sample-apps

# Set environment variable to allow shiny server code to output to
# STDOUT and STDERR
ENV SHINY_LOG_STDERR=1

# this container will already have the app with the data
# to make launching the app as straight-forward as possible since
# we are not hosting the app in an external server.
# Mounting being the alternative and more common, but attempting to avoid
# multiple steps for users (to have to download data separately...)
COPY ./zebrafish_telencephalon_atlas_app /srv/shiny-server/

#exec form for wildcards...
RUN ["/bin/bash", "-c", "sudo rm -rf /srv/shiny-server/{0*,1*}_*"]

# run app
CMD ["/usr/bin/shiny-server"]
