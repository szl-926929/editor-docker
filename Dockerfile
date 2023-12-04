FROM alpine:latest

WORKDIR /root

COPY ./files /root/files

RUN apk add -U --no-cache \
    neovim neovim-doc xclip git git-perl \
    zsh tmux openssh-client ncurses \
    curl less ripgrep \
    docker py-pip docker-compose \
	fontconfig fontforge py3-fontforge \
	openssl neofetch \
	luarocks libstdc++6 nodejs npm gcc gcompat musl-dev luarocks clang-extra-tools ctags fd\
    ninja \
	&& apk add --no-cache --virtual .build-deps


RUN apk add -U --no-cache gcc clang clang-dev alpine-sdk cmake ccache bear\
    && apk add -U --no-cache dpkg \
    && apk add -U --no-cache linux-headers \
    && ln -sf /usr/bin/clang /usr/bin/cc \
    && ln -sf /usr/bin/clang++ /usr/bin/c++ \
    && update-alternatives --install /usr/bin/cc cc /usr/bin/clang 10\
    && update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++ 10\
    && update-alternatives --auto cc \
    && update-alternatives --auto c++ \
    && update-alternatives --display cc \
    && update-alternatives --display c++ \
    && ls -l /usr/bin/cc /usr/bin/c++ \
    && cc --version \
    && c++ --version


#RUN curl -OL https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/JetBrainsMono.zip \
#    && mkdir -p /usr/share/fonts \
#	&& unzip JetBrainsMono.zip -d /root/JetBrainsMono \
#	&& cp /root/JetBrainsMono/JetBrains\ Mono\ Medium\ Nerd\ Font\ Complete\ Mono\ Windows\ Compatible.ttf /usr/share/fonts/ \
#	&& fc-cache -fv \
#	&& rm -rf JetBrainsMono.zip \
#	&& rm -rf JetBrainsMono


RUN chmod +x ./files/install_golang.sh \
    && ./files/install_golang.sh \
	&& chmod +x ./files/install_lua.sh \
	&& ./files/install_lua.sh \
	&& chmod +x ./files/install_editor.sh \
	&& ./files/install_editor.sh


RUN curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | zsh || true \
    && cp ~/files/zshrc ~/.zshrc \
	&& apk add -U --no-cache zsh-syntax-highlighting zsh-vcs \
    && sed -i 's/\/bin\/ash/\/bin\/zsh/g' /etc/passwd \
	&& /bin/zsh -c "source /etc/profile" \
	&& /bin/zsh -c "source ~/.zshrc" \
	&& cp ./files/tmux.conf /root/.tmux.conf


CMD ["/usr/local/go/bin/go", "run", "/root/files/daemon/main.go"]

