# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "blight/version"

Gem::Specification.new do |s|
  s.name        = 'blight'
  s.version     = Blight::VERSION
  s.platform    = Gem::Platform::RUBY
  s.summary     = "ncurses with less cursing"
  s.description = "Blight provides a sane interface to the very procedural ncurses API"
  s.authors     = ["Justin Searls"]
  s.email       = 'searls@gmail.com'
  s.homepage    = 'https://github.com/searls/blight'
  
  s.add_dependency "ncurses-ruby"
  
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end