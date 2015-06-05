# Naughts And Crosses

Web UI bridge for a simple (M, N, W) [console game](https://github.com/simsalabim/noughts-and-crosses)

## Installation
```shell
bundle install
cp config/database.example.yml config/database.yml
bundle exec rake db:setup
rails s
```

## Tests
```shell
bundle exec cucumber
```