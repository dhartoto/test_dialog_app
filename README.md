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
# Run specific tests in non-headless mode
HEADLESS=false bin/rails test test/system/forms_test.rb
```


### Dialog Handling

Since `unhandled_prompt_behavior` is set to `ignore`, tests must explicitly handle confirmation dialogs:

```ruby
accept_confirm do
  visit root_path
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
