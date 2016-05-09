#!/bin/bash

expect -c "
  spawn ./netdata-installer.sh --install /opt
  expect \"Press Control-C and run the same command with --help for help.\"
  send \"\n\"
  interact
"
