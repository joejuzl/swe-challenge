require './bang_bang_valve_controller'
require './constants'

describe BangBangValveController do
  describe '#calculate_openness' do
    let(:controller) { BangBangValveController.new(DESIRED_TEMPERATURE) }

    (1..300).step(5).each do |offset|
      context 'temperature too high' do
        let(:temperature) { DESIRED_TEMPERATURE + offset }

        it 'should turn valve to closed' do
          expect(controller.calculate_openness(temperature)).to eq(VALVE_MIN)
        end
      end

      context 'temperature too low' do
        let(:temperature) { DESIRED_TEMPERATURE - offset }

        it 'should turn valve to full' do
          expect(controller.calculate_openness(temperature)).to eq(VALVE_MAX)
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
