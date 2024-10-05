# frozen_string_literal: true

RSpec.describe JustAnsi do
  context '.attributes' do
    it 'returns supported attributes as symbols' do
      expect(JustAnsi.attributes).not_to be_empty
      expect(JustAnsi.attributes).to all be_an Symbol
    end
  end

  context '.colors' do
    it 'returns supported 8-bit-colors as symbols' do
      expect(JustAnsi.colors).not_to be_empty
      expect(JustAnsi.colors).to all be_an Symbol
    end
  end

  context '.named_colors' do
    it 'returns supported named colors as symbols' do
      expect(JustAnsi.named_colors).not_to be_empty
      expect(JustAnsi.named_colors).to all be_an Symbol
    end
  end

  context '.[]' do
    it 'supports argument Strings' do
      expect(JustAnsi['bold', 'red']).to eq "\e[1;31m"
    end

    it 'supports argument Symbols' do
      expect(JustAnsi[:bold, :red]).to eq "\e[1;31m"
    end

    it 'supports 3-/4-bit colors' do
      expect(JustAnsi['red', :bg_bright_yellow]).to eq "\e[31;103m"
    end

    it 'supports 8-bit colors' do
      expect(
        JustAnsi[0xfa, :on_ff, 'ul#64']
      ).to eq "\e[38;5;250;48;5;255;58;5;100m"

      expect(JustAnsi[0xfa]).to eq JustAnsi[:fa]
    end

    it 'supports 24-bit colors' do
      expect(
        JustAnsi[:aaa, 'on_aaffee', 'ul#bad']
      ).to eq "\e[38;2;170;170;170;48;2;170;255;238;58;2;187;170;221m"

      expect(JustAnsi[:abc]).to eq JustAnsi[:aabbcc]
    end

    it 'supports 24-bit named colors' do
      expect(
        JustAnsi[:aquamarine, 'on_beige', 'ul_burlywood']
      ).to eq "\e[38;2;127;255;212;48;2;245;245;220;58;2;222;184;135m"
    end

    it 'handles empty argument list' do
      expect(JustAnsi[]).to be_empty
    end

    it 'raises an ArgumentError for unsupported arguments' do
      expect { JustAnsi[:red, :foo] }.to raise_error(ArgumentError, /:foo/)
      expect { JustAnsi[:red, 'foo'] }.to raise_error(ArgumentError, /"foo"/)
      expect { JustAnsi[:red, ''] }.to raise_error(ArgumentError, /""/)
      expect { JustAnsi[:red, 'abcd'] }.to raise_error(ArgumentError, /"abcd"/)
      expect { JustAnsi[:red, nil] }.to raise_error(ArgumentError, /nil/)
    end
  end

  context '.valid?' do
    it 'supports argument Strings' do
      expect(JustAnsi.valid?('bold', 'red')).to be true
      expect(JustAnsi.valid?('bold', 'no_red')).to be false
    end

    it 'supports argument Symbols' do
      expect(JustAnsi.valid?(:bold, :red)).to be true
      expect(JustAnsi.valid?(:bold, :no_red)).to be false
    end

    it 'handles empty argument list' do
      expect(JustAnsi.valid?).to be true
    end

    it 'returns false for for unsupported arguments' do
      expect(JustAnsi.valid?(:red, :foo)).to be false
      expect(JustAnsi.valid?(:red, 'foo')).to be false
      expect(JustAnsi.valid?(:red, '')).to be false
      expect(JustAnsi.valid?(:red, nil)).to be false
    end
  end

  context '.ansi?' do
    it 'returns true when given String contains ANSI control codes' do
      expect(JustAnsi.ansi?("\e[1;31mTest")).to be true
      expect(JustAnsi.ansi?("Test\e[1;31m")).to be true
      expect(JustAnsi.ansi?(JustAnsi.decorate('foo', :azure))).to be true
    end

    it 'returns false when given String does not contain ANSI control codes' do
      expect(JustAnsi.ansi?('JustAnsi')).to be false
      expect(JustAnsi.ansi?('')).to be false
      expect(JustAnsi.ansi?(true)).to be false
      expect(JustAnsi.ansi?(42)).to be false
    end
  end

  context '.decorate' do
    it 'decorates a given String' do
      sample = JustAnsi.decorate('some', :black)
      expect(sample).to start_with "\e["
      expect(sample).to end_with JustAnsi::RESET
    end

    it 'can omit the reset sequence' do
      sample = JustAnsi.decorate('some', :black, reset: false)
      expect(sample).not_to include JustAnsi::RESET
    end

    it 'returns always a new string' do
      sample = 'some'
      expect(JustAnsi.decorate(sample).__id__).not_to be sample.__id__

      sample = ''
      expect(JustAnsi.decorate(sample).__id__).not_to be sample.__id__
    end
  end

  context '.undecorate' do
    it 'removes CSI control codes' do
      expect(JustAnsi.undecorate("Hello\e[1mWorld!")).to eq 'HelloWorld!'
    end

    it 'removes OSC control codes' do
      sample = JustAnsi.window_title('Hello Ruby')
      expect(JustAnsi.undecorate(sample)).to be_empty

      sample = JustAnsi.link('http://sample.test', 'Hello World!')
      expect(JustAnsi.undecorate(sample)).to eq 'Hello World!'
    end

    it 'removes all supported attributes and colors' do
      all = JustAnsi.attributes + JustAnsi.colors + JustAnsi.named_colors
      sample = "#{JustAnsi.decorate('', *all)}#{all.map { JustAnsi[_1] }.join}"
      expect(JustAnsi.undecorate(sample)).to be_empty
    end

    it 'returns always a new string' do
      sample = 'some'
      expect(JustAnsi.undecorate(sample).__id__).not_to be sample.__id__

      sample = ''
      expect(JustAnsi.undecorate(sample).__id__).not_to be sample.__id__
    end
  end

  context '.bbcode' do
    it 'converts valid embedded BBCode' do
      expect(
        JustAnsi.bbcode('Hello [b]Ruby[/b] [red]World[/fg]!')
      ).to eq "Hello \e[1mRuby\e[22m \e[31mWorld\e[39m!"
    end

    it 'does not convert invalid embedded BBCode' do
      sample = 'Hello [foo]Ruby[/bar]!'
      expect(JustAnsi.bbcode(sample)).to eq sample
    end

    it 'respects escaped BBCode' do
      expect(
        JustAnsi.bbcode('Hello [\\b]Ruby[\\/b] [\\red]World[\\/]!')
      ).to eq 'Hello [b]Ruby[/b] [red]World[/]!'
    end

    it 'supports all defined attributes and names' do
      all = JustAnsi.attributes + JustAnsi.colors + JustAnsi.named_colors
      text =
        all
          .filter_map do |name|
            next if name[0] == '/'
            rev = "/#{name}"
            "#{name}: [#{name}]#{name}[#{all.include?(rev) ? rev : '/'}]"
          end
          .join("\n")
      expect(JustAnsi.bbcode(text)).to eq fixture('bbcodes.ans')
    end
  end

  context '.unbbcode' do
    it 'removes valid embedded BBCode' do
      expect(
        JustAnsi.unbbcode('Hello [b]Ruby[/b] [red]World[/fg]!')
      ).to eq 'Hello Ruby World!'
    end

    it 'does not remove invalid embedded BBCode' do
      sample = 'Hello [foo]Ruby[/bar]!'
      expect(JustAnsi.unbbcode(sample)).to eq sample
    end

    it 'respects escaped BBCode' do
      expect(
        JustAnsi.unbbcode('Hello [\\b]Ruby[\\/b] [\\red]World[\\/]!')
      ).to eq 'Hello [b]Ruby[/b] [red]World[/]!'
    end
  end

  context '.plain' do
    it 'removes ANSI control codes and supported BBCodes' do
      expect(
        JustAnsi.plain("[b burlywood]Hello[/b]\e[1mWorld!")
      ).to eq 'HelloWorld!'
    end
  end

  context '.try_convert' do
    it 'returns String with ANSI control codes for valid attributes' do
      expect(
        JustAnsi.try_convert('bold italic blink red on#0f0')
      ).to eq "\e[1;3;5;31;48;2;0;255;0m"
    end

    it 'returns nil for invalid attributes' do
      expect(JustAnsi.try_convert('bold italic blink red on#0f0a')).to be_nil
    end

    it 'allows to use a different seperator' do
      expect(
        JustAnsi.try_convert(
          'bold, italic, blink, red, on#0f0',
          seperator: ', '
        )
      ).to eq "\e[1;3;5;31;48;2;0;255;0m"
    end
  end

  context '.rainbow' do
    it 'colorizes a given string' do
      expect(JustAnsi.rainbow('Hello World!')).to eq fixture('rainbow1.ans')
    end

    it 'allows to specify a frequence' do
      expect(JustAnsi.rainbow('Hello World!', frequence: 1.2)).to eq(
        fixture('rainbow2.ans')
      )
    end

    it 'allows to specify the spread' do
      expect(JustAnsi.rainbow('Hello World!', spread: 1)).to eq(
        fixture('rainbow3.ans')
      )
    end

    it 'allows to specify a seed' do
      expect(JustAnsi.rainbow('Hello World!', seed: Math::PI)).to eq(
        fixture('rainbow4.ans')
      )
    end
  end

  context '.cursor_pos' do
    it 'returns the code to move the cursor' do
      expect(JustAnsi.cursor_pos(42, 21)).to eq "\e[42;21H"
    end

    it 'can just change the row' do
      expect(JustAnsi.cursor_pos(42)).to eq "\e[42H"
    end

    it 'can just change the column' do
      expect(JustAnsi.cursor_pos(nil, 42)).to eq "\e[;42H"
    end
  end

  context '.link' do
    it 'returns the code for a link' do
      expect(
        JustAnsi.link('https://some.test?param=%20', 'the text')
      ).to eq "\e]8;;https://some.test?param=%20\athe text\e]8;;\a"
    end
  end

  context '.window_title' do
    it 'returns the code to specify the window title' do
      expect(
        JustAnsi.window_title('my cool window')
      ).to eq "\e]2;my cool window\a"
    end
  end

  context '.tab_title' do
    it 'returns the code to specify the tab title' do
      expect(JustAnsi.tab_title('my cool tab')).to eq "\e]0;my cool tab\a"
    end
  end

  context '.cursor_up'
  context '.cursor_down'
  context '.cursor_forward'
  context '.cursor_back'
  context '.cursor_next_line'
  context '.cursor_previous_line'
  context '.cursor_prev_line'
  context '.cursor_column'
  context '.cursor_show'
  context '.cursor_hide'
  context '.cursor_pos_safe'
  context '.cursor_pos_restore'
  context '.screen_erase_below'
  context '.screen_erase_above'
  context '.screen_erase'
  context '.screen_erase_scrollback'
  context '.screen_save'
  context '.screen_restore'
  context '.screen_alternate'
  context '.screen_alternate_off'
  context '.line_erase_to_end'
  context '.line_erase_to_start'
  context '.line_erase'
  context '.line_insert'
  context '.line_delete'
  context '.scroll_up'
  context '.scroll_down'
end
