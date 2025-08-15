require "capybara"

# Check if we want to run in non-headless mode
HEADLESS_MODE = ENV.fetch("HEADLESS", "true").downcase != "false"

# Helper method to add common Chrome options
def add_common_chrome_options(options)
  # Use the latest Chrome version with webdrivers
  options.add_argument("--no-sandbox")
  options.add_argument("--disable-dev-shm-usage")
  options.add_argument("--disable-gpu")
  options.add_argument("--remote-debugging-port=9222")
  # options.browser_version = "136"
  options.web_socket_url = true

  # Enable bi-directional protocol (Chrome DevTools Protocol)
  options.add_argument("--enable-features=VizDisplayCompositor")

  # Set unhandled prompt behavior to ignore
  options.add_argument("--disable-blink-features=AutomationControlled")
  options.add_argument("--disable-extensions")

  # Configure unhandled prompt behavior
  options.add_argument("--disable-notifications")
  options.add_argument("--disable-popup-blocking")
  options.add_argument("--disable-web-security")
  options.add_argument("--allow-running-insecure-content")

  # Additional options for non-headless mode
  unless HEADLESS_MODE
    options.add_argument("--start-maximized")
    options.add_argument("--disable-infobars")
  end
end

Capybara.register_driver :selenium_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  add_common_chrome_options(options)

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options: options,
    service: Selenium::WebDriver::Chrome::Service.new(
      args: [ "--verbose", "--log-path=#{Rails.root}/log/chromedriver.log" ]
    )
  )
end

Capybara.register_driver :selenium_chrome_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new(unhandled_prompt_behavior: :ignore)

  # Add headless argument only if HEADLESS_MODE is true
  options.add_argument("--headless") if HEADLESS_MODE

  add_common_chrome_options(options)

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options: options,
    service: Selenium::WebDriver::Chrome::Service.new(
      args: [ "--verbose", "--log-path=#{Rails.root}/log/chromedriver.log" ]
    )
  )
end

# Set default driver
Capybara.default_driver = :selenium_chrome
Capybara.javascript_driver = :selenium_chrome_headless

# Configure Capybara settings
Capybara.configure do |config|
  config.default_max_wait_time = 10
  config.server = :puma, { Silent: true }

  # Handle unhandled prompts automatically
  config.automatic_label_click = true
  config.automatic_reload = false

  # Add some debugging options for non-headless mode
  unless HEADLESS_MODE
    config.default_max_wait_time = 15  # Give more time when debugging visually
  end
end

# Log the current mode
puts "Capybara running in #{HEADLESS_MODE ? 'headless' : 'non-headless'} mode"
puts "Set HEADLESS=false to run in non-headless mode for debugging"
