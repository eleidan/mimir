require 'aruba/api'

Then(/^the output `([^`]*)` should give the current application version$/) do |cmd|
  expect(output_from(cmd).strip).to eq(Mimir::VERSION)
end
