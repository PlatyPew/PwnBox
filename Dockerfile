FROM ubuntu:latest

RUN dpkg --add-architecture i386
RUN apt-get update && apt-get -y upgrade

#-------------------------------------#
# Install packages from Ubuntu repos  #
#-------------------------------------#
RUN apt-get install -y \
    build-essential gcc-multilib g++-multilib libtool python-dev \
    python3-dev python-pip python3-pip default-jdk ruby net-tools \
    nasm vim zsh git strace \
    ltrace netcat nmap wget exiftool \
    unzip man-db manpages-dev automake \
    virtualenvwrapper sudo virtualenvwrapper ca-certificates curl

#-------------------------------------#
# Mounting volume                     #
#-------------------------------------#
RUN mkdir /root/shared

#-------------------------------------#
# Installing vimrc                    #
#-------------------------------------#
RUN mkdir -p /root/.vim/colors
RUN wget https://raw.githubusercontent.com/morhetz/gruvbox/master/colors/gruvbox.vim -O /root/.vim/colors/gruvbox.vim
COPY vimrc /root/.vimrc

#-------------------------------------#
# Remove packages                     #
#-------------------------------------#
RUN apt-get -y autoremove
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#-------------------------------------#
# Configuring enviroment              #
#-------------------------------------#
RUN git clone https://github.com/robbyrussell/oh-my-zsh.git /root/.oh-my-zsh
RUN cp /root/.oh-my-zsh/templates/zshrc.zsh-template /root/.zshrc && echo "export LANG=C.UTF-8" >> /root/.zshrc
RUN curl -sSL git.io/jovial | bash
RUN chsh -s /bin/zsh

#-------------------------------------#
# Installing ctf-tools by zardus      #
#-------------------------------------#
RUN git clone https://github.com/zardus/ctf-tools.git /root/ctf-tools
RUN /root/ctf-tools/bin/manage-tools -s setup && echo "export PATH=$PATH:/root/ctf-tools/bin" >> /root/.bashrc

#-------------------------------------#
# Installing tools                    #
#-------------------------------------#

WORKDIR /root
ENTRYPOINT ["/bin/zsh"]
