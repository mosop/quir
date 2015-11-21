# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'quir/version'

Gem::Specification.new do |spec|
  spec.name          = "quir"
  spec.version       = Quir::VERSION
  spec.authors       = ["mosop"]
  spec.email         = ["mosop@a.b.com"]

  spec.summary       = %q{A library utilized for autoloading.}
  spec.homepage      = "https://github.com/mosop/quir"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
