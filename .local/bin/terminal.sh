#!/bin/bash
alacritty --command "bash -c \"tmux attach || systemd-run --user --scope tmux new-session\""
