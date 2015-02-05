require 'aruba/api'

Then(/^the output should be the current application version$/) do
  expect(output_from('mimir --version').strip).to eq(Mimir::VERSION)
end
