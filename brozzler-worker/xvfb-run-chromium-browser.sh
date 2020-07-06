#!/bin/sh
xvfb-run chromium --no-sandbox --disable-gpu --remote-debugging-address=0.0.0.0 "$@"
