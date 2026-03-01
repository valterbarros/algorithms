#! /bin/bash

## as go is compiled and not interpreted, we need to run it in a loop to see the changes without having to re-run the command every time
while true; do
  clear
  go run main.go $1
  sleep 1
done
