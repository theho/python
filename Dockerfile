FROM python:3.14.0-slim-trixie

# Update and upgrade apt packages
RUN apt-get update -y
RUN apt-get upgrade -y

# Install necessary packages
RUN apt install sudo curl pipx postgresql-client net-tools git build-essential clang curl zsh vim -y

ENV PATH="${PATH}:/root/.local/bin"


# install zsh and set as default shell
RUN apt-get install -y zsh && \
    chsh -s $(which zsh) root && \
    rm -rf /var/lib/apt/lists/*

# Install Oh My Zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Create a basic .zshrc in /etc/skel
RUN echo "export EDITOR=vim" > /etc/skel/.zshrc && \
    echo "source ~/.oh-my-zsh/oh-my-zsh.sh" >> /etc/skel/.zshrc # If using Oh My Zsh
# Set Zsh as the default shell for new users
RUN echo "SHELL=/bin/zsh" >> /etc/default/useradd # or similar for your base image

# Instal Rust
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"
RUN rustc --version
RUN cargo --version

# Install useful Python tools
RUN pipx install uv
RUN pipx install ruff

# Create coder user with sudo privileges and zsh as default shell
RUN useradd -m -s /bin/zsh -G sudo coder
USER coder