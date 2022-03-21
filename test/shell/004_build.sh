set -e
set -x
cd test
mkdir -p ./tmp/
cd ./tmp/
touch cfbs.json && rm cfbs.json
rm -rf .git

cfbs --non-interactive init
cfbs --non-interactive add mpf
cfbs --non-interactive add autorun
cfbs --non-interactive add systemd
cfbs --non-interactive add git
cfbs --non-interactive add ansible
cfbs build

ls out/
