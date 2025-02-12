# Base RStudio image
FROM rocker/rstudio:4.4.2

# Switch to root to install dependencies
USER root

# Ensure necessary dependencies are installed
RUN apt-get update && apt-get install -y \
    libssl-dev libcurl4-openssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Install remotes and cowsay package with a pinned version
RUN Rscript -e 'install.packages("remotes", repos="https://cloud.r-project.org")'
RUN Rscript -e 'remotes::install_version("cowsay", version = "0.8.0", repos = "https://cloud.r-project.org")'

# Grant correct permissions to the necessary directories
RUN chmod -R 777 /home/rstudio /var/run /etc/s6 /usr/local/lib/R/etc

# Switch back to rstudio user
USER rstudio

# Set working directory
WORKDIR /home/rstudio

# Default command to start RStudio Server
CMD ["/init"]

# Version 1.1 update
# Version 1.2 update
