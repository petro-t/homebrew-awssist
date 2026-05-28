# homebrew-awssist

Homebrew tap for [AWSsist](https://github.com/petro-t/awssist) — desktop AWS
profile and session manager.

## Install

```sh
brew tap petro-t/awssist
brew install --cask awssist
```

## Upgrade

```sh
brew update
brew upgrade --cask awssist
```

## Uninstall

```sh
brew uninstall --cask awssist                       # remove the app
brew uninstall --cask --zap awssist                 # remove the app + user data
brew untap petro-t/awssist                          # forget the tap
```

## Requirements

- macOS 12 (Monterey) or newer
- **Apple Silicon (M-series)** — Intel Macs are not currently published.
  Open an issue at [petro-t/awssist](https://github.com/petro-t/awssist/issues)
  if you need an Intel build.

AWSsist itself relies on the `aws` CLI and `session-manager-plugin` for
SSM tunnels and ECS / EC2 shell sessions. Install those separately:

```sh
brew install awscli
brew install --cask session-manager-plugin
```

## Why does this cask strip quarantine?

AWSsist is not yet code-signed with an Apple Developer ID. macOS Gatekeeper
quarantines downloaded apps and would refuse to launch with a "damaged"
message. The cask's `postflight` block runs `xattr -cr` on the installed
bundle so the app opens normally on first launch. Once we ship a
signed + notarized build, that step will be removed and the cask will
revert to the standard install path.

If you'd rather inspect the bundle before that automatic step runs, install
without postflight scripts:

```sh
brew install --cask --no-quarantine awssist
```

…and the app will install with no xattr modification at all (Homebrew's
`--no-quarantine` flag tells brew not to apply the quarantine attribute to
begin with, making the postflight a no-op).
