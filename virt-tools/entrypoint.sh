#!/bin/bash

if [[ ! -f "${HOME}/.zshrc" ]]; then
  cp /tmp/.zshrc.template "${HOME}/.zshrc"
fi