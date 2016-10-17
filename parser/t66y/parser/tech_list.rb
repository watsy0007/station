module T66y
  module Parser
    class TechList
      include Wombat::Crawler

      pages 'xpath=//div[@class=\'pages\']/a', :iterator do |e|
        e.parser 'tech_list'
        e.link './@href'
      end
    end
  end
end
