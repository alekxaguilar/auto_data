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
    #Define the global key variables
    ENV["CONF_DATA_TEST"] = "manager"
    ENV["CONF_ENV_TEST"] = "testing"

    login=AutoData::Data.new
    env = AutoData::Env.new
    #Set path file that contains value details
    login.load('config/data/users.yml')
    env.load('config/data/environment.yml')

    #Use the information as you have defined in the yml conf file
    puts login.login      #=> manager_id
    puts login.password   #=> zaq12wsx
    puts login.username   #=> Batman

    #environment
    puts env.base_url     #=> http://testing.sample.com



```

###Switch global keys

Switch global keys variable in runtime

```ruby
login.change_scope('customer')
env.change_scope('uat')

#Use the information as you have defined in the yml conf file
puts login.login      #=> customer_id
puts login.password   #=> zaq12wsx
puts login.username   #=> Robin

#environment
puts env.base_url     #=> http://uat.sample.com

```
## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/alekxaguilar/auto_data/issues. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
