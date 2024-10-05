# frozen_string_literal: true

require_relative '../lib/just-ansi'

puts JustAnsi.bbcode <<~TEXT

  ✅ [b 2]Just Ansi[/b] — 3bit-Colors:[/]

  [on_black] [/] [black]black[/]      [on_bright_black] [/] [bright_black]bright_black[/]
  [on_red] [/] [red]red[/]        [on_bright_red] [/] [bright_red]bright_red[/]
  [on_green] [/] [green]green[/]      [on_bright_green] [/] [bright_green]bright_green[/]
  [on_yellow] [/] [yellow]yellow[/]     [on_bright_yellow] [/] [bright_yellow]bright_yellow[/]
  [on_blue] [/] [blue]blue[/]       [on_bright_blue] [/] [bright_blue]bright_blue[/]
  [on_magenta] [/] [magenta]magenta[/]    [on_bright_magenta] [/] [bright_magenta]bright_magenta[/]
  [on_cyan] [/] [cyan]cyan[/]       [on_bright_cyan] [/] [bright_cyan]bright_cyan[/]
  [on_white] [/] [white]white[/]      [on_bright_white] [/] [bright_white]bright_white[/]

TEXT
