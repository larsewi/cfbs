set -e
set -x
cd tests/
mkdir -p ./tmp/
cd ./tmp/
touch cfbs.json && rm cfbs.json
rm -rf .git
rm -rf delete-files

cfbs --non-interactive init
cfbs --non-interactive add delete-files@0.0.1

commit_a=$(git rev-parse HEAD)

echo '[
  {
    "type": "list",
    "variable": "files",
    "namespace": "delete_files",
    "bundle": "delete_files",
    "label": "Files",
    "subtype": [
      {
        "key": "path",
        "type": "string",
        "label": "Path",
        "question": "Path to file"
      },
      {
        "key": "why",
        "type": "string",
        "label": "Why",
        "question": "Why should this file be deleted?",
        "default": "Unknown"
      }
    ],
    "while": "Specify another file you want deleted on your hosts?",
    "response": [
      { "path": "/tmp/test1", "why": "Test 1" },
      { "path": "/tmp/test2", "why": "Test 2" }
    ]
  }
]' | cfbs set-input delete-files -

commit_b=$(git rev-parse HEAD)

test "x$commit_a" != "x$commit_b"

cfbs get-input delete-files - | cfbs set-input delete-files -

commit_c=$(git rev-parse HEAD)

test "x$commit_b" = "x$commit_c"

# Error if the file has never been added:
git ls-files --error-unmatch delete-files/input.json

# Error if there are staged (added, not yet commited)
git diff --exit-code --staged

# Error if there are uncommited changes (to tracked files):
git diff --exit-code
