Given /^the following todos:$/ do |todos|
  Todo.create!(todos.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) todo$/ do |pos|
  visit todos_url
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following todos:$/ do |expected_todos_table|
  expected_todos_table.diff!(tableish('table tr', 'td,th'))
end
