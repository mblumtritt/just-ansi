# frozen_string_literal: true

require_relative '../just-ansi'

# Ruby String class ANSI extension.
class String
  # Test if String contains ANSI codes.
  #
  # @see JustAnsi.ansi?
  #
  # @return [true, false] whether if attributes are found
  def ansi? = JustAnsi.ansi?(self)

  # Decorate self with ANSI attributes and colors.
  #
  # @see JustAnsi.decorate
  #
  # @param attributes [Array<Symbol, String>] attribute names to be used
  # @param reset [true, false] whether to include reset code for ANSI attributes
  # @return [String] `str` converted and decorated with the ANSI `attributes`
  def ansi(*attributes, reset: true)
    JustAnsi.decorate(self, *attributes, reset: reset)
  end

  # Remove ANSI functions, attributes and colors from self.
  #
  # @see JustAnsi.undecorate
  #
  # @return [String] string without ANSI attributes
  def unansi = JustAnsi.undecorate(self)
end
