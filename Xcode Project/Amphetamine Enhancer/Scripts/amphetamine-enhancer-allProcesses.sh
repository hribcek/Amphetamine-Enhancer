#!/bin/zsh

# Redirect all output to /dev/null
exec &> /dev/null

# Use readonly for constants
readonly amphProcess="Amphetamine"
readonly processDir="${HOME}/Library/Containers/com.if.Amphetamine/Data/Library/Application Support/Amphetamine/Processes"
readonly processList="${processDir}/ProcessList.txt"
readonly triggerFile="${processDir}/Processes.amphetamine"

# If Amphetamine is running
if pgrep -xq "${amphProcess}" ; then
    # If the destination folder where the output file should be written does not exist, create it
    if [[ ! -d "${processDir}" ]]; then
        mkdir -p "${processDir}" || exit 1
    fi

    # Get all processes running on this Mac and write output to file
    # Use temporary file for atomic write operation
    local tempFile
    tempFile=$(mktemp "${processDir}/.ProcessList.XXXXXX") || exit 1

    if ps ax -c | awk -v p='COMMAND' 'NR==1 {n=index($0, p); next} {print substr($0, n)}' > "${tempFile}" ; then
        mv "${tempFile}" "${processList}" || rm -f "${tempFile}"
    else
        rm -f "${tempFile}"
        exit 1
    fi

    # Create or remove a secondary file that will trigger Amphetamine to pick up changes to the ProcessList.txt file
    # Amphetamine does not always pick up file content changes, but does pick up on file create/delete reliably
    # This is why it is necessary to create or delete the secondary file
    if [[ -f "${triggerFile}" ]]; then
        rm -f "${triggerFile}"
    else
        touch "${triggerFile}"
    fi
fi
