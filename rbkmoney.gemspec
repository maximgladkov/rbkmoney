# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rbkmoney/version'

Gem::Specification.new do |gem|
  gem.name          = "rbkmoney"
  gem.version       = RBKMoney::VERSION
  gem.authors       = ["Maksim Gladkov"]
  gem.email         = ["maksim.gladkov@gmail.com"]
  gem.description   = %q{This gem helps to integrate RBK Money payments into Ruby on Rails applications.}
  gem.summary       = %q{RBK Money wrapper gem for Ruby on Rails}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
