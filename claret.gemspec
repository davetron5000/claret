# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','claret','version.rb'])
spec = Gem::Specification.new do |s| 
  s.name = 'claret'
  s.version = Claret::VERSION
  s.author = 'David Copeland'
  s.email = 'davidcopeland@naildrivin5.com'
  s.homepage = 'http://your.naildrivin5.com'
  s.platform = Gem::Platform::RUBY
  s.summary = 'A dependency-based CLI todo app'
# Add your other files here if you make them
  s.files = %w(
bin/claret
lib/claret/commands/add.rb
lib/claret/commands/list.rb
lib/claret/commands/task.rb
lib/claret/smart_task_parser.rb
lib/claret/task.rb
lib/claret/task_list.rb
lib/claret/task_list_terminal_serializer.rb
lib/claret/task_list_yaml_serializer.rb
lib/claret/version.rb
lib/claret.rb
  )
  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc','claret.rdoc']
  s.rdoc_options << '--title' << 'claret' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'claret'
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('aruba')
  s.add_development_dependency('clean_test')
  s.add_runtime_dependency('gli')
end
