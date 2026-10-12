# homebrew-tap

A [Homebrew](https://brew.sh) tap for [Recap](https://github.com/rathodlaxman/recap), a free, open-source command-line tool for macOS that summarizes articles, web pages, YouTube videos and PDFs on your own Mac with a local AI model.

It also holds [tidyline](https://github.com/rathodlaxman/tidyline), so the tap now has two tools. tidyline is installed separately; see [tidyline](#tidyline) below.

## Install

```sh
brew install rathodlaxman/tap/recap
```

This adds the tap and installs Recap in one step. Homebrew then prints what to do next: add one `source` line to your `~/.zshrc`, open a new Terminal window, and run `recapsetup` once. You also need [Ollama](https://ollama.com).

**Use the full name.** Since Homebrew 6.0.0, third-party taps are not trusted by default. Installing by the full name, as above, trusts only the Recap formula. If you add the tap first with `brew tap rathodlaxman/tap` and want to install by the short name, run `brew trust --formula rathodlaxman/tap/recap` first. See [Tap Trust](https://docs.brew.sh/Tap-Trust).

To upgrade later:

```sh
brew update
brew upgrade recap
```

To remove it:

```sh
brew uninstall recap
brew untap rathodlaxman/tap
```

Then delete the `source` line you added to `~/.zshrc`. Your summaries in the `Summaries` folder and the private Python environment in `~/.recap` are not removed.

## tidyline

tidyline is an offline, read-only command-line tool that audits a Things 3 database on macOS and reports what is untidy.

```sh
brew install rathodlaxman/tap/tidyline
```

tidyline is unofficial and not affiliated with or endorsed by Cultured Code.

**Your data is personal.** tidyline's JSON exports and its HTML report contain your task titles, and so does the text output of `check` and `recurrence`. Do not commit or share them.

**Use the full name.** Since Homebrew 6.0.0, third-party taps are not trusted by default. Installing by the full name, as above, trusts only the tidyline formula. If you add the tap first with `brew tap rathodlaxman/tap` and want to install by the short name, run `brew trust --formula rathodlaxman/tap/tidyline` first. See [Tap Trust](https://docs.brew.sh/Tap-Trust).

To upgrade later:

```sh
brew update
brew upgrade tidyline
```

To remove it:

```sh
brew uninstall tidyline
brew untap rathodlaxman/tap
```

Leave out `brew untap` if you still use Recap. Files you wrote with `--out` (exports, reports, prompts) are not removed.

Tested on 2026-10-12: tidyline 0.3.1 installed with `brew install --build-from-source` from a local copy of this tap, on macOS 27.0.1 (Apple silicon, arm64) with Homebrew 7.0.9 and Python 3.14.8. The build took 21 seconds and needed no other packages. `brew audit --strict --new --online` and `brew test` passed. Other macOS versions and Intel Macs have not been tested.

## What this tap contains

- `Formula/recap.rb`: the formula. It downloads the tagged release from the Recap repository, checks its SHA-256 checksum, and installs the script, the samples and the documentation. It does not edit your `~/.zshrc`.
- `Formula/tidyline.rb`: the tidyline formula. It downloads the tidyline and things.py source releases from PyPI, checks their SHA-256 checksums, and installs them into a private Python environment. Its test runs only `tidyline --version` and `tidyline --help`.

For how to use Recap, see the [Recap README](https://github.com/rathodlaxman/recap#readme).

For how to use tidyline, see the [tidyline README](https://github.com/rathodlaxman/tidyline#readme).

## For the maintainer: releasing a new version

1. In the Recap repository, tag the new version (for example `v1.1.1`) and publish the release.
2. Get the checksum of the new tarball:
   ```sh
   curl -sL https://github.com/rathodlaxman/recap/archive/refs/tags/v1.1.1.tar.gz | shasum -a 256
   ```
3. In `Formula/recap.rb`, change the version in `url` and the `sha256` value.
4. Test locally: `brew audit --strict rathodlaxman/tap/recap`, then `brew reinstall rathodlaxman/tap/recap` and `brew test rathodlaxman/tap/recap`.
5. Commit and push. Users get the new version with `brew update && brew upgrade recap`.
