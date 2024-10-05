# frozen_string_literal: true

require_relative 'lib/just-ansi/version'

Gem::Specification.new do |spec|
  spec.name = 'just-ansi'
  spec.version = JustAnsi::VERSION
  spec.summary = 'Simple fast ANSI'
  spec.description = <<~DESCRIPTION
    JustAnsi provides a rich set of methods to generate ANSI control codes for
    attributes, colors, cursor movement and much more. It supports most control
    codes, all attributes, 3/4bit-, 8bit- and 24bit-colors.
  DESCRIPTION

  spec.author = 'Mike Blumtritt'
  spec.license = 'MIT'
  spec.homepage = 'https://github.com/mblumtritt/just-ansi'
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['bug_tracker_uri'] = "#{spec.homepage}/issues"
  spec.metadata['documentation_uri'] = 'https://rubydoc.info/gems/just-ansi'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.required_ruby_version = '>= 3.0'

  spec.files = (Dir['lib/**/*'] + Dir['examples/**/*.rb']) << '.yardopts'
  spec.extra_rdoc_files = %w[README.md LICENSE]
end
