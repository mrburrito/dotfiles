function aws-clear-tokens() {
  unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN AWS_ASSUMED_ROLE AWS_ASSUMED_ROLE_ID
}

function aws-list-profiles() {
  if [ -f ~/.aws/credentials ]; then
    local current=$(aws-profile)
    for profile in $(grep "\[" ~/.aws/credentials | sed -E "s/\[(.+)\]/\\1/"); do
      echo "$(test ${profile} == ${current} && echo '* ' || echo '  ')${profile}"
    done
  fi
}

function aws-profile() {
  local profile=$1
  if [ -z "${profile}" ]; then
    if [ -n "${AWS_ASSUMED_ROLE}" ]; then
      echo "Role: ${AWS_ASSUMED_ROLE} (${AWS_ASSUMED_ROLE_ID})"
    else
      echo ${AWS_DEFAULT_PROFILE:-default}
    fi
  else
    export AWS_DEFAULT_PROFILE=${profile}
    aws-clear-tokens
  fi
}

function aws-reset() {
  unset AWS_DEFAULT_PROFILE AWS_DEFAULT_REGION
  aws-clear-tokens
}

function aws-assume-role() {
  local role=$1
  local account_id=$2
  local role_arn=""

  if [ -z "${role}" ]; then
    echo "Proper Usage:"
    echo "  aws-assume-role <role_name> [accountId]"
  fi

  if [ -z "${account_id}" ]; then
    role_arn=$(aws iam get-role --role-name ${role} || echo '{"Role":{"Arn":""}}' | jq -r '.Role.Arn')
  else
    role_arn="arn:aws:iam::${account_id}:role/${role}"
  fi
  if [ -z "${role_arn}" ]; then
    echo "Unable to assume role: ${role} [${account_id}]"
    return 1
  fi

  local role_session_name="${USER}@${HOSTNAME}"
  SSM_CREDENTIALS=$(aws sts assume-role --role-arn "${role_arn}" --role-session-name "${role_session_name}")
  if [ -z "${SSM_CREDENTIALS}" ]; then
    echo "Unable to assume role: ${role_arn}"
    return 1
  fi

  export AWS_ACCESS_KEY_ID=$(echo ${SSM_CREDENTIALS} | jq -r ".Credentials.AccessKeyId")
  export AWS_SECRET_ACCESS_KEY=$(echo ${SSM_CREDENTIALS} | jq -r ".Credentials.SecretAccessKey")
  export AWS_SESSION_TOKEN=$(echo ${SSM_CREDENTIALS} | jq -r ".Credentials.SessionToken")
  export AWS_ASSUMED_ROLE=${role_arn}
  export AWS_ASSUMED_ROLE_ID=${role_session_name}

  echo "Assumed role ${role_arn} as ${role_session_name}"
}

function aws-assume-role-mfa() {
  local serial=$(aws iam list-mfa-devices | jq -r '.MFADevices[0].SerialNumber')
  if [ -z "${serial}" -o "${serial}" == "null" ]; then
    echo "No MFA Devices Registered"
    aws-assume-role $*
  else
    read -p "($(aws-profile)) Enter MFA Code: " mfa_code
    if [ -z "${mfa_code}" ]; then
      return 1
    fi
    TEMP_CREDS=$(aws sts get-session-token --serial-number ${serial} --token-code ${mfa_code})
    local ret_val=$?
    if [ ${ret_val} -ne 0 ]; then
      echo "Unable to get MFA session token."
      return 1
    fi
    AWS_ACCESS_KEY_ID=$(echo ${TEMP_CREDS} | jq -r '.Credentials.AccessKeyId') \
      AWS_SECRET_ACCESS_KEY=$(echo ${TEMP_CREDS} | jq -r '.Credentials.SecretAccessKey') \
      AWS_SESSION_TOKEN=$(echo ${TEMP_CREDS} | jq -r '.Credentials.SessionToken') \
      aws-assume-role $*
  fi
}
