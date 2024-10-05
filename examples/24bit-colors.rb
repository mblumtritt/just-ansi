# frozen_string_literal: true

require_relative '../lib/just-ansi'

colors =
  JustAnsi
    .named_colors
    .delete_if { /\d/.match?(_1) }
    .map! { "[on_#{_1}] [/] [#{_1}]#{_1.to_s.ljust(22)}[/]" }
    .each_slice(3)
    .map(&:join)
    .join("\n")

puts JustAnsi.bbcode <<~TEXT

  ✅ [b 2]Just Ansi[/b] — 24bit-Colors:[/]

  #{colors}

TEXT
