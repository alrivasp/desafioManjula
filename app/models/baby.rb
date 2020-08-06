class Baby < ApplicationRecord
    has_many :breast_feedings, dependent: :destroy

    accepts_nested_attributes_for :breast_feedings, allow_destroy: true, reject_if: proc { |attributes| attributes['duration'].blank? }

    def to_s
      name
    end
    #total que ha bebido
    def total_drinking
      breast_feedings.sum(:quantity)
    end
    #tiempo total
    def total_duration
        breast_feedings.sum(:duration)
    end

    # Cantidad de veces que el bebe tomo hoy hasta ahora
    def breast_feeding_times_today
        breast_feedings.where("created_at >= :start_at AND created_at <= :end_date", {start_at: Time.now.beginning_of_day, end_date: Time.now}).count
    end

    # La fecha de la ultima vez que se alimento
    def last_time_drinking
        if breast_feedings.count > 0
            breast_feedings.last.created_at
        else
            ''
        end
    end

    # Cuanto tiempo ha tomado hoy
    def breast_feeding_duration_today
        breast_feedings.where("created_at >= :start_at AND created_at <= :end_date", {start_at: Time.now.beginning_of_day, end_date: Time.now}).sum(:duration)
    end

    # Cantidad de leche que ha tomado hoy
    def breast_feeding_quantity_today
        breast_feedings.where("created_at >= :start_at AND created_at <= :end_date", {start_at: Time.now.beginning_of_day, end_date: Time.now}).sum(:quantity)
    end
end
