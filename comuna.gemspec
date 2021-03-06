# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'comuna/version'

Gem::Specification.new do |spec|
  spec.name          = "comuna"
  spec.version       = Comuna::VERSION
  spec.authors       = ["Edgar Cabrera"]
  spec.email         = ["edgar@cafeinacode.com"]
  spec.licenses    = ['MIT']
  
  spec.summary       = %q{Small, easy to configure DNS server for local networks.}
  spec.description   = %q{Leverages the power of RubyDNS and the simplicity of YAML for a simple DNS server for local networks.}
  spec.homepage      = "https://github.com/aleandros/comuna"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'rubydns', '~> 1.0'
  spec.add_dependency 'thor', '~> 0.19'

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
end
