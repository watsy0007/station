module Engine
  class Producer
    include Celluloid
    attr_accessor :scheduce
    def initialize(scheduce = Schedule.new, cache = Cache.new)
      # @scheduce = scheduce
      # @cache = cache
      # @scheduce.push ParseStruct.new(parser: 'organization_list', link: 'https://www.itjuzi.com/investfirm', namespace: 'itjuzi')
    end

    def run(scheduce, cache)
      @scheduce = scheduce
      @cache = cache
      loop do
        if @scheduce.future.empty?.value
          puts 'empty'
          sleep(2)
          next
        end
        item = @scheduce.future.pop.value
        next if parsed?(item)
        puts "start parse #{item.link}"
        data = item.parse_class.new.crawl(item.link)
        cache(item, data)
        data = parse_link(data, item.namespace)
        next if data.empty?
        item.item_class.new.save(item.link, data)
      end
    end

    def parse_link(data, namespace)
      return puts "#{data} is empty" if data.nil?
      links = ->(data, namespace) do
        next if data['link'].blank? || parsed?(data)
        @scheduce.future.push ParseStruct.new(parser: data['parser'], link: data['link'], namespace: namespace)
      end
      ['pages', 'details'].each { |field| data.delete(field)&.map { |page| links.call(page, namespace) } }
      data
    end

    def parsed?(data)
      @cache.future.include?(data['link']).value
    end

    def cache(item, data)
      @cache.future[item['link']] = data
    end
  end
end
