FROM n8nio/runners:1.121.1

# Build steps run as root in this image; create venv, install ffmpeg, and install yt-dlp.
USER root

# Install FFmpeg
RUN command -v apk >/dev/null && apk add --no-cache ffmpeg || (apt-get update && apt-get install -y ffmpeg)

RUN python3 -m venv /opt/runner-venv \
 && /opt/runner-venv/bin/pip install --upgrade pip yt-dlp \
 && chown -R node:node /opt/runner-venv || chown -R 1000:1000 /opt/runner-venv || true

RUN mkdir -p /data/shared && chown -R 1000:1000 /data/shared

USER 1000

WORKDIR /home/runner
