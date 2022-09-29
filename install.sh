install_banner "Install Golang latest version"
wget -q -O - https://raw.githubusercontent.com/canha/golang-tools-install-script/master/goinstall.sh | bash

GO_BIN="$HOME/.go/bin/go"
# in case the script fail
[[ -f $GO_BIN ]] || GO_BIN=$(which go)
echo -e "\033[1;32m[+] Detected go binary: $GO_BIN \033[0m"
[[ -d $GO_DIR ]] || GO_DIR=$GOPATH/bin
echo -e "\033[1;32m[+] Detected go tools: $GO_DIR \033[0m"

GOROOT=$HOME/.go
PATH=$GOROOT/bin:$PATH
GOPATH=$HOME/go
PATH=$GOPATH/bin:$PATH

export GO_BIN="$HOME/.go/bin/go"
export GOROOT=$HOME/.go
export PATH=$GOROOT/bin:$PATH
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH

make build-all
