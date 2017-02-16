# AutoData

Manage test data and environment configuration for automated test projects.

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

YML files are needed to define data.

<b>AUTO_DATA_PATH</b>  : Configuration data file path

if you are working with cucumber include the next line to <b>env.rb</b> file
```ruby
ENV["AUTO_DATA_PATH"] =  File.absolute_path('../..', File.dirname(__FILE__)).to_s
```
if not use using cucumber, place to the variable the project root path in your ruby class
```ruby
ENV["AUTO_DATA_PATH"] =  <<YML path files>>
```
### Sample
```ruby

    require 'auto_data'
    #Set configuration file path (Assumming that class is under root folder)

    ENV["AUTO_DATA_PATH"] =  File.dirname(__FILE__)

    #Create AutoData object
    autodata = AutoData::Parse.new

    #Print values  format:objectname.filename('key.subkey')
    #Users file
    puts test.users('mananger.login')        #=> manager_id
    puts test.users('mananger.password')     #=> zaq12wsx
    puts test.users('mananger.username')     #=> Batman

    #Environment file
    puts test.environment('testing.base_url') #=> http://testing.sample.com


```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/alekxaguilar/auto_data/issues. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
