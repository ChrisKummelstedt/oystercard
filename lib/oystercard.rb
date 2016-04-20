class Oystercard

	BALANCE_LIMIT = 90
	MINIMUM_BALANCE = 1
  PENALTY_FAIR = 80
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
		if in_journey?
			deduct PENALTY_FAIR
			@entry_station = station
		else
			fail "You do not have the minimum balance for travel" if @balance < MINIMUM_BALANCE
			@entry_station = station
		end
	end

	def touch_out station
		if !in_journey?
			@exit_station = station
			deduct PENALTY_FAIR
			current_journey = { entrystation: "Failed to check in", exitstation: @exit_station }
			@journey_track.push(current_journey)
		else
			@exit_station = station
	    current_journey = { entrystation: @entry_station, exitstation: @exit_station }
	    @journey_track.push(current_journey)
			@entry_station = nil
		end
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
