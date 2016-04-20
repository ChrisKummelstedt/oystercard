<<<<<<< HEAD
require 'oystercard'

describe Oystercard do
  let (:card){ described_class.new }
  let (:entry_station){ double :entry_station, zone: 1}
  let (:exit_station){ double :exit_station, zone: 2}
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
      it "make sure it contains zone info" do
        card.top_up Oystercard::MAX_LIMIT
        card.touch_in(entry_station)
        card.touch_out(exit_station)
        expect(card.journeys.last[:entry_station].zone).to eq entry_station.zone
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
=======
load "oystercard.rb"

describe Oystercard do

  context "balance" do

		it "shows the balance" do
	  expect(subject.balance).to eq 0
		end

	  it "tops up the balance" do
	    expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
	  end

	  it "deducts the money from the balance" do
	  	expect{ subject.deduct 1 }.to change{ subject.balance }.by -1
	  end

	  it 'cannot top up above the balance limit' do
	    subject.top_up(Oystercard::BALANCE_LIMIT)
	    expect { subject.top_up 1}.to raise_error "Your balance cannot exceed #{Oystercard::BALANCE_LIMIT}"
	  end
	end
  
  context "contact" do
	    balance_limit = Oystercard::BALANCE_LIMIT
	    subject.top_up(balance_limit)
	    expect { subject.top_up 1}.to raise_error "Your balance cannot exceed £#{balance_limit}"
	  end

  end


describe "Touching in and out" do

  context "Card has enough money" do

    before do
      subject.top_up(Oystercard::MINIMUM_BALANCE)
    end

		it "touches card in" do
			subject.touch_in
			expect(subject).to be_in_journey
		end

    it "touches card out" do
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
    end

		it "confirms user is journey" do
			expect(subject).not_to be_in_journey
		end

  end

  context "No money on the card" do

    it "Does not allow travel below minimum balance" do
      expect {subject.touch_in}.to raise_error "You do not have the minimum balance for travel"
    end
	end
end
end

>>>>>>> 99ce2a1ffb9d184491c60307df62f0a79bf217a2
