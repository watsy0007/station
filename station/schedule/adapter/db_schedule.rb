require_relative '../schedule'
module Station
  class DbSchedule < Schedule
    attr_accessor :model
    def initialize
    end

    def push(item)
      ::Station::Model::Schedule.new(
        parser: item.parser,
        namespace: item.namespace,
        link: item.link
      ).save
    end

    def pop
      ::Station::Model::Schedule.transaction do
        model = ::Station::Model::Schedule.waitings.first
        model.progressing!
        model
      end
    end

    def empty?
      ::Station::Model::Schedule.waitings.size.zero?
    end

    def done(item)
      ::Station::Model::Schedule.transaction do
        model = ::Station::Model::Schedule.find_by(id: item.id)
        model.done! unless item.nil?
      end
    end

    def inspect?
      "#{self.class} #{self} size: #{@queue.size}"
    end
  end
end
