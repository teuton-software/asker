
require_relative "lib/asker/version"

Gem::Specification.new Asker::GEM, Asker::VERSION do |s|
  s.date        = Time.now.strftime("%Y-%m-%d")
  s.summary     = "Asker generates questions from input definitions file."
  s.description = "ASKER helps trainers to create a huge amount of questions, from a definitions input file."

  s.license     = 'GPL-3.0'
  s.authors     = ['David Vargas Ruiz']
  s.email       = 'teuton.software@protonmail.com'
  s.homepage    = Asker::HOMEPAGE

  s.extra_rdoc_files = [ 'README.md', 'LICENSE' ]
  s.executables << 'asker'
  s.files       = Dir.glob(File.join('lib','**','*.*'))

  s.required_ruby_version = '>= 3.0'

  # s.add_runtime_dependency 'haml', '~> 6.1'          # ruby > 2.1.0, 5.1
  s.add_runtime_dependency 'haml', '~> 5.2'
  s.add_runtime_dependency 'inifile', '~> 3.0'
  s.add_runtime_dependency 'rainbow', '~> 3.0'       # ruby > 2.3.0
  s.add_runtime_dependency 'colorize', '~> 0.8'
  s.add_runtime_dependency 'rexml', '~> 3.2'
  s.add_runtime_dependency 'terminal-table', '~> 3.0' # 1.8
  s.add_runtime_dependency 'thor', '~> 1.2'           # ruby > 2.0.0
end
