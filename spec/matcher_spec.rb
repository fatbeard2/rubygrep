RSpec.describe Rubygrep::Matcher do

  def string_data(str)
    {str: str}
  end

  context 'with -i option on' do
    let(:i_matcher) { Rubygrep::Matcher.new('test', {ignore_case: true}) }

    it 'should match string' do
      expect(i_matcher.matches?(string_data('aAzDfTeStS'))).to be_instance_of(MatchData)
      expect(i_matcher.matches?(string_data('aAzDfTeStS')).to_s).to eq('TeSt')
    end

  end

  context 'with -v option on' do
    let(:v_matcher) { Rubygrep::Matcher.new('test', {invert_selection: true}) }

    it 'should match string' do
      expect(v_matcher.matches?(string_data('aAzDfTeSS'))).to be_instance_of(MatchData)
      expect(v_matcher.matches?(string_data('aAzDfTeSS')).to_s).to eq('aAzDfTeSS')
    end

    it 'should not match string' do
      expect(v_matcher.matches?(string_data('testaAzDfS'))).to eq(nil)
    end

  end

end