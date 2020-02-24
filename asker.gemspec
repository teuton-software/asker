require_relative 'lib/asker/application'

Gem::Specification.new do |s|
  s.name        = Application::NAME
  s.version     = Application::VERSION
  s.date        = '2020-02-24'
  s.summary     = "Asker generates questions from input definitions file."
  s.description = "ASKER helps trainers to create a huge amount of questions, from a definitions input file."
  s.extra_rdoc_files = [ 'README.md', 'LICENSE' ] +
                         Dir.glob(File.join('docs','**','*.md'))

  s.license     = 'GPL-3.0'
  s.authors     = ['David Vargas Ruiz']
  s.email       = 'teuton.software@protonmail.com'
  s.homepage    = 'https://github.com/dvarrui/asker'

  s.executables << 'asker'
  #s.executables << 'asker.bat'
  s.files       = Dir.glob(File.join('lib','**','*.rb')) +
                  Dir.glob(File.join('lib','asker','files','*'))

  s.required_ruby_version = '>= 2.3.0'

  s.add_runtime_dependency 'base64_compatible', '~> 0.0'
  s.add_runtime_dependency 'coderay', '~> 1.1'
  s.add_runtime_dependency 'haml', '~> 5.1'
  s.add_runtime_dependency 'inifile', '~> 3.0'
  s.add_runtime_dependency 'rainbow', '~> 3.0'
  s.add_runtime_dependency 'sinatra', '~> 2.0'
  s.add_runtime_dependency 'terminal-table', '~> 1.8'
  s.add_runtime_dependency 'thor', '~> 0.20'

  s.add_development_dependency 'minitest', '~> 5.11'
  s.add_development_dependency 'rubocop', '~> 0.74'

  s.post_install_message = "Thanks for installing!"
end
