#!/usr/bin/env bash
# The weekly organization check: every public repository's settings and
# `main` ruleset as the organization keeps them. Prints a Markdown list of
# findings, nothing when all is in order.
# Usage: org-check.sh <organization>
# Needs GH_TOKEN with read access to every repository.
set -euo pipefail

org=$1

unreadable=0
repos=$(gh repo list "$org" --visibility public --no-archived --limit 200 --json name --jq '.[].name' | sort)
for repo in $repos; do
  findings=()

  settings=$(gh api "repos/$org/$repo")
  if [ "$(jq -r .allow_squash_merge <<< "$settings")" = null ]; then
    unreadable=1
  fi
  while IFS= read -r line; do
    [ -n "$line" ] && findings+=("$line")
  done < <(jq -r '
    if .allow_squash_merge == null then
      empty
    else
    [ (select(.allow_squash_merge != true) | "squash merges are off"),
      (select(.allow_merge_commit != false) | "merge commits are allowed"),
      (select(.allow_rebase_merge != false) | "rebase merges are allowed"),
      (select(.squash_merge_commit_title != "PR_TITLE" or .squash_merge_commit_message != "PR_BODY")
        | "squash commits do not take the pull request title and body"),
      (select(.delete_branch_on_merge != true) | "branches stay after merge"),
      (select(.allow_auto_merge != true) | "auto-merge is off"),
      (select(.has_wiki != false) | "the wiki is on"),
      (select(.has_projects != false) | "projects are on"),
      (select((.description // "") == "") | "no description"),
      (select((.topics | length) == 0) | "no topics")
    ] | .[]
    end' <<< "$settings")

  ruleset=$(gh api "repos/$org/$repo/rulesets" --jq '.[] | select(.name == "main") | .id')
  if [ -z "$ruleset" ]; then
    findings+=("no ruleset main")
  else
    rules=$(gh api "repos/$org/$repo/rulesets/$ruleset" --jq '[.rules[].type] | join(" ")')
    for rule in deletion non_fast_forward pull_request required_signatures; do
      [[ " $rules " == *" $rule "* ]] || findings+=("ruleset main lacks $rule")
    done
    if gh api "repos/$org/$repo/contents/.github/workflows/ci.yml" > /dev/null 2>&1 \
      && [[ " $rules " != *" required_status_checks "* ]]; then
      findings+=("ruleset main requires no CI check")
    fi
  fi

  if [ ${#findings[@]} -gt 0 ]; then
    echo "- **$repo**"
    for finding in "${findings[@]}"; do echo "  - $finding"; done
  fi
done

# Checks the token could not make are a note, not findings.
if [ "$unreadable" = 1 ]; then
  echo >&2 "note: merge settings not checked: the token has no Administration read access"
fi
