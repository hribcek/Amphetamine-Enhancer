#!/bin/zsh

# Redirect all output to /dev/null
exec &> /dev/null

# Use readonly for constants
readonly amphProcess="Amphetamine"
readonly amphPlist="com.if.Amphetamine"
readonly cdmManagerApp="/Applications/Amphetamine Enhancer.app/Contents/Resources/CDMManager/CDMManager.app"

# Amphetamine writes this value as YES if CDM is enabled
# If Amphetamine exited without disabling CDM, the value will remain YES.
local cdmEnabled
cdmEnabled=$(defaults read "${amphPlist}" cdmEnabled 2>/dev/null)

if [[ "${cdmEnabled}" == 1 ]]; then
    # Assign default values
    local allowSleep=0

    # If Amphetamine is not running then sleep should be allowed
    if ! pgrep -xq "${amphProcess}" ; then
        allowSleep=1
    fi

    # If Amphetamine is running, allowSleep will still be false
    # Now we need to check if there are active assertions
    if (( ! allowSleep )); then
        # If there are power assertions applied by Amphetamine
        # then we should not do anything as the user can disable
        # closed-display mode via Amphetamine

        # If no power assertions are found, however, sleep should be allowed
        if ! pmset -g assertions | grep -q "Amphetamine" ; then
            allowSleep=1
        fi
    fi

    # If sleep should be allowed
    if (( allowSleep )); then
        # Launch app that disables closed-display mode override
        if [[ -d "${cdmManagerApp}" ]]; then
            open "${cdmManagerApp}"

            # Write false to Amphetamine's plist so this script will not run
            # until Amphetamine starts blocking closed-display sleep again
            defaults write "${amphPlist}" cdmEnabled -bool false
        fi
    fi
fi
