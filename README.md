# Pingboard API Ruby Client

[![Gem Version](https://badge.fury.io/rb/pingboard.svg)](https://rubygems.org/gems/pingboard)
[![Build Status](https://travis-ci.org/bry/pingboard.svg)](https://travis-ci.org/bry/pingboard)
[![Code Climate](https://codeclimate.com/github/bry/pingboard.svg)](https://codeclimate.com/github/bry/pingboard)
[![Test Coverage](https://codeclimate.com/github/bry/pingboard/badges/coverage.svg)](https://codeclimate.com/github/bry/pingboard/coverage)
[![Inline Docs](https://inch-ci.org/github/bry/pingboard.svg?style=shields)](https://inch-ci.org/github/bry/pingboard)
[![Downloads](https://img.shields.io/gem/dt/pingboard.svg)](https://rubygems.org/gems/pingboard)

The Ruby client interface to the [Pingboard](https://pingboard.com/) [API](http://docs.pingboard.apiary.io/)

## Features

* Efficient [client credentials flow](http://docs.pingboard.apiary.io/#reference/authentication/client-credentials-flow/client-credentials-flow) request token expiration handling

## Installation

### Install
```
gem install pingboard
```

### Gemfile
```
gem 'pingboard', '~> 0.0.5'
```

## Documentation
http://www.rubydoc.info/gems/pingboard

## Configuration

```ruby
client = Pingboard::Client.new do |config|
  config.service_app_id = 'SERVICE_APP_ID'
  config.service_app_secret = 'SERVICE_APP_SECRET'
end
```

## Usage Examples
After configuring a `client`, you can do the following:

### Search
Search for a Pingboard user
```ruby
client.search("Pingboard text query")
```

### Users
Get all Pingboard users

```ruby
client.users
```

Get a Pingboard user by user ID

```ruby
client.user("12345")
```

### Status

Get a Pingboard status by status ID
```ruby
client.status("12345")
```

### Status Types

Get Pingboard's status types
```ruby
client.status_types
```

## Supported Ruby Versions
This library is [tested](https://travis-ci.org/bry/pingboard) against the following Ruby versions:

* Ruby 2.4.0

## Versioning
This library uses [Semantic Versioning 2.0.0](http://semver.org/)

## License
MIT License

Copyright (c) 2017 Bryan B. Cabalo

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
