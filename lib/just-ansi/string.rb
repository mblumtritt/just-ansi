# frozen_string_literal: true

require_relative '../just-ansi'

#
# Ruby String class ANSI extension.
#
# This extension is not load by default but you need to require it.
#
# @example
#   require 'just-ansi/string'
#
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

  if defined?(:bbcode)
    def bbcode = JustAnsi.bbcode(super)
  else
    # Replace embedded BBCode-like attributes with ANSI codes.
    #
    # @see JustAnsi.bbcode
    #
    # @return [String] string with ANSI attributes
    def bbcode = JustAnsi.bbcode(self)
  end

  if defined?(:unbbcode)
    def unbbcode = JustAnsi.unbbcode(super)
  else
    # Remove embedded BBCode-like attributes.
    #
    # @see JustAnsi.unbbcode
    #
    # @return [String] string without BBCode
    def unbbcode = JustAnsi.unbbcode(self)
  end

  if defined?(:plain)
    def plain = JustAnsi.plain(super)
  else
    # Remove any BBCode-like and/or ANSI attributes.
    #
    # @see JustAnsi.plain
    #
    # @return [String] string without BBCode and ANSI control codes.
    def plain = JustAnsi.plain(self)
  end
end
