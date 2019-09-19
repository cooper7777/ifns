# Ifns

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ifns', github: 'inshopper/ifns'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ifns

## Usage

Create intitializer `config/initializers/ifns.rb`

```ruby
Ifns.configure do |config|
  config.host = 'YOUR_HOST'
  config.token = 'YOUR_TOKEN'
  config.logger = 'YOUR_LOGGER'
end
```

```ruby
example_data = { id: 'resource_id', fn: 8710000101674196, fd: 7078, fpd: 1050183412, date: '2019-03-01T12:21:00', sum: 209900, type_operation: 1}
client = ::Ifns::Client.new(example_data)
client.create_ticket
# wait 1500ms
client.find_ticket
# if response status is accepted do loop over 30 seconds and each 2 seconds retry request until you get a different status
# after loop if you still get accepted try again later
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
