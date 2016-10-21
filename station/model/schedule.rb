module Station
  module Model
    class Schedule < ::Station::ApplicationRecord
      establish_connection database_config
      enum status: [:waiting, :progressing, :done, :failed]

      default_scope -> { order(id: :desc) }

      scope :waitings, -> { where(status: :waiting) }
      scope :progressings, -> { where(status: :progressing) }
      scope :progressed, -> { where(status: [:done]) }
      scope :recent_1_day, -> { where('created_at > ?', 1.day.ago) }

      def parse_class
        path = "#{namespace}/parser/#{parser}"
        path.camelize.constantize
      end

      def item_class
        path = "#{namespace}/item/#{parser}"
        path.camelize.constantize
      end
    end
  end
end
