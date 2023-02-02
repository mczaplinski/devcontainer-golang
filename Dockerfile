FROM debian:bookworm-slim

LABEL \
    org.opencontainers.image.title="Golang Dev Container" \
    org.opencontainers.image.description="Golang Dev Container for VSCode remote development" \
    org.opencontainers.image.url="https://github.com/mczaplinski/devcontainer-golang" \
    org.opencontainers.image.documentation="https://github.com/mczaplinski/devcontainer-golang" \
    org.opencontainers.image.source="https://github.com/mczaplinski/devcontainer-golang" \
    org.opencontainers.image.authors="marcel.czaplinski@gmx.de" \
    org.opencontainers.image.version="1.0.0"
# org.opencontainers.image.created=$CREATED \
# org.opencontainers.image.revision=$COMMIT \

# Experimental: Let's not have root access but still add the user to sudoers
# ARG USERNAME=code
# ARG USER_UID=1000
# ARG USER_GID=$USER_UID
# RUN groupadd --gid $USER_GID $USERNAME \
#     && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
#     && apt-get update \
#     && apt-get install -y sudo \
#     && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
#     && chmod 0440 /etc/sudoers.d/$USERNAME

# Install packages
RUN apt-get update -y  && \
    # System packages
    apt-get install -y --no-install-recommends nano locales wget && \
    # RUN apt-get install -y --no-install-recommends zsh
    apt-get install -y --no-install-recommends tzdata && \
    apt-get install -y --no-install-recommends ca-certificates && \
    # Development packages
    apt-get install -y --no-install-recommends git git-man git-lfs man openssh-client less && \
    # Clean up apt
    apt-get autoremove -y  && \
    apt-get clean -y  && \
    rm -r /var/cache/* /var/lib/apt/lists/*

# zsh with plugins with spaceship prompt
RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.1/zsh-in-docker.sh)" -- \
    -t robbyrussell \
    # -t https://github.com/denysdovhan/spaceship-prompt \
    -a 'SPACESHIP_PROMPT_ADD_NEWLINE="false"' \
    -a 'SPACESHIP_PROMPT_SEPARATE_LINE="false"' \
    -p git \
    -p https://github.com/zsh-users/zsh-autosuggestions \
    -p https://github.com/zsh-users/zsh-completions \
    -p https://github.com/zsh-users/zsh-history-substring-search \
    -p https://github.com/zsh-users/zsh-syntax-highlighting \
    -p 'history-substring-search' \
    -a 'bindkey "\$terminfo[kcuu1]" history-substring-search-up' \
    -a 'bindkey "\$terminfo[kcud1]" history-substring-search-down'

# RUN usermod --shell /bin/zsh root

# Install go using wget
ENV GOLANG_VERSION 1.20
ENV GOLANG_DOWNLOAD_URL https://go.dev/dl/go$GOLANG_VERSION.linux-amd64.tar.gz

RUN wget -q $GOLANG_DOWNLOAD_URL -O /tmp/golang.tar.gz && \
    tar -C /usr/local -xzf /tmp/golang.tar.gz && \
    rm /tmp/golang.tar.gz

ENV PATH $PATH:/usr/local/go/bin

# set GOPRIVATE to avoid proxying for private repositories
ENV GOPRIVATE=github.com

# Install go tools
# TODO:

# Install golangci-lint
# TODO


ENTRYPOINT [ "/bin/zsh" ]
