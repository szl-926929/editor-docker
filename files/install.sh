# install golang
cpu_arch=$(uname -m)
go_version="1.19.13"
go_tar="go"$go_version".linux.tar.gz"
go_url=""
if [[ $cpu_arch =~ "x86" ]]; then
	go_url="https://go.dev/dl/go"$go_version".linux-386.tar.gz"
elif [[ $cpu_arch =~ "aarch64" ]]; then
	go_url="https://go.dev/dl/go"$go_version".linux-arm64.tar.gz"
elif [[ $cpu_arch =~ "x86_64" ]]; then
	go_url="https://go.dev/dl/go"$go_version".linux-amd64.tar.gz"
fi
echo "install "$go_url
wget $go_url -O $go_tar
tar -C /usr/local/ -xzf $go_tar
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin
rm -rf $go_tar

# go tools
go install github.com/jstemmer/gotags@latest
go install github.com/klauspost/asmfmt/cmd/asmfmt@latest
go install github.com/kisielk/errcheck@latest
go install github.com/amitbet/gorename@latest
go install golang.org/x/tools/cmd/guru@latest
go install github.com/josharian/impl@latest
go install github.com/fatih/motion@latest
go install honnef.co/go/tools/cmd/staticcheck@latest
go install github.com/go-delve/delve/cmd/dlv@latest
go install github.com/davidrjenni/reftools/cmd/fillstruct@latest
go install github.com/rogpeppe/godef@latest
go install github.com/fatih/gomodifytags@latest
go install github.com/golang/lint/golint@latest

# install lua-language-server
git clone https://github.com/LuaLS/lua-language-server --depth=1
cd lua-language-server
./make.sh
cp ./bin/lua-language-server /usr/bin/
cd ..
rm -rf lua-language-server
apk add -U --no-cache stylua

# tmux conf
cp ./files/tmux.conf /root/.tmux.conf
