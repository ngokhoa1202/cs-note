# Use a lightweight base
FROM debian:bookworm

# Prevent apt from asking questions
ENV DEBIAN_FRONTEND=noninteractive

# 1. Install standard tools and the "dependency hell" required for Electron apps
# (libnss3, libatk, libgbm, etc. are all required for the GUI to render)
RUN apt-get update && apt-get install -y \
    wget \
    ca-certificates \
    libnss3 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libgbm1 \
    libasound2 \
    libpangocairo-1.0-0 \
    libxss1 \
    libgtk-3-0 \
    libx11-xcb1 \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*
# RUN sudo update-ca-trust

# 2. Download Obsidian (Update version number as needed)
ARG VERSION=1.8.7
RUN wget "https://github.com/obsidianmd/obsidian-releases/releases/download/v${VERSION}/obsidian_${VERSION}_amd64.deb" -O obsidian.deb

# 3. Install it using apt (better than dpkg because it resolves leftover dependencies)
RUN apt-get update && apt-get install -y ./obsidian.deb \
    && rm obsidian.deb \
    && rm -rf /var/lib/apt/lists/*

# 4. Create a non-root user (Good security practice)
RUN useradd -m -s /bin/bash obsidian_user
USER obsidian_user
WORKDIR /home/obsidian_user

# 5. The command to run
# --no-sandbox is often required for Electron inside Docker
CMD ["obsidian", "--no-sandbox"]
