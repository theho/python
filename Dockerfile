FROM python:3.14.0-slim-trixie

# Update and upgrade apt packages
RUN apt-get update -y
RUN apt-get upgrade -y

# Install necessary packages
RUN apt install sudo curl pipx postgresql-client net-tools git build-essential clang curl -y

# install zsh and set as default shell
RUN apt-get install -y zsh && \
    chsh -s $(which zsh) root && \
    rm -rf /var/lib/apt/lists/*

ENV PATH="${PATH}:/root/.local/bin"

# Install Oh My Zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Instal Rust
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"
RUN rustc --version
RUN cargo --version

# Install useful Python tools
RUN pipx install uv
RUN pipx install ruff

RUN useradd -m -s /bin/bash -G sudo coder
