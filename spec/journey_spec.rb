load 'journey.rb'

describe Journey do
  let (:journey) { described_class.new }
  let (:entry_station) { double :entry_station, zone: 1 }
  let (:exit_station) { double :exit_station, zone: 2 }
  let (:card) { double :card, touch_in(:entry_station)}

  context "#start_journey" do
    it "start journey when passed a station" do
      expect(journey.start_journey(entry_station)).to eq entry_station
    end
  end

  context "#finish_journey" do
    it "finishes journey when passed a station" do
      expect(journey.finish_journey(exit_station)).to eq exit_station
    end
  end

  context "#calculate_fare" do
    it "calculates the correct fare between zone 1 and zone 2 (2 GBP)" do
      journey.start_journey(entry_station)
      journey.finish_journey(exit_station)
      expect(journey.calculate_fare).to eq 2
    end
  end

  context "#in_journey?" do
    it "knows that it is in journey after you start a journey" do
      journey.start_journey(entry_station)
      expect(journey).to be_in_journey
    end
  end

  context "#penalty" do
    it "knows that penalty must be applied for incomplete journey" do
      journey.start_journey(entry_station)
      expect(journey.calculate_fare).to eq Journey::PENALTY_FARE
    end
  end


end
