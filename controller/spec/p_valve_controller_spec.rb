require './p_valve_controller'
require './constants'

describe PValveController do
  describe '#calculate_openness' do
    let(:controller) { PValveController.new(DESIRED_TEMPERATURE) }

    (1..300).step(5).each do |offset|
      context 'temperature too high' do
        let(:temperature) { DESIRED_TEMPERATURE + offset }

        it 'should be less than half open' do
          expect(controller.calculate_openness(temperature)).to be < VALVE_SET_POINT
        end
      end

      context 'temperature too low' do
        let(:temperature) { DESIRED_TEMPERATURE - offset }

        it 'should be more than half open' do
          expect(controller.calculate_openness(temperature)).to be > VALVE_SET_POINT
        end
      end
    end

    context 'correct temperature' do
      it 'should turn valve to half open' do
        expect(controller.calculate_openness(DESIRED_TEMPERATURE)).to eq(VALVE_SET_POINT)
      end
    end
  end
end
