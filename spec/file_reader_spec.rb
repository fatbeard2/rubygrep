RSpec.describe Rubygrep::FileReader do

  let (:several_files) {%w(text1.txt ./text2.txt ../text3.txt ../folder/text4.txt /etc/woop/text5.txt)}
  let (:no_access_files) {%w(/root/smth)}

  before :each do
    allow(File).to receive(:open) do |file_name|
      if several_files.include?(file_name)
        StringIO.new("#{file_name}\n#{file_name}\n#{file_name}\n")
      elsif  no_access_files.include?(file_name)
        raise Errno::EACCES
      else
        raise Errno::ENOENT
      end
    end

    allow(File).to receive(:file?) do |file_name|
      several_files.include?(file_name) ||
      no_access_files.include?(file_name)
    end
  end

  it 'should read files line by line' do
    reader = Rubygrep::FileReader.new(several_files)
    reader.each_line do |line_data|
      expect(line_data[:str]).to eq(line_data[:path]+"\n")
      expect(line_data[:str_num]).to be_between(1,3)
    end
  end

  it 'should read all lines' do
    reader = Rubygrep::FileReader.new(several_files)
    expect { |b| reader.each_line(&b) }.to yield_control.exactly(15).times
  end

  it 'should skip files' do
    reader = Rubygrep::FileReader.new(several_files)
    reader.each_line do |line_data|
      reader.next_file!
      expect(line_data[:str_num]).to eq(1)
    end
  end

end