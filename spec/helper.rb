# frozen_string_literal: true

require_relative '../lib/just-ansi'

$stdout.sync = $stderr.sync = $VERBOSE = true
RSpec.configure(&:disable_monkey_patching!)
