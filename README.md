# Daddy [![Gem Version](https://badge.fury.io/rb/daddy.svg)](https://badge.fury.io/rb/daddy)
=====

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'daddy'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install daddy

## Usage

When you just finish setting up CentOS-7, run these commands to make sudo available.
```
$ su
# sed -i -e 's/\(\/sbin:\/bin:\/usr\/sbin:\/usr\/bin\)$/&:\/usr\/local\/bin/' /etc/sudoers
# echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER
# exit
```

after that, running this commnd
```
$ bin/dad local
```
will get you
* Node.js
* Ruby
installed.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/daddy/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
