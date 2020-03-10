VERSION = '0.1.0'

Gem::Specification.new do |spec|

  spec.name                  = "node_impl"
  spec.version               = VERSION
  spec.authors               = ["Bradley J. Tannor", "Diligent Software LLC"]
  spec.email                 = ["bradleytannor@gmail.com"]
  spec.summary               = %q{A doubly-linked Node implementation
component.}
  spec.description           = %q{A doubly-linked Node implementation
component. Implements the Node interface: https://github.com/Diligent-Software-LLC/node_int.
Donations support continuous improvement. Make a donation at the project's
collective page: https://opencollective.com/node. Greatly appreciated.}
  spec.homepage              = "https://docs.diligentsoftware
.org/node/implementation"
  spec.license               = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.6.5")

  # Metadata
  spec.metadata['homepage_uri']    = spec.homepage
  spec.metadata['source_code_uri'] =
      "https://github.com/Diligent-Software-LLC/node_impl"
  spec.metadata['changelog_uri']   = "https://www.docs.diligentsoftware.org/" +
      "node/implementation#changelog"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Development and testing dependencies
  spec.add_development_dependency "bundler", "~> 2.1.2"
  spec.add_development_dependency "simplecov", "~> 0.17.1"

  # Gem specific runtime dependencies
  spec.add_runtime_dependency 'node_int', '~> 0.1.0'

end
