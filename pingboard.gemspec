lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name          = 'pingboard'
  s.version       = '0.0.6'
  s.date          = '2017-07-25'
  s.summary       = "The Pingboard API Ruby Client"
  s.description   = "A Ruby client interface for the Pingboard API"
  s.authors       = ["Bryan B. Cabalo"]
  s.email         = 'bcabalo@gmail.com'
  s.require_paths = %w(lib)

  s.required_ruby_version = ">= 2.0.0"

  s.files         = %w(lib/pingboard.rb README.md pingboard.gemspec) + Dir['lib/**/*.rb']
  s.homepage      = 'http://rubygems.org/gems/pingboard'
  s.license       = 'MIT'
end
