Gem::Specification.new do |s|
  s.name        = 'iblox'
  s.version     = '0.0.2'
  s.date        = '2012-05-23'
  s.summary     = "iBlox: Infoblox cli wrapper"
  s.description = "A simple Infoblox CLI wrapper"
  s.authors     = ["Matthew Nicholson"]
  s.email       = 'matthew.a.nicholson@gmail.com'
  s.files       = ["lib/iblox.rb"]
  s.executables << "iblox"
  s.homepage    =
    'http://rubygems.org/gems/iblox'
  s.license       = 'GPL'
  s.add_development_dependency "bundler", "~> 1.10"
  s.add_runtime_dependency "infoblox", "~> 0.5.3"
end
