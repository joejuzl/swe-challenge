require 'rubygems'
require 'mqtt'
require './errors'

class Client
  READ_TOPIC = 'readings/temperature'.freeze
  ACTUATOR_TOPIC = 'actuators/room-1'.freeze
  BROKER_URL = 'broker'.freeze

  class << self
    def connect(controller)
      puts "Connecting to #{READ_TOPIC}."
      puts '------------------'

      MQTT::Client.connect(BROKER_URL) do |client|
        client.get(READ_TOPIC) do |_topic, message|
          begin
            puts 'Message received.'

            response = controller.receive(message)
            client.publish(ACTUATOR_TOPIC, response)
          rescue InvalidMessage => e
            puts e
          ensure
            puts '------------------'
          end
        end
      end
    end
  end
end
