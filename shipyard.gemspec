spec = Gem::Specification.new do |s|
  s.name = "shipyard"
  s.version = "0.0.2"
  s.author = "Chris Kite"
  s.homepage = "http://www.github.com/chriskite/shipyard"
  s.platform = Gem::Platform::RUBY
  s.summary = "Code generation tool for database-backed applications"
  s.executables = %w[shipyard]
  s.require_path = "lib"
  s.has_rdoc = true
  s.rdoc_options << '-m' << 'README.rdoc' << '-t' << 'Shipyard'
  s.extra_rdoc_files = ["README.rdoc"]
  s.add_dependency("activesupport", ">= 2.3.8")
  s.add_dependency("sequel", ">= 3.12.0")

  s.files = Dir['lib/**/*', 'bin/**/*'] 

  s.test_files = Dir['spec/**/*']
end
