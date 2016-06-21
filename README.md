# Naughts And Crosses 
![Build Status] (https://api.travis-ci.org/simsalabim/naughts-and-crosses.svg?branch=master "Build Status") [![Code Climate](https://codeclimate.com/github/simsalabim/naughts-and-crosses/badges/gpa.svg)](https://codeclimate.com/github/simsalabim/naughts-and-crosses) [![Dependency Status](https://gemnasium.com/simsalabim/naughts-and-crosses.svg)](https://gemnasium.com/simsalabim/naughts-and-crosses) [![security](https://hakiri.io/github/simsalabim/naughts-and-crosses/master.svg)](https://hakiri.io/github/simsalabim/naughts-and-crosses/master)
[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy?template=https://github.com/simsalabim/naughts-and-crosses)

Web UI bridge for a simple (M, N, W) [console game](https://github.com/simsalabim/noughts-and-crosses)

## Installation
```shell
brew install qt # for capybara-webkit
bundle install
cp config/database.example.yml config/database.yml
bundle exec rake db:setup
rails s
```

## Tests
```shell
bundle exec cucumber
```

## TODO

- i18n.
- Teach bots play 10x10x5 with better heuristic. Currently "expert" can be caught in trap as they don't
look too far beyond immediate loss. Potential loss is different when W < M (or N).
- Look into non-square games, like 10x6x4.
- Allow more than 2 players per game; allow choose tokens.
- Multi-player support (websockets).
- More tests.
