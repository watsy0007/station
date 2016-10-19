Station.configuration do |e|
  e.schedule = Station::MemorySchedule.new
  e.schedule.push Station::ParseStruct.new(
    parser: 'organization_list',
    link: 'https://www.itjuzi.com/investfirm',
    namespace: 'itjuzi'
  )
end
