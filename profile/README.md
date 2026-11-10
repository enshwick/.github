<p align="center">
  <a href="https://enshwick.com"><img src="banner.png" alt="Enshwick, the modding framework and API for Enshrouded" width="100%"></a>
</p>

<!--
The site is the source of these words, in src/data/texts.json of enshwick/docs:
the first paragraph is `site.description`; the alpha line `alpha.title` and
`front.makers.abi`; the lines on game updates, servers, Linux, languages, tools
and the licence repeat `front.faq.*` and `front.makers.*`; the last line
`foot.not-affiliated`. banner.png is https://enshwick.com/og/github/enshwick.png,
which that site's build draws. Change the words there first.
-->

Enshwick is the modding framework and API for
[Enshrouded](https://enshrouded.com). Its mod loader runs mods on your PC or
dedicated server. Write mods in Rust, Luau, C, C++ or as data.

Enshwick is in alpha: version 1.0 is not out yet. Until 1.0, anything may
change between alphas, so
[back up your worlds](https://enshwick.com/guides/back-up-saves/) before you
update.

## For players

- Download `enshwick.zip` from the newest alpha on the
  [releases page](https://github.com/enshwick/enshwick/releases), then follow
  the [install guide](https://enshwick.com/guides/install/).
- [Your first modded game](https://enshwick.com/start/first-modded-game/) shows
  each step, on Windows, Linux and Steam Deck.
- [Mods by the Enshwick team](https://enshwick.com/#mods) lists our mods. Each
  one has a page that says what it changes.
- After a game update, Enshwick turns off what it cannot find in the new
  version of the game and names it in chat. Everything else keeps working.
  [Compatibility](https://enshwick.com/reference/compatibility/) lists the game
  versions each release runs on.

## For server admins

- Install Enshwick into the server's folder, the one with
  `enshrouded_server.exe`, as the
  [install guide](https://enshwick.com/guides/install/) says. Players need the
  same mods, except the mods that run only on the server:
  [play on a server](https://enshwick.com/guides/play-on-a-server/).
- A Linux server runs the Windows server under Wine or Proton:
  [run a Linux server](https://enshwick.com/guides/run-a-linux-server/) and
  [run a server in Docker or Kubernetes](https://enshwick.com/guides/run-a-server-in-docker/).
- Each world has its own mod settings, in files beside its save:
  [where the files are](https://enshwick.com/reference/where-files-live/).

## For mod makers

- Write a mod in Rust or Luau, or as plain data with no code. C and C++ work
  through the [C header](https://enshwick.com/dev/mods-in-c/).
- We made tools to create a mod, put it in the game and test it without
  starting the game. [Getting started](https://enshwick.com/dev/getting-started/)
  shows them.
- The [developer docs](https://enshwick.com/dev/) explain the API, and
  [API coverage](https://enshwick.com/dev/api-coverage/) shows what it reaches
  today.
- [What comes next](https://enshwick.com/aims/) lists the aims, without dates.

## Report a bug or ask for an API

- [Open an issue in enshwick](https://github.com/enshwick/enshwick/issues/new/choose)
  for the mod loader or the API: a game update that broke something, an API
  call your mod needs, or an idea.
- [Open an issue in mods](https://github.com/enshwick/mods/issues/new/choose)
  for one of our mods.
- Ask a question in
  [Discussions](https://github.com/enshwick/.github/discussions).
- Report a security problem privately, as the
  [security policy](https://github.com/enshwick/.github/blob/main/SECURITY.md)
  says.
- Pull requests are welcome. The
  [contributing guide](https://github.com/enshwick/.github/blob/main/CONTRIBUTING.md)
  explains how they work.
- Mail [contact@enshwick.com](mailto:contact@enshwick.com).

## Repositories

| Repository | What it holds |
| --- | --- |
| [enshwick](https://github.com/enshwick/enshwick) | the framework: the mod loader, the API, the `cargo enshwick` tool and the modding book |
| [mods](https://github.com/enshwick/mods) | our mods, each released on its own |
| [docs](https://github.com/enshwick/docs) | the source of [enshwick.com](https://enshwick.com) |
| [vortex-extension](https://github.com/enshwick/vortex-extension) | the [Vortex](https://www.nexusmods.com/about/vortex/) extension that installs Enshwick and its mods |

Enshwick and our mods are free. Their code is open under the MIT licence.

Not made by or affiliated with Keen Games. Enshrouded is their trademark.
