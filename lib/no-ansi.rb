# frozen_string_literal: true

require_relative 'just-ansi'

#
# Shadow to {JustAnsi} which methods do not use ANSI codes.
# This can be used as an {JustAnsi} replacement.
#
# @example Define global Ansi module depending on `NO_COLOR` environment variable
#   Ansi = ENV.key?('NO_COLOR') ? NoAnsi : JustAnsi
#
#   puts Ansi.bbcode('[b]Hello World![/b]')
#   # => prints bold text when 'NO_COLOR' was not defined
#
# @see JustAnsi
#
module NoAnsi
  class << self
    # @!visibility private
    def attributes = JustAnsi.attributes
    # @!visibility private
    def colors = JustAnsi.colors
    # @!visibility private
    def named_colors = JustAnsi.named_colors
    # @!visibility private
    def valid?(*attributes) = JustAnsi.valid?(*attributes)
    # @!visibility private
    def ansi?(str) = JustAnsi.ansi?(str)
    # @!visibility private
    def decorate(str, *_, **_) = JustAnsi.undecorate(str)
    # @!visibility private
    def undecorate(str) = JustAnsi.undecorate(str)
    # @!visibility private
    def bbcode(str) = JustAnsi.unbbcode(str)
    # @!visibility private
    def unbbcode(str) = JustAnsi.unbbcode(str)
    # @!visibility private
    def plain(str) = JustAnsi.plain(str)

    # @!visibility private
    def try_convert(attributes, seperator: ' ')
      return unless attributes
      return if (attributes = attributes.to_s.split(seperator)).empty?
      +'' if JustAnsi.valid?(*attributes)
    end

    # @!visibility private
    def [](*_) = +''
    # @!visibility private
    def rainbow(str, **_) = "#{str}"
    # @!visibility private
    def cursor_pos(_row, _column = nil) = +''
    # @!visibility private
    def link(_url, text) = "#{text}"

    # @!visibility private
    def dummy0 = +''
    # @!visibility private
    def dummy1(_ = 1) = +''

    alias cursor_up dummy1
    alias cursor_down dummy1
    alias cursor_forward dummy1
    alias cursor_back dummy1
    alias cursor_next_line dummy1
    alias cursor_previous_line dummy1
    alias cursor_prev_line cursor_previous_line
    alias cursor_column dummy1
    alias cursor_show dummy0
    alias cursor_hide dummy0
    alias cursor_pos_safe dummy0
    alias cursor_pos_restore dummy0
    alias screen_erase_below dummy0
    alias screen_erase_above dummy0
    alias screen_erase dummy0
    alias screen_erase_scrollback dummy0
    alias screen_save dummy0
    alias screen_restore dummy0
    alias screen_alternate dummy0
    alias screen_alternate_off dummy0
    alias line_erase_to_end dummy0
    alias line_erase_to_start dummy0
    alias line_erase dummy0
    alias line_insert dummy1
    alias line_delete dummy1
    alias scroll_up dummy1
    alias scroll_down dummy1
    alias window_title dummy1
    alias tab_title dummy1

    private :dummy0, :dummy1
  end

  JustAnsi.constants.each { const_set(_1, _1 == 'VERSION' ? _1 : '') }
end
