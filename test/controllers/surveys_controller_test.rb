require 'test_helper'

class SurveysControllerTest < ActionDispatch::IntegrationTest
  setup do
    @survey = surveys(:one)
    @valid_attributes = { name: "Sample Survey", description: "This is a sample survey" }
    @invalid_attributes = { name: nil, description: "This is a sample survey with no name" }
  end

  test "should get index" do
    get surveys_url, as: :json
    assert_response :success
    assert_equal 'application/json; charset=utf-8', @response.content_type
  end

  test "should show survey" do
    get survey_url(@survey), as: :json
    assert_response :success
    assert_equal 'application/json; charset=utf-8', @response.content_type
    parsed_response = JSON.parse(@response.body)
    assert_equal @survey.name, parsed_response['name']
  end

  test "should create survey with valid attributes" do
    assert_difference('Survey.count') do
      post surveys_url, params: { survey: @valid_attributes }, as: :json
    end
    assert_response :created
    assert_equal 'application/json; charset=utf-8', @response.content_type
    parsed_response = JSON.parse(@response.body)
    assert_equal @valid_attributes[:name], parsed_response['data']['name']
    assert parsed_response['success']
    assert_equal "Survey created successfully", parsed_response['message']
  end

  test "should not create survey with invalid attributes" do
    assert_no_difference('Survey.count') do
      post surveys_url, params: { survey: @invalid_attributes }, as: :json
    end
    assert_response :unprocessable_entity
    assert_equal 'application/json; charset=utf-8', @response.content_type
    parsed_response = JSON.parse(@response.body)
    assert_includes parsed_response['name'], "can't be blank"
  end

  test "should update survey with valid attributes" do
    new_attributes = { name: "Updated Survey", description: "This is an updated survey" }
    put survey_url(@survey), params: { survey: new_attributes }, as: :json
    assert_response :success
    assert_equal 'application/json; charset=utf-8', @response.content_type
    @survey.reload
    assert_equal new_attributes[:name], @survey.name
    assert_equal new_attributes[:description], @survey.description
    parsed_response = JSON.parse(@response.body)
    assert_equal new_attributes[:name], parsed_response['data']['name']
    assert parsed_response['success']
    assert_equal "Survey updated successfully", parsed_response['message']
  end

  test "should not update survey with invalid attributes" do
    put survey_url(@survey), params: { survey: @invalid_attributes }, as: :json
    assert_response :unprocessable_entity
    assert_equal 'application/json; charset=utf-8', @response.content_type
    parsed_response = JSON.parse(@response.body)
    assert_includes parsed_response['name'], "can't be blank"
  end
end
