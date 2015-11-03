class TeamLocation < ActiveRecord::Base
  belongs_to :team

  validates :name, presence: true
  validates :time_zone, presence: true
  validate :eod_time_must_be_valid_time, :eod_time_must_be_at_valid_minute

  # TODO: Remove this behavior
  before_save :expand_eod_time

  def self.with_eod_time_near(team_locations, utc_time)
    team_locations.select do |team_location|
      team_location.eod_time_utc == utc_time.round_to(30.minutes)
    end
  end

  def eod_time_utc
    ActiveSupport::TimeZone.new(time_zone).parse(eod_time).utc
  end

  private

    def eod_time_must_be_valid_time
      Time.parse(eod_time.to_s)
    rescue ArgumentError
      errors.add(:eod_time, 'must be a valid time')
    end

    def eod_time_must_be_at_valid_minute
      time = Time.parse(eod_time.to_s)
      unless time.round_to(30.minutes) == time
        errors.add(:eod_time, 'must be at the 30 minute or hour mark')
      end
    rescue ArgumentError
      # ignore, eod_time_must_be_valid_time validation will catch this
    end

    # TODO: Remove this behavior
    def expand_eod_time
      utc_time = ActiveSupport::TimeZone.new(time_zone).parse(eod_time).utc

      self.eod_time_hour_utc = utc_time.hour
      self.eod_time_minute_utc = utc_time.min
    end
end