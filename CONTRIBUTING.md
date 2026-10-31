# Contributing

Thanks for helping. These rules hold in every enshwick repository; a
repository's own `CONTRIBUTING.md` adds how to build and test it.

## Before you start

- Report a bug or an idea as an issue; ask a question in
  [Discussions](https://github.com/enshwick/.github/discussions).
- For a large change, open an issue first, so nobody builds the same thing
  twice.
- Never add game code or data: no decompiled code, no dumps, no game files.
  Engine facts go in documents as names and addresses, with the game build
  they were found on.

## Branches, commits and pull requests

- Branch from fresh `main` as `<type>/<slug>`, such as `fix/join-dialog`.
- The pull request title is a conventional commit,
  `<type>(<scope>): <subject>`, with a type of `feat`, `fix`, `perf`,
  `refactor`, `docs`, `test`, `build`, `ci`, `chore` or `revert`. The subject
  is imperative, lower case after the colon, without a final period or angle
  brackets, at most 72 characters. A breaking change carries `!` before the
  colon. The title becomes the squashed commit on `main`.
- One pull request is one change. Something else found on the way gets its
  own branch.
- Commits are signed with a key registered on GitHub; `main` accepts only
  signed commits.
- A change to what mods or players see carries its documentation and its
  tests in the same pull request.

## Checks

- Install the repository's git hooks (its `CONTRIBUTING.md` says how) and
  never skip them. They compile nothing and take seconds.
- `cargo xtask check` runs clippy, the tests of what the change touches and
  the doctests; it must pass before you ask for review.
- CI runs on GitHub-hosted runners. Runs for contributors from outside the
  organization wait for a maintainer's approval.

## Security

Report a vulnerability privately, as [SECURITY.md](SECURITY.md) says, never
in a public issue.
