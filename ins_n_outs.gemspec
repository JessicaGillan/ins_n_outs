# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ins_n_outs/version'

Gem::Specification.new do |spec|
  spec.name          = "ins_n_outs"
  spec.version       = InsNOuts::VERSION
  spec.authors       = ["Jessica Gillan"]
  spec.email         = ["gillan.jessica@gmail.com"]

  spec.summary       = %q{ Generate rspec tests for method input and output datatypes }
  # spec.description   = %q{ }
  spec.homepage      = "https://github.com/JessicaGillan/ins_n_outs"
  spec.license       = "MIT"

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

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.5.0"
  spec.add_development_dependency "guard", "~> 2.14"
  spec.add_development_dependency "guard-shell", "~> 0.7.1"
  spec.add_development_dependency "guard-rspec", "~> 4.7.3"
  spec.add_development_dependency "rdoc"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "pry"
end
