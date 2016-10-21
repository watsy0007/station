Station.configuration do |e|
  # uncomment next comments
  # e.schedule = Station::MemorySchedule.new
  # e.schedule.push Station::ParseStruct.new(
  #   parser: 'organization_list',
  #   link: 'https://www.itjuzi.com/investfirm',
  #   namespace: 'itjuzi'
  # )
  # e.cache = Station::MemoryCache.new

  # comment below
  e.schedule = Station::DbSchedule.new
  e.cache = Station::DbCache.new
end
