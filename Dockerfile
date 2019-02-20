FROM ubuntu:18.04

RUN dpkg --add-architecture i386

#-------------------------------------#
# Install packages from Ubuntu repos  #
#-------------------------------------#
RUN apt-get update --fix-missing && \
    apt-get install -y \
        build-essential gcc-multilib g++-multilib libtool \
        python-dev python3-dev python-pip python3-pip \
        net-tools nasm vim zsh git strace ltrace netcat \
        nmap wget unzip autojump automake virtualenvwrapper \
        ca-certificates curl tmux sudo \
        --no-install-recommends

#-------------------------------------#
# Installing vimrc                    #
#-------------------------------------#
RUN mkdir -p /root/.vim/colors && \
    wget https://raw.githubusercontent.com/morhetz/gruvbox/master/colors/gruvbox.vim -O /root/.vim/colors/gruvbox.vim && \
    echo "syntax on\ncolorscheme gruvbox\nset termguicolors\nhighlight Normal ctermfg=grey ctermbg=darkblue\nset number\nset encoding=UTF-8\nset backspace=eol,start,indent\nset whichwrap+=<,>,h,l\nset autoindent\nset smartindent\nset wrap\nset tabstop=4 shiftwidth=4 \nset tabstop=4\nset softtabstop=4\nset expandtab\nset list listchars=tab:»·,trail:·,nbsp:·\nset splitright\nset lazyredraw\nset ttyfast\nset foldmethod=syntax\nset foldmethod=expr\nset showcmd\nset noruler\nset shell=/bin/zsh\nnmap <C-h> <C-W>h\nnmap <C-j> <C-W>j\nnmap <C-k> <C-W>k\nnmap <C-l> <C-W>l\nnmap <leader>s :vsp \| set nonumber \| term ++curwin<CR>\ntnoremap <Esc> <C-\><C-n>\nnnoremap ; :" > /root/.vimrc

#-------------------------------------#
# Configuring enviroment              #
#-------------------------------------#
RUN git clone https://github.com/robbyrussell/oh-my-zsh.git /root/.oh-my-zsh && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /root/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && \
    touch /root/.zshrc && \
    curl -sSL git.io/jovial | bash && \
    chsh -s /bin/zsh

#-------------------------------------#
# Installing ctf-tools by zardus      #
#-------------------------------------#
RUN git clone https://github.com/zardus/ctf-tools.git /root/ctf-tools && \
    /root/ctf-tools/bin/manage-tools -s setup && \
    /root/ctf-tools/bin/ctf-tools-pip install appdirs

#-------------------------------------#
# Updating zshrc                      #
#-------------------------------------#
RUN echo "plugins=(\n  git\n  autojump\n  urltools\n  bgnotify\n  jovial\n  zsh-syntax-highlighting)\nZSH_THEME='jovial'\nDISABLE_UNTRACKED_FILES_DIRTY='true'\nexport ZSH=/root/.oh-my-zsh\nsource \$ZSH/oh-my-zsh.sh\nexport LC_ALL=C.UTF-8\nexport PATH=/root/ctf-tools/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin\nexport PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/root/ctf-tools/bin\nZSH_HIGHLIGHT_STYLES[arg0]='fg=green,bold'\nsource /root/ctf-tools/bin/ctf-tools-venv-activate" > /root/.zshrc

#-------------------------------------#
# Remove packages                     #
#-------------------------------------#
RUN apt-get -y autoremove && \
    apt-get clean && \
    rm -rvf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm -rvf /root/.wget-hsts /root/.cache /root/.zsh_history

#-------------------------------------#
# Configuring environment             #
#-------------------------------------#
WORKDIR /root
ENTRYPOINT ["/bin/zsh"]
