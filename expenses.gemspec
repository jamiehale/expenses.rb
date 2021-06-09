# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'expenses/version'

def add_development_dependencies(spec)
  spec.add_development_dependency "bundler", ">= 2.2.10"
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'cucumber'
  spec.add_development_dependency 'thor'
  spec.add_development_dependency 'aruba'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'ZenTest'
  spec.add_development_dependency 'rspec-autotest'
  spec.add_development_dependency 'rubocop'
end

Gem::Specification.new do |spec|
  spec.name = 'expenses'
  spec.version = Expenses::VERSION
  spec.authors = ['Jamie Hale']
  spec.email = ['jamie@smallarmyofnerds.com']

  spec.summary = 'Expense Projection Calculator'
  spec.description = 'Given a starting state and a set of expenses, project future balances.'
  spec.homepage = 'https://github.com/jamiehale/expenses.git'
  spec.license = 'GPL-3.0'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'TODO: Set to "http://mygemserver.com"'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  add_development_dependencies(spec)

end
