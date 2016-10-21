module Station
  class Producer
    include Celluloid
    attr_accessor :schedule, :cache, :proxies, :proxy

    def initialize(schedule, cache, proxies)
      @schedule = schedule
      @cache = cache
      @proxies = proxies
      @proxy = proxies.pop
    end

    def start
      loop do
        next sleep(0.2) if @schedule.empty?
        item = @schedule.pop
        next sleep(0.2) if parsed?(item)
        Logger.debug "start parse #{item.link}"
        data = parse_item(item)
        next if data.nil? || data.empty?
        data = parse_links(data, item.namespace)
        next if data.empty?
        item.item_class.new.save(item.link, data)
      end
      Logger.debug "done"
    end

    def  parse_item(item)
      options = {
        proxy: @proxy
      }
      begin
        data = cache(item) { item.parse_class.new.crawl(item.link, options) }
        @schedule.done(item)
        data
      rescue Exception => e
        Station.logger.error("%s: %s\n%s" % [item.link, e.message, e.backtrace[0..5].join("\n")])
        @schedule.failed(item)
        @proxy = proxies.pop
        nil
      end
    end

    def parse_links(data, namespace)
      links = ->(data, namespace) do
        next if data['link'].blank? || parsed?(data)
        @schedule.push ParseStruct.new(parser: data['parser'], link: data['link'], namespace: namespace)
      end
      ['pages', 'details'].each { |field| data.delete(field)&.map { |page| links.call(page, namespace) } }
      data
    end

    def parsed?(data)
      data.nil? || @cache.include?(data['link'])
    end

    def cache(item, data = 'parsing')
      @cache[item['link']] = data
      data = yield if block_given?
      @cache[item['link']] = data
      data
    end
  end
end
