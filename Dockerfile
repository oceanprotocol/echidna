FROM ubuntu:bionic
RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y curl wget libgmp-dev libbz2-dev libreadline-dev software-properties-common locales-all locales libsecp256k1-dev
RUN apt-get update
RUN wget https://github.com/ethereum/solidity/releases/download/v0.4.25/solc-static-linux
RUN chmod +x solc-static-linux
RUN mv solc-static-linux /usr/bin/solc
RUN curl -sSL https://get.haskellstack.org/ | sh
COPY . /echidna/
WORKDIR /echidna
RUN stack upgrade && stack setup && stack install
ENV PATH=$PATH:/root/.local/bin
RUN update-locale LANG=en_US.UTF-8
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8
CMD ["/bin/bash"]
