require 'json'
require 'bigdecimal'
require 'abstraction'
require './errors'

class AbstractValveController
  abstract

  def initialize(desired_temperature)
    @desired_temperature = desired_temperature
  end

  def receive(message)
    temperature = get_temperature(message)
    puts "Temperature reading: #{temperature}"

    openness = calculate_openness(temperature)
    puts "Set Valve to: #{openness}"
    {
      level: openness
    }.to_json
  end

  def get_temperature(message)
    payload = JSON.parse(message)

    value = payload.fetch('value')
    BigDecimal.new(value)
  rescue => e
    raise InvalidMessage.new(e.message)
  end


  def calculate_openness(_temperature)
    raise NotImplementedError
  end
end
