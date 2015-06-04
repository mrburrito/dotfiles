alias defgems='cat $(brew --prefix rbenv)/default-gems'
alias rake='bundle exec rake'

# Default RAILS_ENV to development
export RAILS_ENV=development

# rbenv configuration
eval "$(rbenv init -)"
