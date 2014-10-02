RSpec.describe Rubygrep::FileReader do

  let (:one_file) { 'text1.txt' }
  let (:several_files) {%w(text1.txt ./text2.txt ../text3.txt ../folder/text4.txt /root/woop/foo/bar/text5.txt)}

  it 'lookup for one file' do
    allow(File).to receive(:file?).with(one_file).and_return(true)
    reader = Rubygrep::FileReader.new([one_file])
    expect(reader.file_names).to eq(%w(text1.txt))
  end

  context 'with several files' do
    let (:reader) {Rubygrep::FileReader.new(several_files)}
    before do
      allow(File).to receive(:file?) { |file_name| several_files.include?(file_name) }
      allow(File).to receive(:open) { StringIO.new("YHOO,141414") }
    end

    it 'should lookup for several files' do
      expect(reader.file_names).to eq(several_files)
    end

    it 'should lookup for several files' do
      expect(reader.each_line).to yield_with_args(several_files)
    end

  end



end