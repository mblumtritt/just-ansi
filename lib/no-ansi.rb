# frozen_string_literal: true

require_relative 'just-ansi'

module NoAnsi
  class << self
    def attributes = JustAnsi.attributes
    def colors = JustAnsi.colors
    def named_colors = JustAnsi.named_colors
    def valid?(*attributes) = JustAnsi.valid?(*attributes)
    def ansi?(str) = JustAnsi.ansi?(str)
    def decorate(str, *_, **_) = JustAnsi.undecorate(str)
    def undecorate(str) = JustAnsi.undecorate(str)
    def bbcode(str) = JustAnsi.unbbcode(str)
    def unbbcode(str) = JustAnsi.unbbcode(str)
    def plain(str) = JustAnsi.plain(str)

    def try_convert(attributes, seperator: ' ')
      return unless attributes
      return if (attributes = attributes.to_s.split(seperator)).empty?
      +'' if JustAnsi.valid?(*attributes)
    end

    def [](*_) = +''
    def rainbow(str, **_) = "#{str}"
    def cursor_pos(_row, _column = nil) = +''
    def link(_url, text) = "#{text}"
    def window_title(title) = "#{title}"
    def tab_title(title) = "#{title}"

    def dummy0 = +''
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

    private :dummy0, :dummy1
  end

  JustAnsi.constants.each { const_set(_1, _1 == 'VERSION' ? _1 : '') }
end
