class Journey

  def initialize entry_station = nil, exit_station = nil
    @entry_station = entry_station
    @exit_station = exit_station
  end

  def in_journey?
    !!entry_station
  end

  def deduct fare
    @balance -= fare
  end

  def

  def fare_calculator entry_station, exit_station
    ((1 + (entry_station.zone - exit_station.zone).abs)*ZONE_FARE)
  end

end
