# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rbvhdl/version'

Gem::Specification.new do |spec|
  spec.name          = "rbvhdl"
  spec.version       = RbVHDL::VERSION
  spec.authors       = ["Ichiro Kawazome"]
  spec.email         = ["ichiro_k@ca2.so-net.ne.jp"]

  spec.summary       = "Ruby-based Toolkit for VHDL"
  spec.description   = "Ruby-based Toolkit for VHDL"
  spec.homepage      = "https://github.com/ikwzm/rbvhdl"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 12.3.3"
  spec.add_development_dependency "rspec", "~> 3.0"
end
