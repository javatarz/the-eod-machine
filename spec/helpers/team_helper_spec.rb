require 'rails_helper'

describe TeamHelper do
  describe '.locations_summary_for' do
    let(:team) do
      Team.new(name: 'The Team').tap do |team|
        team.team_locations = [
          TeamLocation.new(name: 'NYC', time_zone: 'Eastern Time (US & Canada)', eod_time: '8:00 PM'),
          TeamLocation.new(name: 'Pune', time_zone: 'Mumbai', eod_time: '7:00 PM'),
        ]
      end
    end

    it 'summarizes team locations info' do
      locations_summary = locations_summary_for(team)

      expect(locations_summary).to eq('NYC: 8:00 PM EDT | Pune: 7:00 PM IST')
    end
  end
end