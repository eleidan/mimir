require 'aruba/api'
require 'aruba/reporting'

Then(/^the output should be the current application version$/) do
  expect(output_from('mimir --version').strip).to eq(Mimir::VERSION)
end

When(/^I run ([^`]*)$/) do |cmd|
  run_simple(unescape(cmd), false)
end

Then(/^I get particular first line of the result ([^']*)$/) do |expected|
  assert_matching_output(expected, all_output)
  # expect(output_from(command).strip).to eq(Mimir::VERSION)
  true
end
