# frozen_string_literal: true

require_relative '../lib/just-ansi'

puts JustAnsi.bbcode <<~TEXT

  ✅ [b 2]Just Ansi[/b] — Attributes:[/]

  JustAnsi supports all well known attributes like [b]bold[/b], [i]italic[/i], [u]underline[/u], [blink]blink[/blink],
  [inv]invert[/inv] and [strike]strike[/strike]. Other attributes like [faint]faint[/faint], [double_underline]double underline[/], [curly_underline]curly
  underline[/], [dotted_underline]dotted underline[/], [dashed_underline]dashed underline[/], [rapid_blink]rapid_blink[/], [framed]framed[/], [encircled]encircled[/],
  [overlined]overlined[/] and [proportional]proportional[/] are not widely used but also supported.
  Alternative fonts are mostly completely ignored by terminal emulators:
  [primary_font]primary_font[/], [fraktur]fraktur[/], [font1]font1[/] ... [font9]font9[/].

TEXT
