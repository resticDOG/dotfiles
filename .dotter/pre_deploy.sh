#!/usr/bin/env bash

# prevent target directory not found when running deploy

[[ ! -d "$HOME/.config" ]] && mkdir "$HOME/.config"
