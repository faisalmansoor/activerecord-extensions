$:.unshift File.join(File.dirname(__FILE__), 'lib')
require 'activerecord-extensions/version'

Gem::Specification.new do |s|
  s.name     = 'activerecord-extensions'
  s.version  = ::ActiverecordExtensions::VERSION
  s.authors  = ['Faisal Mansoor']
  s.email    = ['faisal.mansoor@gmail.com']
  s.homepage = 'http://github.com/faisalmansoor'

  s.description = s.summary = 'Tools to help parametrize queries.'

  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true

  s.add_dependency 'activerecord', '>= 4.2.0', '< 5'

  # include only files in version control
  git_dir = File.expand_path('../.git', __FILE__)
  void = defined?(File::NULL) ? File::NULL :
      RbConfig::CONFIG['host_os'] =~ /msdos|mswin|djgpp|mingw/ ? 'NUL' : '/dev/null'

  if File.directory?(git_dir) and system "git --version >>#{void} 2>&1"
    s.files &= `git --git-dir='#{git_dir}' ls-files -z`.split("\0")
  end

end
