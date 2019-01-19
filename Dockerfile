FROM ubuntu:latest

RUN dpkg --add-architecture i386
RUN apt-get update --fix-missing && apt-get -y upgrade

#-------------------------------------#
# Install packages from Ubuntu repos  #
#-------------------------------------#
RUN apt-get install -y \
    build-essential gcc-multilib g++-multilib libtool python-dev \
    python3-dev python-pip python3-pip default-jdk ruby net-tools \
    nasm vim zsh git strace tmux \
    ltrace netcat nmap wget exiftool \
    unzip man-db manpages-dev automake \
    virtualenvwrapper sudo virtualenvwrapper ca-certificates curl

#-------------------------------------#
# Installing vimrc                    #
#-------------------------------------#
RUN mkdir -p /root/.vim/colors && \
    wget https://raw.githubusercontent.com/morhetz/gruvbox/master/colors/gruvbox.vim -O /root/.vim/colors/gruvbox.vim && \
    echo "syntax on\ncolorscheme gruvbox\nset number\nset termguicolors\nhighlight Normal ctermfg=grey ctermbg=darkblue\nset encoding=UTF-8\nset backspace=eol,start,indent\nset whichwrap+=<,>,h,l\nset ai\nset si\nset wrap\nset tabstop=4 shiftwidth=4\nset lazyredraw\nset ttyfast\nmap <C-j> <C-W>j\nmap <C-k> <C-W>k\nmap <C-h> <C-W>h\nmap <C-l> <C-W>l\nmap <C-t><left> :tabn<cr>\nmap <C-t><right> :tabN<cr>\nset splitright\nnmap <leader>s :vsp \| term ++curwin<CR>exec zsh<CR>clear<CR>\ntnoremap <Esc> <C-\><C-n>" > /root/.vimrc

#-------------------------------------#
# Configuring enviroment              #
#-------------------------------------#
RUN git clone https://github.com/robbyrussell/oh-my-zsh.git /root/.oh-my-zsh
RUN cp /root/.oh-my-zsh/templates/zshrc.zsh-template /root/.zshrc && \
    echo "export LANG=C.UTF-8" >> /root/.zshrc
RUN curl -sSL git.io/jovial | bash
RUN chsh -s /bin/zsh

#-------------------------------------#
# Installing ctf-tools by zardus      #
#-------------------------------------#
RUN git clone https://github.com/zardus/ctf-tools.git /root/ctf-tools
RUN /root/ctf-tools/bin/manage-tools -s setup && \
    /root/ctf-tools/bin/ctf-tools-pip install appdirs && \
    echo "export PATH=$PATH:/root/ctf-tools/bin" >> /root/.zshrc && \
    echo "source /root/ctf-tools/bin/ctf-tools-venv-activate" >> /root/.zshrc

#-------------------------------------#
# Remove packages                     #
#-------------------------------------#
RUN apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#-------------------------------------#
# Mounting volume                     #
#-------------------------------------#
RUN mkdir /root/shared

#-------------------------------------#
# Configuring environment             #
#-------------------------------------#
WORKDIR /root
ENTRYPOINT ["/bin/zsh"]
