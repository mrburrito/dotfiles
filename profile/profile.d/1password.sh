alias op-login='eval $(op signin ${ONE_PASSWORD_DOMAIN})'

op-password() {
  if [ -z "$(eval "echo \${OP_SESSION_${ONE_PASSWORD_DOMAIN}}")" ]; then
    op-login
  fi
  local item="$@"
  op get item "${item}" | jq -r .details.password
}
