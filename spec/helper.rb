# frozen_string_literal: true

require_relative '../lib/just-ansi'
require_relative '../lib/no-ansi'
require_relative '../lib/just-ansi/version'

$stdout.sync = $stderr.sync = $VERBOSE = true
RSpec.configure(&:disable_monkey_patching!)
def fixture(name) = File.read(File.join(__dir__, 'fixtures', name))
