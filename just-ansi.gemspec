# frozen_string_literal: true

require_relative 'lib/just-ansi/version'

Gem::Specification.new do |spec|
  spec.name = 'just-ansi'
  spec.version = JustAnsi::VERSION
  spec.summary = 'Simple fast ANSI'
  spec.description = <<~DESCRIPTION
    Simple and fast ANSI code processing.
  DESCRIPTION

  spec.author = 'Mike Blumtritt'
  # spec.license = 'BSD-3-Clause'
  spec.homepage = 'https://github.com/mblumtritt/just-ansi'
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['bug_tracker_uri'] = "#{spec.homepage}/issues"
  spec.metadata['documentation_uri'] = 'https://rubydoc.info/gems/just-ansi'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.required_ruby_version = '>= 3.0'

  spec.files = Dir['lib/**/*']
  spec.extra_rdoc_files = %w[README.md]
end
