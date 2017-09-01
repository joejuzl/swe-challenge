require './bang_bang_valve_controller'
require './p_valve_controller'
require './client'
require './constants'

# controller = BangBangValveController.new(DESIRED_TEMPERATURE)
controller = PValveController.new(DESIRED_TEMPERATURE)

puts "Starting #{controller.class.name}."
Client.connect(controller)
