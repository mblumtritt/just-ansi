# frozen_string_literal: true

RSpec.describe JustAnsi do
  context '.attributes' do
    subject(:attributes) { JustAnsi.attributes }

    it 'returns supported attributes as symbols' do
      expect(attributes).not_to be_empty
      expect(attributes).to all be_an Symbol
    end
  end

  context '.colors' do
    subject(:colors) { JustAnsi.colors }

    it 'returns supported 8-bit-colors as symbols' do
      expect(colors).not_to be_empty
      expect(colors).to all be_an Symbol
    end
  end

  context '.named_colors' do
    subject(:named_colors) { JustAnsi.named_colors }

    it 'returns supported named colors as symbols' do
      expect(named_colors).not_to be_empty
      expect(named_colors).to all be_an Symbol
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
      expect(JustAnsi['red', 'bg_bright_yellow']).to eq "\e[31;103m"
    end

    it 'supports 8-bit colors' do
      expect(
        JustAnsi[0xfa, 'on_ff', 'ul#64']
      ).to eq "\e[38;5;250;48;5;255;58;5;100m"

      expect(JustAnsi[0xfa]).to eq JustAnsi[:fa]
    end

    it 'supports 24-bit colors' do
      expect(
        JustAnsi['aaa', 'on_aaffee', 'ul#bad']
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
      expect(JustAnsi.valid?()).to be true
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

    it 'respects escabed BBCode' do
      expect(
        JustAnsi.bbcode('Hello [\\b]Ruby[\\/b] [\\red]World[\\/]!')
      ).to eq 'Hello [b]Ruby[/b] [red]World[/]!'
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

    it 'respects escabed BBCode' do
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
end
