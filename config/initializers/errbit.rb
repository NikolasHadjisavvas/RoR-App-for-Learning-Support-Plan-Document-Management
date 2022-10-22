Airbrake.configure do |config|
    config.api_key = '9eeba1c7425b8b6f4c67e1961735f504'
    config.host    = 'errbit.hut.shefcompsci.org.uk'
    config.port    = 443
    config.secure  = config.port == 443
  end