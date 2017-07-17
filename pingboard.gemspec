lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name          = 'pingboard'
  s.version       = '0.0.1'
  s.date          = '2017-07-16'
  s.summary       = "The Pingboard API Ruby Client"
  s.description   = "A Ruby client interface for the Pingboard API"
  s.authors       = ["Bryan B. Cabalo"]
  s.email         = 'bcabalo@gmail.com'
  s.require_paths = %w(lib)
  s.files         = %w(lib/pingboard.rb README.md pingboard.gemspec) + Dir['lib/**/*.rb']
  s.homepage      = 'http://rubygems.org/gems/pingboard'
  s.license       = 'MIT'
end
