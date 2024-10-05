# frozen_string_literal: true

require_relative '../lib/just-ansi'

puts JustAnsi.bbcode <<~TEXT

  ✅ [b 2]Just Ansi[/b] — BBCode:[/]

              [b]Bold[/b]   [\\b]...[\\/b] or [\\bold]...[\\/bold]
             [faint]Faint[/faint]   [\\faint]...[\\/faint]
            [i]Italic[/i]   [\\i]...[\\/i] or [\|italic]...[\\/italic]
            [inv]Invert[/inv]   [\\inv]...[\\/inv] or [\\invert]...[\\/invert]
            [strike]Strike[/strike]   [\\strike]...[\\/strike]
              [h]Hide[/h]   [\\h]...[\\/h] or [\\hide]...[\\/hide] or [\\conceal]...[\\/conceal]
        [blink]Slow blink[/blink]   [\\blink]...[\\/blink] or [\\slow_blink]...[\\/slow_blink]
         [u]Underline[/u]   [\\u]...[\\/u] or [\\underline]...[\\/underline]
  [uu]Double underline[/uu]   [\\uu]...[\\/uu] or [\\double_underline]...[\\/double_underline]
   [cu]Curly underline[/cu]   [\\cu]...[\\/cu] or [\\curly_underline]...[\\/curly_underline]
  [dau]Dashed underline[/dau]   [\\dau]...[\\/dau] or [\\dashed_underline]...[\\/dashed_underline]
  [dou]Dotted underline[/dou]   [\\dou]...[\\/dou] or [\\dotted_underline]...[\\/dotted_underline]
           [fraktur]Fraktur[/fraktur]   [\\fraktur]...[\\/fraktur]
            [framed]Framed[/framed]   [\\framed]...[\\/framed]
         [encircled]Encircled[/encircled]   [\\encircled]...[\\/encircled]
         [ovr]Overlined[/ovr]   [\\ovr]...[\\/ovr] or [\\overlined]...[\\/overlined]
         [sub]Subscript[/sub]   [\\sub]...[\\/sub] or [\\subscript]...[\\/subscript]
       [sup]Superscript[/sup]   [\\sup]...[\\/sup] or [\\superscript]...[\\/superscript]

TEXT
