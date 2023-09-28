# Start from an Ubuntu 20.04 base image
FROM ubuntu:20.04

# Set environment variables to non-interactive (this ensures that apt-get won't prompt for choices)
ENV DEBIAN_FRONTEND=non-interactive

COPY configure-cert.sh /opt/gophish/configure-cert.sh
COPY gophish.db /opt/gophish/gophish.db

# Update the package list and install necessary packages
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    certbot \
    nano

# Set the working directory
WORKDIR /opt/gophish

# Download and unzip GoPhish from GitHub
RUN wget https://github.com/gophish/gophish/releases/download/v0.12.1/gophish-v0.12.1-linux-64bit.zip \
    && unzip gophish-v0.12.1-linux-64bit.zip \
    && rm gophish-v0.12.1-linux-64bit.zip \
    && chmod +x /opt/gophish/gophish \
    && chmod +x /opt/gophish/configure-cert.sh

# Change the IP address in the config.json from 127.0.0.1 to 0.0.0.0
RUN sed -i 's/127.0.0.1/0.0.0.0/g' config.json

# Expose the necessary ports
EXPOSE 3333 80

WORKDIR /opt/gophish

# Command to run GoPhish when the container starts
#CMD ["./gophish"]
# This is used to keep the container running without having to first run gophish, since we need to update the ssl certs
CMD ["tail", "-f", "/dev/null"]
