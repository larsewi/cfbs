set -e
set -x
cd tests/
mkdir -p ./tmp/
cd ./tmp/
touch cfbs.json && rm cfbs.json
rm -rf .git

cfbs init --non-interactive
cfbs add https://github.com/larsewi/cfbs-test-modules.git --non-interactive
stat create-single-file/input.json
stat create-single-file-with-content/input.json
stat create-multiple-files/input.json
