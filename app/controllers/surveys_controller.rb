class SurveysController < ApplicationController
  before_action :set_survey, only: [:show, :update]

  def index
    @surveys = Survey.all
    render json: @surveys
  end

  def show
    render json: @survey
  end

  # POST 
  def create
    @survey = Survey.new(survey_params)

    if @survey.save
      render json: {data: @survey, success: true, message: "Survey created successfully"}, status: :created
    else
      render json: @survey.errors, status: :unprocessable_entity
    end
  end

  def update
    if @survey.update(survey_params)
      render json: {data: @survey, success: true, message: "Survey updated successfully"}
    else
      render json: @survey.errors, status: :unprocessable_entity
    end
  end

  private
    def set_survey
      @survey = Survey.find(params[:id])
    end

    def survey_params
      params.require(:survey).permit(:name, :description)
    end
end
