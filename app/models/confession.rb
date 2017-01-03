class Confession < ActiveRecord::Base

  enum status: [:pending, :accepted, :reject]
  validates :content, presence: true

  class << self
    def each_month year
      confessions_per_month = (1..12).map do |month|
        {name: Date::MONTHNAMES[month], y: confessions_of_month(month, year)}
      end
    end

    def confessions_of_month month, year
      Confession.accepted
        .where("year(created_at) = #{year} and month(created_at) = #{month}").size
    end
  end
end
