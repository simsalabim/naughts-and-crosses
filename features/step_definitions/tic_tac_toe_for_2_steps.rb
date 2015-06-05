When(/^I am on the homepage$/) do
  visit root_path
end

Then(/^I should see game creation form$/) do
  expect(page).to have_css('.form-horizontal')
end

When(/^I start new game with defaults$/) do
  find('.btn.btn-primary').click
end

Then(/^I should see a blank game board$/) do
  wait_for_requirejs
  expect(page).to have_css('.board')
  blank_count = page.evaluate_script("jQuery('.cell').filter(function(){ return !jQuery(this).data('token'); }).length")
  expect(blank_count).to eq 9
end

Then(/^I should see a cat's game board$/) do
  wait_for_ajax
  expect(page).to have_css('.board')
  blank_count = page.evaluate_script("jQuery('.cell').filter(function(){ return !jQuery(this).data('token'); }).length")
  expect(blank_count).to eq 0
end

When(/^(?:|first |second )?human makes move to \((\d+), (\d+)\)$/) do |row, column|
  wait_for_ajax
  make_move(row, column)
end

Then(/^I should see board with winner$/) do
  wait_for_ajax
  expect(page).to have_css('.board.with-winner')
end

Then(/^winning streak is (\d+) cells$/) do |count|
  expect(page).to have_css('.cell.winner', count: 3)
end

When(/^I click to rematch the game$/) do
  find('.action-rematch').click
end

def make_move(row, column)
  selector = "td[data-row=#{row}][data-column=#{column}]"
  page.execute_script "jQuery('#{selector}').click()"
end

def wait_for_requirejs
  Timeout.timeout(5) do
    loop until requirejs_modules_loaded?
  end
end

def requirejs_modules_loaded?
  page.evaluate_script("require.defined('game')") == true
end

def wait_for_ajax
  Timeout.timeout(5) do
    loop until finished_all_ajax_requests?
  end
end

def finished_all_ajax_requests?
  page.evaluate_script('jQuery.active').zero?
end
