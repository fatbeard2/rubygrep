RSpec.describe Rubygrep::Outputter do

  let (:line_data) {{str: 'test', str_num: 5} }

  it 'should output string data' do
    outputter = Rubygrep::Outputter.new
    expect { outputter.out(nil, line_data) }.to output('test').to_stdout
  end

  it 'should output string data with string number' do
    outputter = Rubygrep::Outputter.new({line_number: true})
    expect { outputter.out(nil, line_data) }.to output('5: test').to_stdout
  end

end