module Engine
  class Producer
    include Celluloid
    attr_accessor :schedule, :cache

    def initialize(schedule, cache)
      @schedule = schedule
      @cache = cache
    end

    def start
      loop do
        next sleep(0.2) if @schedule.empty?
        item = @schedule.pop
        next sleep(0.2) if item.nil? || parsed?(item)
        Logger.debug "start parse #{item.link}"
        data = cache(item) { item.parse_class.new.crawl(item.link) }
        next if data.empty?
        data = parse_link(data, item.namespace)
        next if data.empty?
        item.item_class.new.save(item.link, data)
      end
    end

    def parse_link(data, namespace)
      links = ->(data, namespace) do
        next if data['link'].blank? || parsed?(data)
        @schedule.push ParseStruct.new(parser: data['parser'], link: data['link'], namespace: namespace)
      end
      ['pages', 'details'].each { |field| data.delete(field)&.map { |page| links.call(page, namespace) } }
      data
    end

    def parsed?(data)
      @cache.include?(data['link'])
    end

    def cache(item, data = 'parsing')
      @cache[item['link']] = data
      data = yield if block_given?
      @cache[item['link']] = data
      data
    end
  end
end
