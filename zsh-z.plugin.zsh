#!/usr/bin/env zsh

#####################
# COMMONS
#####################
autoload colors is-at-least

#########################
# CONSTANT
#########################
BOLD="bold"
NONE="NONE"

#########################
# PLUGIN MAIN
#########################

[[ -z "$Z_HOME" ]] && export Z_HOME="$HOME/._z/"

ZSH_Z_VERSION_FILE=${Z_HOME}/version.txt

#########################
# Functions
#########################

_zsh_z_log() {
  local font=$1
  local color=$2
  local msg=$3

  if [ $font = $BOLD ]
  then
    echo $fg_bold[$color] "[zsh-z-plugin] $msg" $reset_color
  else
    echo $fg[$color] "[zsh-z-plugin] $msg" $reset_color
  fi
}

_zsh_z_last_version() {
  echo $(curl -s https://api.github.com/repos/rupa/z/releases | grep tag_name | head -n 1 | cut -d '"' -f 4)
}

_zsh_z_download_install() {
    local version=$1
    local machine
    case "$(uname -m)" in
      x86_64)
        machine=amd64
        ;;
      i686 | i386)
        machine=386
        ;;
      *)
        _zsh_z_log $BOLD "red" "Machine $(uname -m) not supported by this plugin"
        return 1
      ;;
    esac
    _zsh_z_log $NONE "blue" "  -> download and install z ${version}"
    wget -qc --no-check-certificate  https://github.com/rupa/z/archive/${version}.tar.gz -O - | tar xz -C "${Z_HOME}"
    mv -f "${Z_HOME}"/z-*/* "${Z_HOME}"
    rm -rf "${Z_HOME}"/z-*
    chmod +x "${Z_HOME}"/*.sh
    echo ${version} > ${ZSH_Z_VERSION_FILE}
}

_zsh_z_install() {
  _zsh_z_log $NONE "blue" "#############################################"
  _zsh_z_log $BOLD "blue" "Installing z..."
  _zsh_z_log $NONE "blue" "-> creating z home dir : ${Z_HOME}"
  mkdir -p ${Z_HOME} || _zsh_z_log $NONE "green" "dir already exist"
  local last_version=$(_zsh_z_last_version)
  _zsh_z_log $NONE "blue" "-> retrieve last version of z..."
  _zsh_z_download_install ${last_version}
  if [ $? -ne 0 ]
  then
    _zsh_z_log $BOLD "red" "Install KO"
  else
    _zsh_z_log $BOLD "green" "Install OK"
  fi
  _zsh_z_log $NONE "blue" "#############################################"
}

update_zsh_z() {
  _zsh_z_log $NONE "blue" "#############################################"
  _zsh_z_log $BOLD "blue" "Checking new version of z..."

  local current_version=$(cat ${ZSH_Z_VERSION_FILE})
  local last_version=$(_zsh_z_last_version)

  if is-at-least ${last_version#v*} ${current_version#v*}
  then
    _zsh_z_log $BOLD "green" "Already up to date, current version : ${current_version}"
  else
    _zsh_z_log $NONE "blue" "-> Updating z..."
    _zsh_z_download_install ${last_version}
    _zsh_z_log $BOLD "green" "Update OK"
  fi
  _zsh_z_log $NONE "blue" "#############################################"
}

_zsh_z_load() {
    # export PATH
    source ${Z_HOME}/z.sh
}

# install z if it isnt already installed
[[ ! -f "${ZSH_Z_VERSION_FILE}" ]] && _zsh_z_install

# load z if it is installed
if [[ -f "${ZSH_Z_VERSION_FILE}" ]]; then
    _zsh_z_load
fi

unset -f _zsh_z_install _zsh_z_load