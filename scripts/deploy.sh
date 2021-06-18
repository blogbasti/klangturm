#!/usr/bin/env bash
#
# vim: noai:ts=2:sw=2:ss=2:ff=unix:et:smarttab

# duplicate stdout (1) and stderr(2)
exec 3>&1
exec 4>&2
exec 5>&1
exec 6>&2

declare -rx me="$(basename $0)"
declare -rx my_pid="$$"

set -e

function logline() {
  local channel="$1"
  ts "%d.%m.%Y %H:%M:%S $me[$my_pid] [${channel:-unknown}]"
}
declare -x logline

function wrap_logline() {
  (
    (
      $@
    ) | logline "stdout" >&5
  ) 2>&1 | logline "stderr" >&6
}
declare -x wrap_logline

function install_requirements() {
  apt-get update
  # install curl for rclone download
  apt-get install -fy curl unzip moreutils
  export _LOGLINE_ENABLED=1
  # install rclone
  rclone version >/dev/null || curl https://rclone.org/install.sh | bash
  # show rclone version
  rclone version
}

function msg() {
  local msg="$@"
  if [ ${_LOGLINE_ENABLED:-0} -eq 1 ]; then
    echo "$msg" | logline 
  else
    echo "$msg" >&3
  fi
}

function debug() {
  local msg="$@"
  msg "[DEBUG] $msg"
}

function info() {
  local msg="$@"
  msg "[INFO ] $msg"
}

function error() {
  local msg="$@"
  msg "[ERROR] $msg" 3>&4
}

function env_is_set_or_error() {
  local var="$1"
  if [ ! -n "$var" ] ; then
    error "Internal error env_is_set_or_error requires a variable name as first argument"
    exit 1
  fi

  if [ -z ${!var} ] ; then
    error "Environment '${var}' is required but not set"
    exit 1
  else
    info "ENV ${var} found"
  fi
}

function rclone_config() {
  env_is_set_or_error RCLONE_FTP_HOST
  env_is_set_or_error RCLONE_FTP_USER
  env_is_set_or_error RCLONE_FTP_PASS
  export RCLONE_FTP_TLS=false
  export RCLONE_FTP_CONCURRENCY=2
  export RCLONE_FTP_IDLE_TIMEOUT=10s
  export RCLONE_FTP_CLOSE_TIMEOUT=10s
  # create live ftp backend
  rclone config create live ftp
}

function deploy2live_ftp() {
  # prepare rclone configuration via environment
  rclone_config
  if [ ! -d ./_site ] ; then
    error "_site folder not found"
    exit 1
  fi
  # deploy 
  rclone sync ./_site live:/html/klangturm -n
}

# main

info "start at $(date)"
install_requirements

(
  (
    deploy2live_ftp
    info "finished"
  ) | logline "stdout" >&3
) | logline "stderr" >&4

#
