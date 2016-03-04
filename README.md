# Quir

A Ruby library utilized for autoloading. Pronounce kwaɪə[r]. https://rubygems.org/gems/quir

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'quir'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install quir

## Usage

### Simple Example

File hierarchy:

```
main.rb
main/explicit.rb
main/explicit/a.rb
main/implicit/b.rb
```

```ruby
# main.rb

require 'quir'

module Main
  Quir.autoload! {}
end

# main/explicit.rb

module Main
  module Explicit
    Quir.autoload! {}
  end
end

# main/explicit/a.rb

module Main::Explicit
  module A
  end
end

# main/implicit/a.rb

module Main::Implicit
  class B
  end
end
```

And the following code does not raise error:

```ruby
Main::Explicit::A
Main::Implicit::B
```

### Name Resolution

Quir determines constant names by converting filename into pascal-case. For example, `two_words_class.rb` will be `TwoWordsClass`.

### Automatic Namespace Definition

In the above example, you don't have to explicitly define Main::Implicit. Because Quir automatically defines missing intermediate modules. The name of defined module will be pascal-case of the corresponding directory's name.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mosop/quir.
