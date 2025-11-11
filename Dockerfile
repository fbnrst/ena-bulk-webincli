FROM ubuntu:24.04

# Install packages and download Webin-CLI
RUN apt update && \
    apt install -y --no-install-recommends curl default-jre python3.12 python3-pandas python3-joblib && \
    curl -s https://api.github.com/repos/enasequence/webin-cli/releases/latest \
    | grep "browser_download_url" \
    | cut -d : -f 2,3 \
    | tr -d \" \
    | xargs curl -L -o webin-cli.jar && \
    chmod 554 webin-cli.jar && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY bulk_webincli.py bulk_webincli.py
RUN chmod 554 bulk_webincli.py

# Set working directory to volume where data is housed
WORKDIR /workdir

ENTRYPOINT ["python3", "/bulk_webincli.py"]
