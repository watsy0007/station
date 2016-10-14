module Itjuzi
  module Parser
    class Organization
      include Wombat::Crawler

      title 'xpath=//span[@class=\'title\']'
      icon_url 'xpath=//div[@class=\'pic \']/img/@src'
    end
  end
end
