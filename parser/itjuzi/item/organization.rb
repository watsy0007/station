module Itjuzi
  module Item
    class Organization
      def save(link, data)
        org = Model::Organization.find_by(link: link)

        data['name'] = data.delete 'title'
        data['link'] = link
        datas = Model::Organization.attribute_names.each_with_object({}) do |item, acc|
          acc[item.to_s] = data[item.to_s] if data[item.to_s]
        end
        ::Engine::Logger.debug(datas)
        return Model::Organization.new(datas).save if org.nil?
        return if org.updated_at > 7.days.ago
        org.update(datas)
      end
    end
  end
end
