#!/bin/bash

# install lua-language-server
git clone https://github.com/LuaLS/lua-language-server --depth=1
cd lua-language-server
./make.sh
cp ./bin/lua-language-server /usr/bin/
cd ..
rm -rf lua-language-server
apk add -U --no-cache stylua


