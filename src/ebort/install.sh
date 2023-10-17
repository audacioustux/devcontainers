#!/usr/bin/env bash

set -eax

wget -q https://gist.githubusercontent.com/audacioustux/b4719a6044cbdbe9deddc1da4021bd72/raw/0b5b985c4c852ad70a11c72c000602f57bc095ff/ebort.sh
chmod +x ebort.sh
mv ebort.sh /usr/local/bin/ebort