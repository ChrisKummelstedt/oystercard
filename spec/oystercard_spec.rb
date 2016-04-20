load "oystercard.rb"

describe Oystercard do

  let (:card) { described_class.new }
  let (:entry_station) { double :entry_station}
  let (:exit_station) { double :exit_station}

  context "balance" do

    it "shows the balance" do
      expect(card.balance).to eq 0
    end

    it "tops up the balance" do
      expect{ card.top_up 1 }.to change{ card.balance }.by 1
    end

    it "deducts the money from the balance" do
      expect{ card.deduct 1 }.to change{ card.balance }.by -1
    end

    it 'cannot top up above the balance limit' do
      card.top_up(Oystercard::BALANCE_LIMIT)
      expect { card.top_up 1}.to raise_error "Your balance cannot exceed £#{Oystercard::BALANCE_LIMIT}"
    end
  end

  context "contact" do
    it "has contact" do
      balance_limit = Oystercard::BALANCE_LIMIT
      card.top_up(balance_limit)
      expect { card.top_up 1}.to raise_error "Your balance cannot exceed £#{balance_limit}"
    end
  end


  describe "Touching in and out" do

    context "Card has enough money" do

      before do
        card.top_up(Oystercard::MINIMUM_BALANCE)
      end

      it "touches card in" do
        card.touch_in(entry_station)
        expect(card).to be_in_journey
      end

      it "touches card out" do
        card.touch_in(entry_station)
        card.touch_out(exit_station)
        expect(card).not_to be_in_journey
      end

      it "confirms user is journey" do
        expect(card).not_to be_in_journey
      end

    end

    context "No money on the card" do

      it "Does not allow travel below minimum balance" do
        expect {card.touch_in(entry_station)}.to raise_error "You do not have the minimum balance for travel"
      end
    end

    context "Knows entry and exit station" do

      it "Knows which station the journey started" do
        card.top_up(Oystercard::BALANCE_LIMIT)
        card.touch_in(entry_station)
        expect(card.entry_station).to eq entry_station
      end

      it "Knows which station the journey ended" do
        card.top_up(Oystercard::BALANCE_LIMIT)
        card.touch_in(entry_station)
        card.touch_out(exit_station)
        expect(card.exit_station).to eq exit_station
      end
		end

    context "Keeping track of journey" do

    	it "keeps a empty hash when initialize" do
        expect(card.journey_track).to eq []
       end

    	it "tracks the travel that has been done" do
    		card.top_up(Oystercard::BALANCE_LIMIT)
        card.touch_in(entry_station)
        card.touch_out(exit_station)
        expect(card.journey_track).to include { entrystation:entry_station, exitstation:exit_station }
			end
    end

    context "Keep track check in" do
    	it "track if someone forget to check out" do
    		card.top_up(Oystercard::BALANCE_LIMIT)
        card.touch_in(entry_station)
        expect{card.touch_in(entry_station)}.to change {card.balance}.by -Oystercard::PENALTY_FAIR 
			end
		end
	end
end














