require 'oystercard'

describe Oystercard do
  let (:card){ described_class.new }
  let (:entry_station){ double :station}
  let (:exit_station){ double :station}
  let (:journey) { {entry_station: entry_station, exit_station: exit_station} }


  describe "#initialize" do
    it "initilizes with a balance of 0" do
      expect(card.balance).to eq 0
    end
  end

  describe "#top_up" do
    context "topping up" do
      it "allows people to increase balance by amount topped up" do
        expect{ card.top_up 10 }.to change{ card.balance }.by 10
      end
    end

    context "maximum limits" do
      it "enforces a maximum limit constant on card" do
        expect{ card.top_up (Oystercard::MAX_LIMIT + 1) }.to raise_error "Max limit reached - Card will contain more than #{Oystercard::MAX_LIMIT} GBP - Top up less"
      end
    end
  end

  describe "#touch_in" do
    context "standard case" do
      it "changes status to in_journey == true" do
        card.top_up Oystercard::MIN_FARE
        expect{ card.touch_in (entry_station) }.to change { card.in_journey? }.to true
      end
    end
    context "no money on card" do
      it "raises the correct error when balance is insufficient to pay for one journey" do
        expect{ card.touch_in (entry_station) }.to raise_error "No balance is less than #{Oystercard::MIN_FARE} GBP - Can't pay for journey - Top that shit up"
      end
    end
  end

  describe "#touch_out" do
    context "tracking journey" do
      it "changes status to in_journey == false" do
        card.top_up Oystercard::MIN_FARE
        card.touch_in (entry_station)
        expect{ card.touch_out (exit_station) }.to change { card.in_journey? }.to false
      end
      it 'stores history of journeys' do
        card.top_up Oystercard::MAX_LIMIT
        card.touch_in (entry_station)
        expect{ card.touch_out (exit_station) }.to change { card.journeys.last }.to journey
      end
    end
    context "touch out changes balance" do
      it "reduces money by Oystercard's minimum fare when you touch out" do
        card.top_up Oystercard::MIN_FARE
        card.touch_in (entry_station)
        expect{ card.touch_out (exit_station) }.to change { card.balance }.by -Oystercard::MIN_FARE
      end
    end
  end





end
