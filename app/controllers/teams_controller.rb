class TeamsController < ApplicationController
  def index
    @teams = Team.includes(:team_locations)
  end

  def new
    @team = Team.build_with_defaults(2, Category::DEFAULTS)
  end

  def create
    team = Team.new(team_params)

    unless team.save
      @team = team
      render :new and return
    end

    redirect_to root_path
  end

  def edit
    @team = Team.find(params[:id])
  end

  def update
    team = Team.find(params[:id])

    unless team.update(team_params)
      @team = team
      render :edit and return
    end

    redirect_to root_path, notice: "#{team.name} team updated"
  end

  def select
    self.current_team_id = params[:id]
    redirect_to root_path, notice: 'Great! Now using a new team for your EOD updates'
  end

  private

  def team_params
    params.require(:team)
          .permit(:name, :mailing_list,
                  team_locations_attributes: [:id, :name, :time_zone, :eod_time],
                  categories_attributes: [:id, :name, :_destroy]
          )
  end
end