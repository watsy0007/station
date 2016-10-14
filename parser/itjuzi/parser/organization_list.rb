module Itjuzi
  module Parser
  # documents
  class OrganizationList
    include Wombat::Crawler

    details 'xpath=//p[@class=\'title\']/a', :iterator do |e|
      e.link 'xpath=./@href'
      e.parser 'organization'
    end

    pages "xpath=//div[contains(@class,'ui-pagechange')]/a", :iterator do |e|
      e.link 'xpath=./@href'
      e.parser 'organization_list'
    end
  end
  end
end
