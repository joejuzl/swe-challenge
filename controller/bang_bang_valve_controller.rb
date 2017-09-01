require './abstract_valve_controller'
require './constants'

class BangBangValveController < AbstractValveController
  def calculate_openness(temperature)
    if temperature > @desired_temperature
      VALVE_MIN
    elsif temperature < @desired_temperature
      VALVE_MAX
    else
      VALVE_SET_POINT
    end
  end
end
