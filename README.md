[![CircleCI](https://circleci.com/gh/mickey/black-hole-struct/tree/master.svg?style=svg)](https://circleci.com/gh/mickey/black-hole-struct/tree/master)

# BlackHoleStruct

**BlackHoleStruct** is a data structure similar to an `OpenStruct` that allows:
- infinite chaining of attributes or [autovivification](https://en.wikipedia.org/wiki/Autovivification)
- deep merging of BlackHoleStruct/Hash

![](https://media.giphy.com/media/kxAX99ncvbPk4/giphy.gif)

## Installation

Add it to your Gemfile:

```ruby
gem "black_hole_struct"
```

Or install the gem manually:

```sh
$ gem install black_hole_struct
```

## Basic Usage

```ruby
require "black_hole_struct"

config = BlackHoleStruct.new
config.dashboard.theme = "white"
config.dashboard.time.from = "now-1h"
config.dashboard.time.to = "now"

puts config.dashboard.theme      # "white"
puts config.dashboard.time       # #<BlackHoleStruct :from="now-1h" :to="now">
puts config.dashboard.time.from  # "now-1h"

config[:connection][:host] = "localhost"
config[:connection][:port] = 3000

puts config.to_h
# {
#   connection: {
#     host: "localhost",
#     port: 3000
#   }
#   dashboard: {
#     theme: "white",
#     time: {
#       from: "now-1h",
#       to: "now"
#     }
#   }
# }

config = BlackHoleStruct.new(theme: "white", connection: {port: 3000})
config.deep_merge!(connection: {host: 'localhost'})
puts config.to_h
# {
#   connection: {
#     host: "localhost",
#     port: 3000
#   }
#   theme: "white"
# }

```

## Is it any good

[Yes](https://news.ycombinator.com/item?id=3067434)

## Advanced usage

Check the [documentation](http://www.rubydoc.info/github/mickey/black-hole-struct/master/BlackHoleStruct).
