FactoryGirl.define do
  factory :team_location, aliases: [:new_york] do
    name 'New York'
    time_zone 'Eastern Time (US & Canada)'
    eod_time '8:00 PM'
    team { FactoryGirl.build(:team) }
  end

  factory :hawaii, parent: :team_location do
    name 'Hawaii'
    time_zone 'Pacific/Honolulu'
    eod_time '6:00 PM'
  end
end