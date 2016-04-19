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



end