# frozen_string_literal: true

module JustAnsi
  ATTRIBUTES = {
    '/' => '',
    '/b' => '22',
    '/blink' => '25',
    '/bold' => '22',
    '/conceal' => '28',
    '/cu' => '4:0',
    '/curly_underline' => '4:0',
    '/dashed_underline' => '4:0',
    '/dau' => '4:0',
    '/dim' => '22',
    '/dotted_underline' => '4:0',
    '/dou' => '4:0',
    '/double_underline' => '24',
    '/encircled' => '54',
    '/faint' => '22',
    '/fraktur' => '23',
    '/framed' => '54',
    '/h' => '28',
    '/hide' => '28',
    '/i' => '23',
    '/inv' => '27',
    '/invert' => '27',
    '/italic' => '23',
    '/overlined' => '55',
    '/ovr' => '55',
    '/proportional' => '50',
    '/slow_blink' => '25',
    '/spacing' => '50',
    '/strike' => '29',
    '/sub' => '75',
    '/subscript' => '75',
    '/sup' => '75',
    '/superscript' => '75',
    '/u' => '24',
    '/underline' => '24',
    '/uu' => '24',
    'b' => '1',
    'blink' => '5',
    'blink_off' => '25',
    'bold' => '1',
    'bold_off' => '22',
    'conceal' => '8',
    'cu' => '4:3',
    'curly_underline' => '4:3',
    'curly_underline_off' => '4:0',
    'dashed_underline' => '4:5',
    'dashed_underline_off' => '4:0',
    'dau' => '4:5',
    'default_font' => '10',
    'dim' => '2',
    'dotted_underline' => '4:4',
    'dotted_underline_off' => '4:0',
    'dou' => '4:4',
    'double_underline' => '21',
    'double_underline_off' => '24',
    'encircled' => '52',
    'encircled_off' => '54',
    'faint' => '2',
    'faint_off' => '22',
    'font1' => '11',
    'font2' => '12',
    'font3' => '13',
    'font4' => '14',
    'font5' => '15',
    'font6' => '16',
    'font7' => '17',
    'font8' => '18',
    'font9' => '19',
    'fraktur' => '20',
    'fraktur_off' => '23',
    'framed' => '51',
    'framed_off' => '54',
    'h' => '8',
    'hide' => '8',
    'hide_off' => '28',
    'i' => '3',
    'inv' => '7',
    'invert' => '7',
    'invert_off' => '27',
    'italic' => '3',
    'italic_off' => '23',
    'overlined' => '53',
    'overlined_off' => '55',
    'ovr' => '53',
    'primary_font' => '10',
    'proportional' => '26',
    'proportional_off' => '50',
    'rapid_blink' => '6',
    'reset' => '',
    'reveal' => '28',
    'slow_blink' => '5',
    'spacing' => '26',
    'strike' => '9',
    'strike_off' => '29',
    'sub' => '74',
    'subscript' => '74',
    'subscript_off' => '75',
    'sup' => '73',
    'superscript' => '73',
    'superscript_off' => '75',
    'u' => '4',
    'underline' => '4',
    'underline_off' => '24',
    'uu' => '21'
  }.freeze

  COLORS = {
    '/bg' => '49',
    '/fg' => '39',
    '/ul' => '59',
    'bg_black' => '40',
    'bg_blue' => '44',
    'bg_bright_black' => '100',
    'bg_bright_blue' => '104',
    'bg_bright_cyan' => '106',
    'bg_bright_green' => '102',
    'bg_bright_magenta' => '105',
    'bg_bright_red' => '101',
    'bg_bright_white' => '107',
    'bg_bright_yellow' => '103',
    'bg_cyan' => '46',
    'bg_default' => '49',
    'bg_green' => '42',
    'bg_magenta' => '45',
    'bg_red' => '41',
    'bg_white' => '47',
    'bg_yellow' => '43',
    'black' => '30',
    'blue' => '34',
    'bright_black' => '90',
    'bright_blue' => '94',
    'bright_cyan' => '96',
    'bright_green' => '92',
    'bright_magenta' => '95',
    'bright_red' => '91',
    'bright_white' => '97',
    'bright_yellow' => '93',
    'cyan' => '36',
    'default' => '39',
    'fg_black' => '30',
    'fg_blue' => '34',
    'fg_bright_black' => '90',
    'fg_bright_blue' => '94',
    'fg_bright_cyan' => '96',
    'fg_bright_green' => '92',
    'fg_bright_magenta' => '95',
    'fg_bright_red' => '91',
    'fg_bright_white' => '97',
    'fg_bright_yellow' => '93',
    'fg_cyan' => '36',
    'fg_default' => '39',
    'fg_green' => '32',
    'fg_magenta' => '35',
    'fg_red' => '31',
    'fg_white' => '37',
    'fg_yellow' => '33',
    'green' => '32',
    'magenta' => '35',
    'on_black' => '40',
    'on_blue' => '44',
    'on_bright_black' => '100',
    'on_bright_blue' => '104',
    'on_bright_cyan' => '106',
    'on_bright_green' => '102',
    'on_bright_magenta' => '105',
    'on_bright_red' => '101',
    'on_bright_white' => '107',
    'on_bright_yellow' => '103',
    'on_cyan' => '46',
    'on_default' => '49',
    'on_green' => '42',
    'on_magenta' => '45',
    'on_red' => '41',
    'on_white' => '47',
    'on_yellow' => '43',
    'red' => '31',
    'ul_black' => '58;2;0;0;0',
    'ul_blue' => '58;2;0;0;128',
    'ul_bright_black' => '58;2;64;64;64',
    'ul_bright_blue' => '58;2;0;0;255',
    'ul_bright_cyan' => '58;2;0;255;255',
    'ul_bright_green' => '58;2;0;255;0',
    'ul_bright_magenta' => '58;2;255;0;255',
    'ul_bright_red' => '58;2;255;0;0',
    'ul_bright_white' => '58;2;255;255;255',
    'ul_bright_yellow' => '58;2;255;255;0',
    'ul_cyan' => '58;2;0;128;128',
    'ul_default' => '59',
    'ul_green' => '58;2;0;128;0',
    'ul_magenta' => '58;2;128;0;128',
    'ul_red' => '58;2;128;0;0',
    'ul_white' => '58;2;128;128;128',
    'ul_yellow' => '58;2;128;128;0',
    'white' => '37',
    'yellow' => '33'
  }.freeze

  ATTRIBUTES_S = ATTRIBUTES.transform_keys(&:to_sym).compare_by_identity.freeze
  COLORS_S = COLORS.transform_keys(&:to_sym).compare_by_identity.freeze

  private_constant :ATTRIBUTES, :COLORS, :ATTRIBUTES_S, :COLORS_S
end
