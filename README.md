# Test Dialog App

A Rails application that demonstrates form dirty state detection with confirmation dialogs when users try to navigate away from unsaved changes.

## Features

- **Contact Form**: A basic form with name, email, and message fields
- **Dirty State Detection**: JavaScript tracks when form fields have been modified
- **Confirmation Dialogs**: Prompts users when they try to navigate away with unsaved changes
- **Capybara Testing**: Configured with latest Chrome webdriver and bi-directional protocol support

## Capybara Configuration

The application is configured with Capybara to:

1. **Use the latest Chrome version** with `selenium-webdriver`
2. **Enable bi-directional protocol** (Chrome DevTools Protocol)
3. **Set `unhandled_prompt_behavior` to `ignore`** for better test control
4. **Support both headless and non-headless modes** for debugging

Configuration is located in `test/support/capybara.rb`.

### Headless Mode Control

You can control whether tests run in headless mode using the `HEADLESS` environment variable:

- **Default (headless)**: `bin/rails test:system`
- **Non-headless (visible browser)**: `HEADLESS=false bin/rails test:system`

Non-headless mode is useful for:
- Debugging test failures visually
- Seeing how the browser interacts with your application
- Understanding test behavior step-by-step

## Testing

### Running System Tests

```bash
# Run all system tests (headless by default)
bin/rails test:system

# Run specific form tests (headless by default)
bin/rails test test/system/forms_test.rb

# Run tests in non-headless mode for debugging
HEADLESS=false bin/rails test:system

# Run specific tests in non-headless mode
HEADLESS=false bin/rails test test/system/forms_test.rb

# Or use convenience scripts
bin/test-headless                    # Run in headless mode
bin/test-visible                     # Run in non-headless mode
bin/test-headless test/system/forms_test.rb  # Run specific test headless
bin/test-visible test/system/forms_test.rb   # Run specific test visible
```

### Test Scenarios

The system tests cover:

1. **Dirty Form Navigation**: Tests that confirmation dialogs appear when navigating away from modified forms
2. **Clean Form Navigation**: Verifies that no confirmation dialogs appear for unmodified forms
3. **Form Reset**: Tests that the reset button clears the dirty state, preventing confirmation dialogs
4. **Form Submission**: Ensures form submission clears the dirty state, preventing confirmation dialogs

**Note**: The confirmation dialog only appears when the form has unsaved changes. Clean forms allow navigation without any prompts.

### Dialog Handling

Since `unhandled_prompt_behavior` is set to `ignore`, tests must explicitly handle confirmation dialogs:

```ruby
accept_confirm do
  click_link "Test Link"
end
```

## Development

### Starting the Server

```bash
bin/rails server
```

Visit `http://localhost:3000` to see the contact form.

### Form Behavior

1. **Fill out the form** - any field modification marks the form as "dirty"
2. **Try to navigate away** - click the test links or buttons
3. **Confirmation dialog appears** - asking if you want to leave with unsaved changes
4. **Reset button** - clears all fields and resets the dirty state
5. **Submit button** - processes the form and clears the dirty state

## Technical Details

- **Frontend**: Vanilla JavaScript for form state management
- **Backend**: Rails with ActiveModel for form validation
- **Testing**: Capybara with Selenium WebDriver for Chrome
- **Styling**: Custom CSS classes (Tailwind-inspired naming convention)

## Browser Support

- Chrome (latest version recommended)
- Firefox (with appropriate webdriver)
- Safari (with appropriate webdriver)

The application is optimized for Chrome with the latest webdriver features.
