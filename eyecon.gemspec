# frozen_string_literal: true

require_relative "lib/eyecon/version"

Gem::Specification.new do |spec|
  spec.name          = "eyecon"
  spec.version       = Eyecon::VERSION
  spec.authors       = ["hachy"]
  spec.email         = ["1613863+hachy@users.noreply.github.com"]

  spec.summary       = "Check if your app icon is eye-catching design in Google Play."
  spec.description   = "Put your app icon in the google play search. Is it easy to find?"
  spec.homepage      = "https://github.com/hachy/eyecon"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/hachy/eyecon"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri"
  spec.add_dependency "thor"
end
