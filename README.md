# dakra/tap

Personal Homebrew tap for packages that are missing from Homebrew or need a different build.

```sh
brew tap dakra/tap
brew install dakra/tap/<name>
```

## Formulae

| Name | Description | Notes |
|------|-------------|-------|
| [autoraise](https://github.com/sbmpost/AutoRaise) | Focus-follows-mouse for macOS | Built with `OLD_ACTIVATION_METHOD` and `EXPERIMENTAL_FOCUS_FIRST`. Includes a `brew services` definition. |
| [elate](https://github.com/dakra/elate) | Spawn and drive sandboxed, observable Emacs sessions | Requires an Emacs installation. |
| [goimapnotify](https://gitlab.com/shackra/goimapnotify) | Execute scripts on IMAP mailbox changes using IDLE | Service runs from `$HOME`. Also available in homebrew-core. |
| [imapgoose](https://git.sr.ht/~whynothugo/ImapGoose) | Keep local Maildir directories synchronised with an IMAP server | Includes a `brew services` definition. |

## Casks

| Name | Description | Notes |
|------|-------------|-------|
| [flameshot](https://flameshot.org/) | Screenshot software with built-in annotation tools | The app is not notarized, so the cask removes the quarantine flag after install. |

Use the full name (`dakra/tap/flameshot`) for single-package commands, since a bare `flameshot` resolves to the disabled homebrew-cask version.

## Updating a package

```sh
brew livecheck --tap dakra/tap
```

Bump `url` and `sha256` for each outdated package, then verify with:

```sh
brew style dakra/tap
brew audit --strict --online dakra/tap/<name>
brew install --build-from-source dakra/tap/<name> && brew test dakra/tap/<name>
```
