#!/bin/bash

applist=(
    'Emacs'
    'Slack'
    'Mail'
    'Skype'
)

function wait_for_low_load {
    until [[ "$(iostat | tail -n 1 | awk '{print $6}')" -gt 90 ]] &&
              [[ "$(iostat | tail -n 1 | awk '{print $3}' | head -c 1)" -lt 5 ]]; do
        echo "load high; sleeping..."
        sleep 2
    done
}

count=0
for app in ${applist[@]}; do
    wait_for_low_load
    echo "opening $app"
    # we can either give path to app
    # /Applications/${app}.app/Contents/MacOS/${app}
    # or ask OS to open it
    open -a ${app}
    sleep 1
    count=$(( $count + 1 ))
done
