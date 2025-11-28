#!/bin/zsh

# Redirect all output to /dev/null
exec &> /dev/null

local amphProcess="Amphetamine"
local processDir="${HOME}/Library/Containers/com.if.Amphetamine/Data/Library/Application Support/Amphetamine/Processes"

# If Amphetamine is running
if pgrep -xq ${amphProcess} ; then
    # If the destination folder where the output file should be written does not exist, create it
    if [[ ! -d "${processDir}" ]]; then
        mkdir -p "${processDir}"
    fi

    # Get all processes running on this Mac and write output to file
    ps ax -c | awk -v p='COMMAND' 'NR==1 {n=index($0, p); next} {print substr($0, n)}' > "${processDir}/ProcessList.txt"

    # Create or remove a secondary file that will trigger Amphetamine to pick up changes to the ProcessList.txt file
    # Amphetamine does not always pick up file content changes, but does pick up on file create/delete reliably
    # This is why it is necessary to create or delete the secondary file
    if [[ -f "${processDir}/Processes.amphetamine" ]]; then
        rm "${processDir}/Processes.amphetamine"
    else
        touch "${processDir}/Processes.amphetamine"
    fi
fi
