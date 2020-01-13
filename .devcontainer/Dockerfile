# ,-----.                              ,--.                                     
# |  |) /_   ,--,--.  ,---.   ,---.    |  | ,--,--,--.  ,--,--.  ,---.   ,---.  
# |  .-.  \ ' ,-.  | (  .-'  | .-. :   |  | |        | ' ,-.  | | .-. | | .-. : 
# |  '--' / \ '-'  | .-'  `) \   --.   |  | |  |  |  | \ '-'  | ' '-' ' \   --. 
# `------'   `--`--' `----'   `----'   `--' `--`--`--'  `--`--' .`-  /   `----' 
#                                                               `---'         
FROM crystallang/crystal:0.31.1 AS base

# Packages
RUN apt-get update && apt-get install -y --no-install-recommends \
  libgconf-2-4 \
  build-essential \
  libreadline-dev \
  libevent-dev \
  libssl-dev \
  libxml2-dev \
  libyaml-dev \
  libgmp-dev \
  # Cleanup leftovers
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# ,------.                              ,--.                                               ,--.   
# |  .-.  \   ,---.  ,--.  ,--.  ,---.  |  |  ,---.   ,---.  ,--,--,--.  ,---.  ,--,--,  ,-'  '-. 
# |  |  \  : | .-. :  \  `'  /  | .-. : |  | | .-. | | .-. | |        | | .-. : |      \ '-.  .-' 
# |  '--'  / \   --.   \    /   \   --. |  | ' '-' ' | '-' ' |  |  |  | \   --. |  ||  |   |  |   
# `-------'   `----'    `--'     `----' `--'  `---'  |  |-'  `--`--`--'  `----' `--''--'   `--'   
#                                                    `--'                                      
FROM base AS development

RUN apt-get update && apt-get install -y  --no-install-recommends \
  git \
  curl \
  postgresql-client

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" && sed -i 's/OSH_THEME="font"/OSH_THEME="powerline-plain"/g' ~/.bashrc

# Docker in docker
RUN apt-get update \
    #
    # Install Docker CE CLI
    && apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common lsb-release \
    && curl -fsSL https://download.docker.com/linux/$(lsb_release -is | tr '[:upper:]' '[:lower:]')/gpg | apt-key add - 2>/dev/null \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(lsb_release -is | tr '[:upper:]' '[:lower:]') $(lsb_release -cs) stable" \
    && apt-get update \
    && apt-get install -y docker-ce-cli

# Clean up
RUN apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Set the default shell to bash rather than sh
ENV SHELL /bin/bash