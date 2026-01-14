# shellcheck shell=bash

# Execute a command with an AWS profile or set the AWS_PROFILE to the target
function _with_aws_profile() {
  # Check if the AWS_PROFILE argument is provided
  if [[ -z "$1" ]]; then
    echo "Usage: _with_aws_profile <AWS_PROFILE> [command...]"
    return 1
  fi

  local profile="$1"
  shift

  if [[ $# -eq 0 ]]; then
    export AWS_PROFILE="${profile}"
  fi

  # Execute the command with AWS_PROFILE set
  AWS_PROFILE="${profile}" "$@"
}

# Ensure tools load the shared AWS config
export AWS_SDK_LOAD_CONFIG=1
