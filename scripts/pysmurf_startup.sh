#!/usr/bin/env bash

###############
# Definitions #
###############

# This script name
script_name=$(basename $0)

########################
# Function definitions #
########################

# Usage message
usage()
{
    echo "Start pysmurf"
    echo ""
    echo "usage: ${script_name} [-e|--epics <epics_prefix>] [-h|--help]"
    echo "    -e|--epics <epics_prefix> : Sets the EPICS PV name prefix (defaults to 'smurf_server')."
    echo "    -h|--help                 : Show this message."
    echo ""
}

#############
# Main body #
#############

# Verify inputs arguments
while [[ $# -gt 0 ]]
do
key="$1"

case ${key} in
    -e|--epics)
    epics_prefix="$2"
    shift
    ;;
    -h|--help)
	usage
	exit 0
	;;
    *)
    echo "ERROR: Unknown argument..."
    usage
    exit 1
    ;;
esac
shift
done

echo

# The epics prefix is defined in the environmental variable 'EPICS_PREFIX'
# and it is set to 'smurf_server' by default in the Dockerfile.
# If a new prefix is passed as an argument, override the environmental variable.
if [ ! -z ${epics_prefix+x} ]; then
	echo "Setting EPCIS_PREFIX enviromental variable to ${epics_prefix}..."
	export EPICS_PREFIX=${epics_prefix}
fi

echo "Starting the ipython session"
ipython3 -i /usr/local/src/pysmurf_utils/pysmurf_startup.py