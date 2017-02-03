# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "jira_diff/globals"

Gem::Specification.new do |spec|
  spec.name    = "devtools-jdiff"
  spec.version = JIRADiff::VERSION
  spec.authors = ["Donovan Young"]
  spec.email   = ["dyoung522@gmail.com"]

  spec.summary     = %q{Compares git branches, searching for JIRA stories}
  spec.description = %q{Looks for JIRA stories within the commits in a git repository} +
                     %q{and compares branches to find stories included in one branch} +
                     %q{but not another}
  spec.homepage    = "https://github.com/dyoung522/devtools-jdiff"
  spec.license     = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "config", "~> 1.3"
  spec.add_dependency "octokit", "~> 4.0"
  spec.add_dependency "devtools-base", "~> 2.0"

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~> 0.4"
  spec.add_development_dependency "factory_girl", "~> 4.0"
end
