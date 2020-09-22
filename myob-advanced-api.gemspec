# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'myob_advanced/api/version'

Gem::Specification.new do |spec|
  spec.name          = "myob-advanced-api"
  spec.version       = MyobAdvanced::Api::VERSION
  spec.authors       = ["Van Nguyen"]
  spec.email         = ["bichvannguyenvnn@gmail.com"]
  spec.description   = %q{MYOB Advanced API}
  spec.summary       = %q{MYOB Advanced API}
  spec.homepage      = "https://github.com/vannguyenvietnam/myob-advanced-api"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "oauth2", "~> 1.4"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
