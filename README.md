# ungit

Download a repository, directory, or file from GitHub — no `git clone`, no
`.git` history, just the files. Also outputs a repo as LLM-friendly XML for
prompt context.

## Install

```sh
brew install tyom/tap/ungit
```

Or grab the script directly:

```sh
curl -o ungit https://raw.githubusercontent.com/tyom/ungit/main/ungit
chmod +x ungit && mv ungit /usr/local/bin/
```

## Usage

```
ungit [options] <source[@branch]> [destination]
```

### Options

| Option | Description |
| --- | --- |
| `-p, --prompt` | Output files as XML-formatted text for LLM prompts instead of downloading |
| `-i, --include GLOB` | Only include files matching pattern (repeatable) |
| `-e, --exclude GLOB` | Exclude files matching pattern (repeatable) |
| `-v, --version` | Print version |
| `-h, --help` | Show help |

### Formats

```sh
# Shorthand
ungit user/repo                      # entire repo to ./repo
ungit user/repo@branch               # from a specific branch
ungit user/repo/path                 # a specific directory
ungit user/repo/path@branch          # directory from a branch

# HTTPS / SSH / tree URLs
ungit https://github.com/user/repo
ungit git@github.com:user/repo.git@branch
ungit https://github.com/user/repo/tree/main/src
```

### Examples

```sh
ungit tyom/dotfiles                    # download entire repo
ungit tyom/dotfiles/zsh@master         # one directory from a branch
ungit tyom/dotfiles ./my-dotfiles      # custom destination
ungit -p tyom/dotfiles/zsh             # emit XML for an LLM prompt
ungit -p -i '*.sh' tyom/dotfiles       # only shell files, as prompt text
```

## License

[MIT](LICENCE)
