CWD=$(pwd)
apt-get install -y python2
echo "Install Golang latest version"
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
GO_SRC="$GOPATH/src/"

export GO_BIN="$HOME/.go/bin/go"
export GOROOT=$HOME/.go
export PATH=$GOROOT/bin:$PATH
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH


echo -e "\033[1;32m[+] Install Gox \033[0m"
$GO_BIN install -ldflags "-s -w" github.com/mitchellh/gox@latest
echo -e "\033[1;32m[+] Install Dep \033[0m"
$GO_BIN install -ldflags "-s -w" github.com/golang/dep/cmd/dep@latest
cp -r $CWD $GO_SRC

cd "$GO_SRC/chashell/"

echo -e "\033[1;32m[+] Run Dep ensure \033[0m"
dep ensure
echo -e "\033[1;32m[+] Run go mod init \033[0m"
go mod init
echo -e "\033[1;32m[+] Run Dep ensure \033[0m"

dep ensure

echo -e "\033[1;32m[+] Run go mod vendor \033[0m"
go mod vendor
go mod tidy
go mod vendor

export ENCRYPTION_KEY=$(python2 -c 'from os import urandom; print(urandom(32).encode("hex"))')
export DOMAIN_NAME=c.zsec.site

make build-all
