FROM ubuntu:24.04

# Install packages
RUN apt update && \
    apt install -y curl wget default-jre python3.12 python3-pandas python3-joblib

# Install script and software dependencies
RUN echo "Downloading latest Webin-CLI..."
RUN curl -s https://api.github.com/repos/enasequence/webin-cli/releases/latest | grep "browser_download_url" | cut -d : -f 2,3 | tr -d \" | wget -qi -
RUN mv webin-cli-* webin-cli.jar
RUN echo "Downloading latest Webin-CLI... [COMPLETE]"

COPY bulk_webincli.py bulk_webincli.py
RUN chmod 554 bulk_webincli.py && chmod 554 webin-cli.jar

# Set working directory to volume where data is housed
WORKDIR /workdir

ENTRYPOINT ["python3", "/bulk_webincli.py"]
