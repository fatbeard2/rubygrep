RSpec.describe Rubygrep::RubyGrepOptions do

  def create_options(args)
    Rubygrep::RubyGrepOptions.new args
  end

  context 'with missing params' do
    it 'output throw error without expression' do
      expect {create_options([])}.to raise_error(RuntimeError, 'Expression is required')
    end

    it 'output throw error without files' do
      expect {create_options(['test'])}.to raise_error(RuntimeError, 'At least one file in required')
    end
  end

  context 'with no additional options' do
    subject(:options_object) {create_options(%w(exp text text1 text2))}

    it 'should parse expression' do
      expect(options_object.expression).to eq('exp')
    end

    it 'should parse file_names' do
      expect(options_object.file_names).to eq(%w(text text1 text2))
    end

    it 'should have blank options' do
      expect(options_object.file_reader_options).to eq({})
      expect(options_object.matcher_options).to eq({})
      expect(options_object.outputter_options).to eq({})
    end

    it 'should set with_filename option to true' do
      options_object.set_multi_file_mode
      expect(options_object.outputter_options).to eq({:with_filename => true})
    end
  end

  context 'with all additional options' do
    subject(:options_object) {create_options(%w(-r -i -v -n exp text2))}
    it 'should have parsed options' do
      expect(options_object.file_reader_options).to eq({recursive: true})
      expect(options_object.matcher_options).to eq({ignore_case: true, invert_selection: true})
      expect(options_object.outputter_options).to eq({line_number: true})
    end
  end

end