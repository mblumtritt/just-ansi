# frozen_string_literal: true

require_relative '../lib/just-ansi'
require_relative '../lib/just-ansi/version'

$stdout.sync = $stderr.sync = $VERBOSE = true
RSpec.configure(&:disable_monkey_patching!)
