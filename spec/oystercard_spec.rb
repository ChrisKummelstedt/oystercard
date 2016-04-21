load "oystercard.rb"

describe Oystercard do

  let (:card) { described_class.new }
  let (:entry_station) { double :entry_station, zone: 1}
  let (:exit_station) { double :exit_station, zone: 2}

  context "balance" do

    it "shows the inital balance as 0" do
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


  describe "Touching in and out" do

    context "Card has enough money" do

      before do
        card.top_up(Oystercard::BALANCE_LIMIT)
      end

      it "touches card in" do
        expect(card).to respond_to(:touch_in).with(1).argument
      end

      it "touches card out" do
        expect(card).to respond_to(:touch_out).with(1).argument
      end

      it "changes balance upon touch out by correct amount if journey is incomplete" do
        expect{ card.touch_out(exit_station) }.to change { card.balance }.by -6
      end

      it "changes balance upon touch out by correct amount if journey is complete" do
        card.touch_in(entry_station)
        expect{ card.touch_out(exit_station)}.to change { card.balance }.by -2
      end

    end



    context "No money on the card" do

      it "Does not allow travel below minimum balance" do
        expect {card.touch_in(entry_station)}.to raise_error "You do not have the minimum balance for travel"
      end
    end


  end
end
