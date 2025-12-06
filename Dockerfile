FROM n8nio/runners:1.121.1

# Build steps run as root in this image; create venv and install yt-dlp.
USER root

RUN python3 -m venv /opt/runner-venv \
 && /opt/runner-venv/bin/pip install --upgrade pip yt-dlp \
 && chown -R node:node /opt/runner-venv || chown -R 1000:1000 /opt/runner-venv || true

USER 1000

WORKDIR /home/runner