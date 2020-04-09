# Berlin Events Calendar

## Overview
Scrape, parse, save, filter, and display events in Berlin

## Setup
install asdf plugins for postgres, nodejs, ruby

install yarn

`asdf install`

```
createdb `whoami`
createdb dalia-test_development
createdb dalia-test_test
```

`bundle`
`rails db:migrate`

to run specs:
`bundle exec rspec`

if you don't want to hit an external resources:
`bundle exec rspec spec/controllers`

scrape sites:
`rails scrape`

to use server:
`rails server`

navigate browser to localhost:3000
