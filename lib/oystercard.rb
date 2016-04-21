load 'journey.rb'

class Oystercard

	BALANCE_LIMIT = 90
	MINIMUM_BALANCE = 1

	attr_reader :balance, :journey_track

	def initialize
		@balance = 0
		@journey_track = []
		@journey = Journey.new
	end

	def top_up amount
		fail "Your balance cannot exceed £#{BALANCE_LIMIT}" if (amount + @balance) > BALANCE_LIMIT
		@balance += amount
	end

	def touch_in station
		fail "You do not have the minimum balance for travel" if @balance < MINIMUM_BALANCE
		@journey.start_journey(station)
	end

	def touch_out station
		@journey.finish_journey(station)
		deduct @journey.calculate_fare
	end

	def deduct fare
		@balance -= fare
	end

end
