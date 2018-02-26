#!/bin/bash
set -e

# find local installation of script
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
    DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done

# export script globals
export SCRIPT_DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
export NODE_ENV=production

loadScript() {
    LOCAL_SCRIPT=$1 && shift
    source $SCRIPT_DIR/$LOCAL_SCRIPT $@
}

#
# start RUN
#
loadScript helpers/logError
loadScript helpers/logMessage
loadScript helpers/requiredDependencies
loadScript helpers/showHelp

# exit with help if no arguments are specified
if [[ $# -eq 0 ]] ; then showHelp; fi

# check options
while test $# -gt 0; do
    case "$1" in
        -h|--help)
            showHelp
            ;;
        -d)
            shift
            export NODE_ENV=development
            ;;
        *)
            break
            ;;
    esac
done

SCRIPT=$1 && shift
if [ -f "$SCRIPT_DIR/scripts/$SCRIPT" ]; then

    # trap 'if [[ "$?" -ne "0" ]]; then showHelp; fi' EXIT;
    loadScript scripts/$SCRIPT $@

else

    SCRIPT_CONTENT=$(jq -r --arg SCRIPT "$SCRIPT" '.scripts[$SCRIPT]' package.json)
    if [ "$SCRIPT_CONTENT" == "null" ]; then
        showHelp "Command \"$SCRIPT\" not found on RUN or in package.json."
    fi

    npm run $SCRIPT

fi
