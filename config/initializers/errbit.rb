Airbrake.configure do |config|
  config.api_key = ENV['ERRBIT']
  config.host    = '193.182.16.50'
  config.port    = 3005
  config.secure  = config.port == 443
end
