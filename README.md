# BlackHoleStruct

**BlackHoleStruct** is a data structure similar to an `OpenStruct`, that allows
infinite chaining of attributes or [autovivification](https://en.wikipedia.org/wiki/Autovivification).  

## Installation

Add it to your Gemfile:

```ruby
gem "black-hole-struct"
```

Or install the gem manually:

```sh
$ gem install black-hole-struct
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
```

### Advanced usage

Check the [documentation]().
