require './abstract_valve_controller'
require './constants'

class PValveController < AbstractValveController
  GAIN = 5

  def calculate_openness(temperature)
    constrain(GAIN * error(temperature) + VALVE_SET_POINT)
  end

  def constrain(level)
    level.clamp(VALVE_MIN, VALVE_MAX).round
  end

  def error(temperature)
    @desired_temperature - temperature
  end
end
