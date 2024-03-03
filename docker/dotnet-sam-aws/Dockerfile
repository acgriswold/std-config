FROM node:20

RUN rm -rf /opt/yarn-v* /usr/local/bin/yarn /usr/local/bin/yarnpkg

RUN mkdir -p /root/workspace /root/.vscode-server

RUN npm install -g eslint typescript

# Download AWS
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip -d amazon \
    && ./amazon/aws/install

# Download AWS SAM CLI
RUN wget "https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip" -O "aws-sam-cli-linux-x86_64.zip" \
    && unzip aws-sam-cli-linux-x86_64.zip -d amazon/sam-installation \
    && ./amazon/sam-installation/install

# Download dotnet
RUN wget "https://dot.net/v1/dotnet-install.sh" -O "dotnet-install.sh" \
    && chmod +x ./dotnet-install.sh \
    && ./dotnet-install.sh --version latest

# Setup dotnet env variables
RUN echo 'export DOTNET_ROOT=$HOME/.dotnet' >> ~/.bashrc 
RUN echo 'export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools' >> ~/.bashrc 

CMD /bin/sh -c "while sleep 86000; do :; done" 