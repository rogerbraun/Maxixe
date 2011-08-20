# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "maxixe/version"

Gem::Specification.new do |s|
  s.name        = "maxixe"
  s.version     = Maxixe::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Roger Braun"]
  s.email       = ["maxixe@rogerbraun.net"]
  s.homepage    = "https://github.com/rogerbraun/Maxixe"
  s.summary     = %q{A small statistical segmenter for any language.}
  s.description = %q{Maxixe is an implementation of the Tango algorithm describe in the paper "Mostly-unsupervised statistical segmentation of Japanese kanji sequences" by Ando and Lee. While the paper deals with Japanese characters, it should work on any unsegmented text given enough corpus data and a tuning of the algorithm paramenters.}

  s.rubyforge_project = "maxixe"

  s.add_dependency "yajl-ruby"
  s.add_development_dependency "rspec"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
