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
      sample = 'test'
      expect(JustAnsi.decorate(sample).__id__).not_to be sample.__id__
    end
  end

  context '.undecorate' do
    it 'removes CSI control codes' do
      expect(JustAnsi.undecorate("Hello\e[mWorld!")).to eq 'HelloWorld!'
    end

    it 'removes OSC control codes' do
      expect(JustAnsi.undecorate("Hello\e[?25hWorld!")).to eq 'HelloWorld!'
    end

    it 'removes all supported attributes and colors' do
      all = JustAnsi.attributes + JustAnsi.colors + JustAnsi.named_colors
      sample = "#{JustAnsi.decorate('', *all)}#{all.map { JustAnsi[_1] }.join}"
      expect(JustAnsi.undecorate(sample)).to be_empty
    end
  end
end
