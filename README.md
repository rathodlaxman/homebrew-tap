# homebrew-tap

A [Homebrew](https://brew.sh) tap for [Recap](https://github.com/rathodlaxman/recap), a free, open-source command-line tool for macOS that summarises articles, web pages, YouTube videos and PDFs on your own Mac with a local AI model.

## Install

```sh
brew install rathodlaxman/tap/recap
```

This adds the tap and installs Recap in one step. Homebrew then prints what to do next: add one `source` line to your `~/.zshrc`, open a new Terminal window, and run `recapsetup` once. You also need [Ollama](https://ollama.com).

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

## What this tap contains

- `Formula/recap.rb`: the formula. It downloads the tagged release from the Recap repository, checks its SHA-256 checksum, and installs the script, the samples and the documentation. It does not edit your `~/.zshrc`.

For how to use Recap, see the [Recap README](https://github.com/rathodlaxman/recap#readme).

## For the maintainer: releasing a new version

1. In the Recap repository, tag the new version (for example `v1.0.1`) and publish the release.
2. Get the checksum of the new tarball:
   ```sh
   curl -sL https://github.com/rathodlaxman/recap/archive/refs/tags/v1.0.1.tar.gz | shasum -a 256
   ```
3. In `Formula/recap.rb`, change the version in `url` and the `sha256` value.
4. Test locally: `brew audit --strict rathodlaxman/tap/recap`, then `brew reinstall rathodlaxman/tap/recap` and `brew test rathodlaxman/tap/recap`.
5. Commit and push. Users get the new version with `brew update && brew upgrade recap`.
