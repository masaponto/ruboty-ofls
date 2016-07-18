# Ruboty::Ofls
弊学の某室のシフト表をいい感じに表示します on ruboty

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruboty-ofls'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruboty-ofls

## Usage

```
$ echo "export OFLS_KEY = <your-google-spread-sheet-key-goes-here>" >> ~/.zshenv
$ echo "export OFLS_GID = <your-google-spread-sheet-gid-goes-here>" >> ~/.zshenv
```
  
If heroku, 
```
$ heroku config:set OFLS_KEY="<your-google-spread-sheet-gid-goes-here>"
$ heroku config:set OFLS_GID="<your-google-spread-sheet-gid-goes-here>"
```



## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/masaponto/ruboty-ofls.
