# Enshwick on GitHub

The organization profile, community files and Renovate preset of
[Enshwick](https://enshwick.com), the modding framework and API for Enshrouded.

| Path | What |
| --- | --- |
| [`profile/`](profile) | the README that [github.com/enshwick](https://github.com/enshwick) shows, and its banner |
| [`CONTRIBUTING.md`](CONTRIBUTING.md), [`SUPPORT.md`](SUPPORT.md), [`SECURITY.md`](SECURITY.md) | the community files of every repository that has none of its own |
| [`.github/ISSUE_TEMPLATE/`](.github/ISSUE_TEMPLATE), [`.github/pull_request_template.md`](.github/pull_request_template.md) | the issue forms and the pull request template of every repository that has none of its own |
| [`renovate/default.json`](renovate/default.json) | the Renovate preset every repository extends |

## Where the profile's words come from

The site is the source of the words the profile repeats. The description of
Enshwick is `site.description` in
[`src/data/texts.json`](https://github.com/enshwick/docs/blob/main/src/data/texts.json)
of the docs repository. `profile/banner.png` is
[`enshwick.com/og/github/enshwick.png`](https://enshwick.com/og/github/enshwick.png),
which the site's build draws from the same words. After a change there, copy
the new image over `profile/banner.png`.
