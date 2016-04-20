class Oystercard

	BALANCE_LIMIT = 90
	MINIMUM_BALANCE = 1
	attr_reader :balance, :touched_in, :entry_station, :exit_station, :journey_track

	def initialize
		@balance = 0
		@entry_station = nil
		@exit_station = nil
    @journey_track = []
	end

	def top_up amount
		fail "Your balance cannot exceed £#{BALANCE_LIMIT}" if (amount + @balance) > BALANCE_LIMIT
		@balance += amount
	end

	def touch_in station
		fail "You do not have the minimum balance for travel" if @balance < MINIMUM_BALANCE
		@entry_station = station
	end

	def touch_out station
		deduct fare
		@exit_station = station
    current_journey = {entrystation: @entry_station, exitstation: @exit_station}
    @journey_track.push(current_journey)
		@entry_station = nil
  end

	def in_journey?
		!!entry_station
	end

	def deduct fare
		@balance -= fare
	end

	private

	def fare
		1
	end

	def journey
	end

end
