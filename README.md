# AutoData


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'auto_data'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install auto_data

## Usage
```ruby
    require 'auto_data'

    ENV["CONF_DATA_TEST"] = "user"
    ENV["CONF_ENV_TEST"] = "testing"

    login=AutoData::Data.new
    env = AutoData::Env.new

    login.load('config/data/users.yml')
    env.load('config/data/environment.yml')

    puts login.username
    puts login.password


```
## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Alejandro Aguilar Andrade/auto_data. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
