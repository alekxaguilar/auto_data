# AutoData
[![Gem Version](https://badge.fury.io/rb/auto_data.svg)](https://badge.fury.io/rb/auto_data)

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
YML's [sample data](https://github.com/alekxaguilar/auto_data/tree/master/config/data)

Optional YML file structure:

```yml
default_key: user_role2 #optional

user_role1:
    userid: userid1
user_role2:
    userid: userid2
```
Code using custom key and sub-key words
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
Using custom default_key option
```ruby

    #Create AutoData object
    autodata = AutoData::Parse.new

    #users.yml file must has default_key, i.e. 'default_key: manager'
    puts test.users('login')        #=> manager_id
    puts test.users('password')     #=> zaq12wsx1
    puts test.users('username')     #=> Batman



```
Changing default_key from code

```ruby

    test.change_scope('users','customer')

    #print again
    puts test.users('login')        #=> customer_id
    puts test.users('password')     #=> zaq12wsx2
    puts test.users('username')     #=> Robin

```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/alekxaguilar/auto_data/issues. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
