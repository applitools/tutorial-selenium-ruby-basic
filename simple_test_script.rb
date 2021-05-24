require 'eyes_selenium'

options = Selenium::WebDriver::Chrome::Options.new
options.add_argument('--headless') if ENV['CI'] == 'true'

runner = Applitools::ClassicRunner.new
eyes = Applitools::Selenium::Eyes.new(runner: runner)
web_driver = Selenium::WebDriver.for :chrome, options: options

eyes.batch = Applitools::BatchInfo.new("Demo Batch")

eyes.configure do |conf|
  conf.app_name = 'Demo App - ruby'
  conf.test_name = 'Smoke Test'
  conf.viewport_size = Applitools::RectangleSize.new(800, 600)
end

begin
  # Call Open on eyes to initialize a test session
  driver = eyes.open(driver: web_driver)

  # Navigate to the url we want to test
  driver.get('https://demo.applitools.com')

  # Note to see visual bugs, run the test using the above URL for the 1st run.
  # but then change the above URL to https://demo.applitools.com/index_v2.html (for the 2nd run)

  # check the login page
  eyes.check(name: 'Login window', target: Applitools::Selenium::Target.window.fully)

  # Click the 'Log In' button
  driver.find_element(:id, 'log-in').click

  # Check the app page
  eyes.check(name: 'App window', target: Applitools::Selenium::Target.window.fully)
  eyes.close
ensure
  # Close the browser
  driver.quit
  #  If the test was aborted before eyes.close / eyes.close_async was called, ends the test as aborted.
  eyes.abort_if_not_closed
  # Get and print all test results
  puts runner.get_all_test_results
end


