$:.unshift File.join(File.dirname(__FILE__), 'lib')
require 'activerecord-extensions/version'

Gem::Specification.new do |s|
  s.name     = 'activerecord-extensions'
  s.version  = ::ActiverecordExtensions::VERSION
  s.authors  = ['Faisal Mansoor']
  s.email    = ['faisal.mansoor@gmail.com']
  s.homepage = 'http://github.com/faisalmansoor'
  s.license = 'MIT'

  s.description = s.summary = 'Tools to help parametrize queries.'

  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true

  s.add_dependency 'activerecord', '>= 4.2.0', '< 7'

  s.files = Dir["{lib}/**/*.rb", "bin/*", "LICENSE", "*.md"]

end
