module T66y
  module Parser
    class Tech
      include Wombat::Crawler

      pages 'xpath=//div[@class=\'pages\']/a', :iterator do |e|
        e.parser 'tech'
        e.link './@href'
      end
    end
  end
end
