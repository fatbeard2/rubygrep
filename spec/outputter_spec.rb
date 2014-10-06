require 'ostruct'

RSpec.describe Rubygrep::Outputter do

  let (:line_data) {{str: 'test', str_num: 5} }
  let (:match_data) { OpenStruct.new({regexp: /test/})}

  it 'should output string data' do
    outputter = Rubygrep::Outputter.new
    expect { outputter.out(match_data, line_data) }.to output("\033[31mtest\033[0m\n").to_stdout
  end

  it 'should output string data with string number' do
    outputter = Rubygrep::Outputter.new({line_number: true})
    expect { outputter.out(match_data, line_data) }.to output("\033[35m5\033[0m: \033[31mtest\033[0m\n").to_stdout
  end

end