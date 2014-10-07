require 'faraday'
require 'net/http'
require 'json'

def convert_kelvin_to_fahrenheit (kelvin)
  (((kelvin - 273.15)* 1.8) + 32.00).round(2)
end

WEATHER_PATH = "/data/2.5/weather?q="
base_url = 'http://api.openweathermap.org'

conn = Faraday.new(:url => base_url) do |faraday|
  #faraday.response :logger
  faraday.adapter Faraday.default_adapter
end

#bad idea to put ARGV directly into a service request but this is a spike
weather_uri = WEATHER_PATH + ARGV[0]

response = conn.get(weather_uri)

weather_data = JSON.parse(response.body)

#puts "#{response.body}"
#puts "-----------------------------"

fahrenheit = convert_kelvin_to_fahrenheit(weather_data['main']['temp'])

puts "Current temperature in #{weather_data['name']} is #{fahrenheit} degrees"
