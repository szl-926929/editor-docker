#!/bin/bash

if [ ! -d /root/.config/nvim/ ]; then
	git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
fi

if [ ! -d /root/.config/nvim/lua/custom/ ]; then
	if [ ! -d /root/server/nvchad-editor ]; then
		mkdir -p /root/server
		git clone git@github.com:szl-926929/nvchad-editor.git /root/server/ --depth 1
	fi
	ln -sf /root/server/nvchad-editor/ftplugin /root/.config/nvim
	ln -sf /root/server/nvchad-editor/lua/custom /root/.config/nvim/lua
fi

git config --global user.email "xutiebao@xiaohongshu.com"
git config --global user.name "suitable"
git config --global url."git@code.devops.xiaohongshu.com:".insteadOf https://code.devops.xiaohongshu.com
git config --global url."git@code.devops.xiaohongshu.com:".insteadOf http://code.devops.xiaohongshu.com
