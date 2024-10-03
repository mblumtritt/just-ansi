# frozen_string_literal: true

RSpec.describe NoAnsi do
  context '.attributes' do
    it 'returns JustAnsi attributes' do
      expect(NoAnsi.attributes).to eq JustAnsi.attributes
    end
  end

  context '.colors' do
    it 'returns JustAnsi colors' do
      expect(NoAnsi.colors).to eq JustAnsi.colors
    end
  end

  context '.named_colors' do
    it 'returns JustAnsi named colors' do
      expect(NoAnsi.named_colors).to eq JustAnsi.named_colors
    end
  end

  context '.[]' do
    it 'supports argument Strings' do
      expect(NoAnsi['bold', 'red']).to be_empty
    end

    it 'supports argument Symbols' do
      expect(NoAnsi[:bold, :red]).to be_empty
    end

    it 'supports 3-/4-bit colors' do
      expect(NoAnsi['red', 'bg_bright_yellow']).to be_empty
    end

    it 'supports 8-bit colors' do
      expect(NoAnsi[0xfa, 'on_ff', 'ul#64']).to be_empty

      expect(NoAnsi[0xfa]).to eq NoAnsi[:fa]
    end

    it 'supports 24-bit colors' do
      expect(NoAnsi['aaa', 'on_aaffee', 'ul#bad']).to be_empty

      expect(NoAnsi[:abc]).to eq NoAnsi[:aabbcc]
    end

    it 'supports 24-bit named colors' do
      expect(NoAnsi[:aquamarine, 'on_beige', 'ul_burlywood']).to be_empty
    end

    it 'handles empty argument list' do
      expect(NoAnsi[]).to be_empty
    end

    it 'raises no error for unsupported arguments' do
      expect { NoAnsi[:red, :foo] }.not_to raise_error
    end
  end

  context '.valid?' do
    it 'supports argument Strings' do
      expect(NoAnsi.valid?('bold', 'red')).to be true
      expect(NoAnsi.valid?('bold', 'no_red')).to be false
    end

    it 'supports argument Symbols' do
      expect(NoAnsi.valid?(:bold, :red)).to be true
      expect(NoAnsi.valid?(:bold, :no_red)).to be false
    end

    it 'handles empty argument list' do
      expect(NoAnsi.valid?()).to be true
    end

    it 'returns false for for unsupported arguments' do
      expect(NoAnsi.valid?(:red, :foo)).to be false
      expect(NoAnsi.valid?(:red, 'foo')).to be false
      expect(NoAnsi.valid?(:red, '')).to be false
      expect(NoAnsi.valid?(:red, nil)).to be false
    end
  end

  context '.ansi?' do
    it 'returns true when given String contains ANSI control codes' do
      expect(NoAnsi.ansi?("\e[1;31mTest")).to be true
      expect(NoAnsi.ansi?("Test\e[1;31m")).to be true
      expect(NoAnsi.ansi?(JustAnsi.decorate('foo', :azure))).to be true
    end

    it 'returns false when given String does not contain ANSI control codes' do
      expect(NoAnsi.ansi?('NoAnsi')).to be false
      expect(NoAnsi.ansi?('')).to be false
      expect(NoAnsi.ansi?(true)).to be false
      expect(NoAnsi.ansi?(42)).to be false
    end
  end

  context '.decorate' do
    it 'does not decorate a given String' do
      expect(NoAnsi.decorate('some', :black)).to eq 'some'
    end

    it 'returns always a new string' do
      sample = 'some'
      expect(NoAnsi.decorate(sample).__id__).not_to be sample.__id__

      sample = ''
      expect(NoAnsi.decorate(sample).__id__).not_to be sample.__id__
    end
  end

  context '.undecorate' do
    it 'removes CSI control codes' do
      expect(NoAnsi.undecorate("Hello\e[1mWorld!")).to eq 'HelloWorld!'
    end

    it 'removes OSC control codes' do
      sample = JustAnsi.window_title('Hello Ruby')
      expect(NoAnsi.undecorate(sample)).to be_empty

      sample = JustAnsi.link('http://sample.test', 'Hello World!')
      expect(NoAnsi.undecorate(sample)).to eq 'Hello World!'
    end

    it 'removes all supported attributes and colors' do
      all = JustAnsi.attributes + JustAnsi.colors + JustAnsi.named_colors
      sample = "#{JustAnsi.decorate('', *all)}#{all.map { JustAnsi[_1] }.join}"
      expect(NoAnsi.undecorate(sample)).to be_empty
    end

    it 'returns always a new string' do
      sample = 'some'
      expect(NoAnsi.undecorate(sample).__id__).not_to be sample.__id__

      sample = ''
      expect(NoAnsi.undecorate(sample).__id__).not_to be sample.__id__
    end
  end

  context '.bbcode' do
    it 'removes valid embedded BBCode' do
      expect(
        NoAnsi.bbcode('Hello [b]Ruby[/b] [red]World[/fg]!')
      ).to eq 'Hello Ruby World!'
    end

    it 'does not remove invalid embedded BBCode' do
      sample = 'Hello [foo]Ruby[/bar]!'
      expect(NoAnsi.bbcode(sample)).to eq sample
    end

    it 'respects escaped BBCode' do
      expect(
        NoAnsi.bbcode('Hello [\\b]Ruby[\\/b] [\\red]World[\\/]!')
      ).to eq 'Hello [b]Ruby[/b] [red]World[/]!'
    end
  end

  context '.unbbcode' do
    it 'removes valid embedded BBCode' do
      expect(
        NoAnsi.unbbcode('Hello [b]Ruby[/b] [red]World[/fg]!')
      ).to eq 'Hello Ruby World!'
    end

    it 'does not remove invalid embedded BBCode' do
      sample = 'Hello [foo]Ruby[/bar]!'
      expect(NoAnsi.unbbcode(sample)).to eq sample
    end

    it 'respects escaped BBCode' do
      expect(
        NoAnsi.unbbcode('Hello [\\b]Ruby[\\/b] [\\red]World[\\/]!')
      ).to eq 'Hello [b]Ruby[/b] [red]World[/]!'
    end
  end

  context '.plain' do
    it 'removes ANSI control codes and supported BBCodes' do
      expect(
        NoAnsi.plain("[b burlywood]Hello[/b]\e[1mWorld!")
      ).to eq 'HelloWorld!'
    end
  end

  context '.try_convert' do
    it 'returns empty string for valid attributes' do
      expect(NoAnsi.try_convert('bold italic blink red on#0f0')).to be_empty
    end

    it 'returns nil for invalid attributes' do
      expect(NoAnsi.try_convert('bold italic blink red on#0f0a')).to be_nil
    end

    it 'allows to use a different seperator' do
      expect(
        NoAnsi.try_convert('bold, italic, blink, red, on#0f0', seperator: ', ')
      ).to be_empty
    end
  end

  context '.rainbow' do
    let(:sample) { 'Hello World!' }

    it 'return copy of given string' do
      expect(NoAnsi.rainbow(sample)).to eq sample
      expect(NoAnsi.rainbow(sample).__id__).not_to eq sample.__id__
    end

    it 'accepts kwargs' do
      expect(
        NoAnsi.rainbow(
          'Hello World!',
          frequence: 1.2,
          spread: 1,
          seed: Math::PI
        )
      ).to eq sample
    end
  end

  context '.cursor_pos' do
    it 'returns empty string' do
      expect(NoAnsi.cursor_pos(42, 21)).to be_empty
      expect(NoAnsi.cursor_pos(42)).to be_empty
      expect(NoAnsi.cursor_pos(nil, 42)).to be_empty
    end
  end

  context '.link' do
    it 'returns only title of a link' do
      expect(
        NoAnsi.link('https://some.test?param=%20', 'the text')
      ).to eq 'the text'
    end
  end

  context '.window_title' do
    let(:sample) { 'Hello World!' }

    it 'return copy of given string' do
      expect(NoAnsi.window_title(sample)).to eq sample
      expect(NoAnsi.window_title(sample).__id__).not_to eq sample.__id__
    end
  end

  context '.tab_title' do
    let(:sample) { 'Hello World!' }

    it 'return copy of given string' do
      expect(NoAnsi.tab_title(sample)).to eq sample
      expect(NoAnsi.tab_title(sample).__id__).not_to eq sample.__id__
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
