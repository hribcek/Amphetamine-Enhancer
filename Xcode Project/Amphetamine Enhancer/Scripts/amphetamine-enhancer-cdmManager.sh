#!/bin/zsh

# Redirect all output to /dev/null
exec &> /dev/null

# Amphetamine writes this value as YES if CDM is enabled
# If Amphetamine exited without disabling CDM, the value will remain YES.
local cdmEnabled=$(defaults read com.if.Amphetamine cdmEnabled)

if [[ "${cdmEnabled}" == 1 ]]; then
    # Assign values
    local amphProcess="Amphetamine"
    local allowSleep=0

    # If Amphetamine is not running then sleep should be allowed
    if ! pgrep -xq ${amphProcess} ; then
        allowSleep=1
    fi

    # If Amphetamine is running, allowSleep will still be false
    # Now we need to check if there are active assertions
    if (( ! allowSleep )); then
        # If there are power assertions applied by Amphetamine
        # then we should not do anything as the user can disable
        # closed-display mode via Amphetamine

        # If no power assertions are found, however, sleep should be allowed
        if ! pmset -g assertions | grep "Amphetamine" ; then
            allowSleep=1
        fi
    fi

    # If sleep should be allowed
    if (( allowSleep )); then
        # Launch app that disables closed-display mode override
        open "/Applications/Amphetamine Enhancer.app/Contents/Resources/CDMManager/CDMManager.app"

        # Write false to Amphetamine's plist so this script will not run
        # until Amphetamine starts blocking closed-display sleep again
        defaults write com.if.Amphetamine cdmEnabled -bool false
    fi
fi
