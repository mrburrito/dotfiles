# shellcheck shell=bash

# Define command completion function
function _with_aws_profile_completion() {
  local cmd cur_word profile_list sub_cmd_start sub_cmd
  cmd="${COMP_WORDS[0]}"
  cur_word="${COMP_WORDS[COMP_CWORD]}"

  if [[ "${cmd}" == "_with_aws_profile" ]]; then
    sub_cmd_start=2

    # If the command is _with_aws_profile and we are completing the profile, use the list of profiles
    if [[ ${COMP_CWORD} -eq 1 ]]; then
      # Get AWS profile list from the ~/.aws/config file
      profile_list=$(awk -F'[][]' '/\[profile/ {gsub(/^profile /, "", $2); print $2}' ~/.aws/config)
      # shellcheck disable=SC2207
      COMPREPLY=($(compgen -W "${profile_list}" -- "${cur_word}"))
      return
    fi
  else
    sub_cmd_start=1
  fi

  # if the subcommand is aws, use aws completions
  if [[ "${COMP_WORDS[sub_cmd_start]}" == "aws" ]]; then
    sub_cmd="${COMP_WORDS[*]:sub_cmd_start}"
    completions="$(COMP_LINE="${sub_cmd}" COMP_POINT=${#sub_cmd} aws_completer)"
  # If we are completing the subcommand, show system commands and files
  elif [[ ${COMP_CWORD} -eq ${sub_cmd_start} ]]; then
    completions="$(compgen -c "${cur_word}" -- "${cur_word}") $(compgen -f "${cur_word}" -- "${cur_word}")"
  # Otherwise, show files
  else
    completions="$(compgen -f "${cur_word}" -- "${cur_word}")"
  fi
  # shellcheck disable=SC2207
  COMPREPLY=($(compgen -W "${completions}" -- "${cur_word}"))
}
complete -F _with_aws_profile_completion _with_aws_profile
