# frozen_string_literal: true
# shareable_constant_value: literal

module JustAnsi
  class << self
    # Supported attribute names.
    #
    # @see []
    #
    # @attribute [r] attributes
    # @return [Array<Symbol>] all attribute names
    def attributes = ATTRIBUTES_S.keys

    # Supported 3/4-bit color names.
    #
    # @see []
    #
    # @attribute [r] colors
    # @return [Array<Symbol>] all color names
    def colors = COLORS_S.keys

    # Supported basic 24-bit color names.
    #
    # @see []
    #
    # @attribute [r] named_colors
    # @return [Array<Symbol>] all basic named_colors names
    def named_colors = NAMED_COLORS.keys.map!(&:to_sym)

    # Combine given ANSI {.attributes}, {.colors}, {.named_colors} and color
    # codes.
    #
    # Colors can specified by their name for ANSI 3-bit and 4-bit colors.
    # For 8-bit ANSI colors use 2-digit hexadecimal values `00`...`ff`.
    #
    # To use RGB ANSI colors (24-bit colors) specify 3-digit or 6-digit
    # hexadecimal values `000`...`fff` or `000000`...`ffffff`.
    # This represent the `RRGGBB` values (or `RGB` for short version) like you
    # may known from CSS color notation.
    #
    # To use a color as background color prefix the color attribute with `bg_`
    # or `on_`.
    # To use a color as underline color prefix the color attribute with `ul_`.
    # To clarify that a color attribute have to be used as foreground
    # color use the prefix `fg_`.
    #
    # @example Valid Foreground Color Attributes
    #   JustAnsi[:yellow]
    #   JustAnsi[:fg_fab]
    #   JustAnsi[:fg_00aa00]
    #   JustAnsi[:af]
    #   JustAnsi[:fg_af]
    #   JustAnsi['#fab']
    #   JustAnsi['#00aa00']
    #   JustAnsi['lightblue']
    #
    # @example Valid Background Color Attributes
    #   JustAnsi[:bg_yellow]
    #   JustAnsi[:bg_fab]
    #   JustAnsi[:bg_00aa00]
    #   JustAnsi[:bg_af]
    #   JustAnsi['bg#00aa00']
    #   JustAnsi['bg_lightblue']
    #
    #   JustAnsi[:on_yellow]
    #   JustAnsi[:on_fab]
    #   JustAnsi[:on_00aa00]
    #   JustAnsi[:on_af]
    #   JustAnsi['on#00aa00']
    #   JustAnsi['on_lightblue']
    #
    # @example Valid Underline Color Attributes
    #   JustAnsi[:underline, :ul_yellow]
    #   JustAnsi[:underline, :ul_fab]
    #   JustAnsi[:underline, :ul_00aa00]
    #   JustAnsi[:underline, :ul_fa]
    #   JustAnsi[:underline, :ul_bright_yellow]
    #   JustAnsi[:underline, 'ul#00aa00']
    #   JustAnsi['underline', 'ul_lightblue']
    #
    # @example Combined attributes:
    #   JustAnsi[:bold, :italic, :bright_white, :on_0000cc]
    #
    # @param attributes [Array<Symbol, String>] attribute names to be used
    # @return [String] combined ANSI attributes
    def [](*attributes)
      return +'' if attributes.empty?
      "\e[#{
        attributes
          .map do |arg|
            case arg
            when Symbol
              ATTRIBUTES_S[arg] || COLORS_S[arg] || _color(arg) || _invalid(arg)
            when String
              ATTRIBUTES[arg] || COLORS[arg] || _color(arg) || _invalid(arg)
            when (0..255)
              "38;5;#{arg}"
            when (256..511)
              "48;5;#{arg - 256}"
            when (512..767)
              "58;5;#{arg - 512}"
            else
              _invalid(arg)
            end
          end
          .join(';')
      }m"
    end

    # Test if all given attributes are valid.
    #
    # @see []
    #
    # @param attributes [Array<Symbol, String>] attribute names to be used
    # @return [true, false] whether if all given attributes are valid
    def valid?(*attributes)
      attributes.all? do |arg|
        case arg
        when Symbol
          ATTRIBUTES_S[arg] || COLORS_S[arg] || _color(arg) || false
        when String
          ATTRIBUTES[arg] || COLORS[arg] || _color(arg) || false
        when (0..767)
          true
        else
          false
        end
      end
    end

    # Test if given String contains ANSI codes.
    #
    # @param str [#to_s] object to be tested
    # @return [true, false] whether if attributes are found
    def ansi?(str) = TEST.match?(str.to_s)

    # Decorate given `str` with ANSI attributes and colors.
    #
    # @see []
    # @see undecorate
    #
    # @param str [#to_s] object to be decorated
    # @param attributes [Array<Symbol, String>] attribute names to be used
    # @param reset [true, false] whether to include reset code for ANSI attributes
    # @return [String] `str` converted and decorated with the ANSI `attributes`
    def decorate(str, *attributes, reset: true)
      attributes = self[*attributes]
      attributes.empty? ? "#{str}" : "#{attributes}#{str}#{"\e[m" if reset}"
    end

    # Remove ANSI functions, attributes and colors from given string.
    #
    # @see decorate
    #
    # @param str [#to_s] string to be modified
    # @return [String] string without ANSI attributes
    def undecorate(str) = str.to_s.gsub(TEST, '')

    # Try to combine given ANSI attributes and colors.
    # The attributes and colors have to be seperated by given `seperator``.
    #
    # @example Valid Attribute String
    #   JustAnsi.try_convert('bold italic blink red on#00ff00')
    #   # => ANSI attribute string for bold, italic text which blinks red on
    #   #    green background
    #
    # @example Invalid Attribute String
    #   JustAnsi.try_convert('cool bold on green')
    #   # => nil
    #
    # @see []
    #
    # @param attributes [#to_s] attributes separated by given `seperator`
    # @param seperator [String] attribute seperator char
    # @return [String] combined ANSI attributes
    # @return [nil] when string does not contain valid attributes
    def try_convert(attributes, seperator: ' ')
      return unless attributes
      return if (attributes = attributes.to_s.split(seperator)).empty?
      "\e[#{
        attributes
          .map! { ATTRIBUTES[_1] || COLORS[_1] || _color(_1) || return }
          .join(';')
      }m"
    end

    # @!group Control functions

    # Move cursor given lines up.
    #
    # @param lines [Integer] number of lines to move
    # @return [String] ANSI control code
    def cursor_up(lines = 1) = "\e[#{lines}A"

    # Move cursor given lines down.
    #
    # @param (see cursor_up)
    # @return (see cursor_up)
    def cursor_down(lines = 1) = "\e[#{lines}B"

    # Move cursor given colums forward.
    #
    # @param columns [Integer] number of columns to move
    # @return (see cursor_up)
    def cursor_forward(columns = 1) = "\e[#{columns}C"

    # Move cursor given colums back.
    #
    # @param (see cursor_forward)
    # @return (see cursor_up)
    def cursor_back(columns = 1) = "\e[#{columns}D"

    # Move cursor of beginning of the given next line.
    #
    # @param (see cursor_up)
    # @return (see cursor_up)
    def cursor_next_line(lines = 1) = "\e[#{lines}E"

    # Move cursor of beginning of the given previous line.
    #
    # @param (see cursor_up)
    # @return (see cursor_up)
    def cursor_previous_line(lines = 1) = "\e[#{lines}F"
    alias cursor_prev_line cursor_previous_line

    # Move cursor to given column in the current row.
    #
    # @param column [Integer] column index
    # @return (see cursor_up)
    def cursor_column(column = 1) = "\e[#{column}G"

    # Move cursor to given row and column counting from the top left corner.
    #
    # @param row [Integer] row index
    # @param column [Integer] column index
    # @return (see cursor_up)
    def cursor_pos(row, column = nil)
      return column ? "\e[;#{column}H" : "\e[H" unless row
      column ? "\e[#{row};#{column}H" : "\e[#{row}H"
    end

    # Show cursor.
    #
    # @return (see cursor_up)
    def cursor_show = +CURSOR_SHOW

    # Hide cursor.
    #
    # @return (see cursor_up)
    def cursor_hide = +CURSOR_HIDE

    # Safe current cursor position.
    #
    # @return (see cursor_up)
    def cursor_pos_safe = +CURSOR_POS_SAFE

    # Restore safed cursor position.
    #
    # @return (see cursor_up)
    def cursor_pos_restore = +CURSOR_POS_RESTORE

    # Erase screen below current cursor line.
    #
    # @return (see cursor_up)
    def screen_erase_below = _screen_erase(0)

    # Erase screen above current cursor line.
    #
    # @return (see cursor_up)
    def screen_erase_above = _screen_erase(1)

    # Erase complete screen.
    #
    # @return (see cursor_up)
    def screen_erase = _screen_erase(2)

    # Erase screen scrollback buffer.
    #
    # @return (see cursor_up)
    def screen_erase_scrollback = _screen_erase(3)

    # Safe current screen.
    #
    # @return (see cursor_up)
    def screen_save = +SCREEN_SAVE

    # Restore current screen.
    #
    # @return (see cursor_up)
    def screen_restore = +SCREEN_RESTORE

    # Use alternative screen buffer.
    #
    # @return (see cursor_up)
    def screen_alternate = +SCREEN_ALTERNATE

    # Do not longer use alternative screen buffer.
    #
    # @return (see cursor_up)
    def screen_alternate_off = +SCREEN_ALTERNATE_OFF

    # Erase line from current column to end of line.
    #
    # @return (see cursor_up)
    def line_erase_to_end = _line_erase(0)

    # Erase line from current column to start of line.
    #
    # @return (see cursor_up)
    def line_erase_to_start = _line_erase(1)

    # Erase current line.
    #
    # @return (see cursor_up)
    def line_erase = _line_erase(2)

    # Scroll window given lines up.
    #
    # @param lines [Integer] number of lines to scroll
    # @return (see cursor_up)
    def scroll_up(lines = 1) = "\e[;#{lines}S"

    # Scroll window given lines down.
    #
    # @param (see scroll_up)
    # @return (see cursor_up)
    def scroll_down(lines = 1) = "\e[;#{lines}T"

    # Change window title.
    # This is not widely supported.
    #
    # @param [String] title text
    # @return (see cursor_up)
    def window_title(title) = "\e]2;#{title}\e\\"

    # Change tab title.
    # This is not widely supported.
    #
    # @param [String] title text
    # @return (see cursor_up)
    def tab_title(title) = "\e]0;#{title}\a"

    # Create a hyperlink.
    # This is not widely supported.
    def link(url, text) = "\e]8;;#{url}\e\\#{text}\e]8;;\e\\"

    # @!endgroup

    # @comment seems not widely supported:
    # @comment  doubled!? def cursor_column(column = 1) = "\e[#{column}`"
    # @comment  doubled!? def cursor_row(row = 1) = "\e[#{row}d"
    # @comment  def cursor_column_rel(columns = 1) = "\e[#{columns}a"
    # @comment  def cursor_row_rel(rows = 1) = "\e[#{rows}e"
    # @comment  def cursor_tab(count = 1) = "\e[#{column}I"
    # @comment  def cursor_reverse_tab(count = 1) = "\e[#{count}Z"
    # @comment  def line_insert(lines = 1) = "\e[#{lines}L"
    # @comment  def line_delete(lines = 1) = "\e[#{lines}M"
    # @comment  def chars_delete(count = 1) = "\e[#{count}P"
    # @comment  def chars_erase(count = 1) = "\e[#{count}X"

    private

    def _invalid(name)
      raise(
        ArgumentError,
        "unknown ANSI attribute - #{name.inspect}",
        caller(1)
      )
    end

    def _color(str)
      if /\A(?<base>fg|bg|on|ul)?_?#?(?<val>[[:xdigit:]]{1,6})\z/ =~ str
        return(
          case val.size
          when 1, 2
            "#{_color_base(base)};5;#{val.hex}"
          when 3
            "#{_color_base(base)};2;#{(val[0] * 2).hex};#{(val[1] * 2).hex};#{
              (val[2] * 2).hex
            }"
          when 6
            "#{_color_base(base)};2;#{val[0, 2].hex};#{val[2, 2].hex};#{
              val[4, 2].hex
            }"
          end
        )
      end
      if /\A(?<base>fg|bg|on|ul)?_?(?<val>[a-z]{3,}[0-9]{0,3})\z/ =~ str
        val = NAMED_COLORS[val] and return "#{_color_base(base)};#{val}"
      end
    end

    def _color_base(base)
      return '48' if base == 'bg' || base == 'on'
      base == 'ul' ? '58' : '38'
    end

    def _screen_erase(part) = "\e[#{part}J"
    def _line_erase(part) = "\e[#{part}K"
  end

  TEST =
    /\e
      (?:\[[\d;:\?]*[ABCDEFGHJKSTfminsuhl])
      |
      (?:\]\d+(?:;[^;\a\e]+)*(?:\a|\e\\))
    /x

  require_relative 'just-ansi/attributes'
  autoload :NAMED_COLORS, File.join(__dir__, 'just-ansi', 'named_colors')
  private_constant :TEST, :NAMED_COLORS

  # @!visibility private
  RESET = self[:reset].freeze

  # @!visibility private
  CURSOR_HOME = cursor_pos(nil, nil).freeze
  # @!visibility private
  CURSOR_FIRST_ROW = cursor_pos(1).freeze
  # @!visibility private
  CURSOR_FIRST_COLUMN = cursor_column(1).freeze

  # @!visibility private
  CURSOR_SHOW = "\e[?25h"
  # @!visibility private
  CURSOR_HIDE = "\e[?25l"

  # CURSOR_POS_SAFE_SCO = "\e[s"
  # CURSOR_POS_SAFE_DEC = "\e7"
  # @!visibility private
  CURSOR_POS_SAFE = "\e7"

  # CURSOR_POS_RESTORE_SCO = "\e[u"
  # CURSOR_POS_RESTORE_DEC = "\e8"
  # @!visibility private
  CURSOR_POS_RESTORE = "\e8"

  # @!visibility private
  SCREEN_ERASE_BELOW = screen_erase_below.freeze
  # @!visibility private
  SCREEN_ERASE_ABOVE = screen_erase_above.freeze
  # @!visibility private
  SCREEN_ERASE = screen_erase.freeze
  # @!visibility private
  SCREEN_ERASE_SCROLLBACK = screen_erase_scrollback.freeze

  # @!visibility private
  SCREEN_SAVE = "\e[?47h"
  # @!visibility private
  SCREEN_RESTORE = "\e[?47l"

  # @!visibility private
  SCREEN_ALTERNATE = "\e[?1049h"
  # @!visibility private
  SCREEN_ALTERNATE_OFF = "\e[?1049l"

  # @!visibility private
  LINE_ERASE_TO_END = line_erase_to_end.freeze
  # @!visibility private
  LINE_ERASE_TO_START = line_erase_to_start.freeze
  # @!visibility private
  LINE_ERASE = line_erase.freeze
  # @!visibility private
  LINE_PREVIOUS = cursor_previous_line(1).freeze
  # @!visibility private
  LINE_NEXT = cursor_next_line(1).freeze
end
