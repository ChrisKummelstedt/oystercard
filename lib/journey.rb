class Journey

  ZONE_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @entry_station = nil
    @exit_station = nil
    @journey_cost = nil
  end

  def start_journey entry_station
    @entry_station = entry_station
  end

  def finish_journey exit_station
    @exit_station = exit_station
  end

  def in_journey?
    !!entry_station
  end

  def calculate_fare
    return @journey_cost = PENALTY_FARE if entry_station == nil || exit_station == nil
    @journey_cost = ((1 + (entry_station.zone - exit_station.zone).abs)*ZONE_FARE)
  end

private

  attr_reader :entry_station, :exit_station

end
