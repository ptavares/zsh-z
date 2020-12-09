# zsh-z

zsh plugin for installing and loading [z](https://github.com/rupa/z.git)
>Inpired by [zsh-pyenv](https://github.com/mattberther/zsh-pyenv)

## Table of content

- [zsh-z](#zsh-z)
  - [Usage](#usage)
  - [Updating z](#updating-z)
  - [License](#license)

## Usage

Once the plugin installed, `z` will be available

- Using [Antigen](https://github.com/zsh-users/antigen)

Bundle `zsh-z` in your `.zshrc`

```shell
antigen bundle ptavares/zsh-z
```

- Using [zplug](https://github.com/b4b4r07/zplug)

Load `zsh-z` as a plugin in your `.zshrc`

```shell
zplug "ptavares/zsh-z"
```

- Using [zgen](https://github.com/tarjoilija/zgen)

Include the load command in your `.zshrc`

```shell
zget load ptavares/zsh-z
```

- As an [Oh My ZSH!](https://github.com/robbyrussell/oh-my-zsh) custom plugin

Clone `zsh-z` into your custom plugins repo and load as a plugin in your `.zshrc`

```shell
git clone https://github.com/ptavares/zsh-z.git ~/.oh-my-zsh/custom/plugins/zsh-z
```

```shell
plugins+=(zsh-z)
```

Keep in mind that plugins need to be added before `oh-my-zsh.sh` is sourced.

- Manually

Clone this repository somewhere (`~/.zsh-z` for example) and source it in your `.zshrc`

```shell
git clone https://github.com/ptavares/zsh-z ~/.zsh-z
```

```shell
source ~/.zsh-z/zsh-z.plugin.zsh
```

## Updating z

The plugin comes with a zsh function to update [z](https://github.com/rupa/z.git) manually

```shell
# From zsh shell
update_zsh_z
```

## License

[MIT](LICENCE)
