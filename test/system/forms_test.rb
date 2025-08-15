require "application_system_test_case"

class FormsTest < ApplicationSystemTestCase
  test "form shows confirmation dialog and then alert when navigating away with unsaved changes" do
    visit root_path

    fill_in "Name", with: "John Doe"
    fill_in "Email", with: "john@example.com"
    fill_in "Message", with: "This is a test message"

    accept_confirm do
      visit root_path
    end
  end
end
