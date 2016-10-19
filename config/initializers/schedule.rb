Engine.configuration do |e|
  e.schedule = Engine::MemorySchedule.new
  e.schedule.push Engine::ParseStruct.new(
    parser: 'organization_list',
    link: 'https://www.itjuzi.com/investfirm',
    namespace: 'itjuzi'
  )
end
