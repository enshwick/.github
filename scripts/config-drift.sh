#!/usr/bin/env bash
# Compares a repository's shared configuration with template-mod at the
# commit its .copier-answers.yml pins, and its renovate.json with the one
# allowed form. Prints one line per finding; exits 1 when there is one.
# Usage: config-drift.sh <repository directory> <template-mod clone>
set -euo pipefail

repo=$1
template=$2
found=0

# Files every repository rendered from the template keeps as rendered;
# a change belongs in template-mod and reaches the mods with copier update.
shared=(
  rustfmt.toml clippy.toml deny.toml rust-toolchain.toml lefthook.yml
  renovate.json .markdownlint-cli2.yaml .cargo/config.toml
  tools/check-commit-message.ts
  .github/workflows/ci.yml .github/workflows/dev-build.yml
  .github/workflows/release-plz.yml
)

if [ -f "$repo/.copier-answers.yml" ]; then
  commit=$(sed -n 's/^_commit: *//p' "$repo/.copier-answers.yml")
  for file in "${shared[@]}"; do
    # A file the pinned template does not have yet is not drift.
    git -C "$template" cat-file -e "$commit:template/$file" 2> /dev/null || continue
    if [ ! -f "$repo/$file" ]; then
      echo "$file: missing; template-mod $commit has it"
      found=1
    elif ! git -C "$template" show "$commit:template/$file" | cmp -s - "$repo/$file"; then
      echo "$file: differs from template-mod $commit"
      found=1
    fi
  done
fi

# shellcheck disable=SC2016 # $schema is a JSON key, not a variable
expected='{"$schema":"https://docs.renovatebot.com/renovate-schema.json","extends":["github>enshwick/renovate-config"]}'
if [ ! -f "$repo/renovate.json" ]; then
  echo "renovate.json: missing"
  found=1
elif [ "$(jq -cS . "$repo/renovate.json")" != "$(jq -cS . <<< "$expected")" ]; then
  echo "renovate.json: does more than extend github>enshwick/renovate-config"
  found=1
fi

exit "$found"
