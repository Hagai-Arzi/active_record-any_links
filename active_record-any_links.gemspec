# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_record/any_links/version'

Gem::Specification.new do |spec|
  spec.name          = "active_record-any_links"
  spec.version       = ActiveRecord::AnyLinks::VERSION
  spec.authors       = ["Hagai Arzi"]
  spec.email         = ["Hagai.Arzi@Gmail.com"]

  spec.summary       = %q{Link objects of different models easily, using a single common connection table. }
  spec.description   = %q{Link objects of different models in a single common table named "any_links" using
                       has_many_to_many, has_many_to_one or has_one_to_many new methods.
                       There is no need for creating a new table for any connection type, nor buiding an
                       "has_many through" associations.}
  spec.homepage      = "https://github.com/Hagai-Arzi/active_record-any_links/tree/master/lib/active_record"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "sqlite3", "~> 1.3"
  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  # spec.add_development_dependency 'byebug'
  # spec.add_development_dependency 'pry-byebug'
  # spec.add_development_dependency 'pry-rails'
  # spec.add_development_dependency 'pry-stack_explorer'

  spec.add_dependency "activerecord", ">= 4.2"
end
