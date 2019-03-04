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
example_data = { id: 'resource_id', fn: 8710000101674196, fd: 7078, fpd: 1050183412, date: '2019-03-01T12:21:00', sum: 209900,
                 type_operation: 1}
client = ::Ifns::Client.new(example_data)
client.create_validation
# wait 500ms
client.find_validation
client.create_ticket
# wait 500ms
client.find_ticket
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/inshopper/ifns. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Ifns project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/ifns/blob/master/CODE_OF_CONDUCT.md).
