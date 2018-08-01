require 'test_helper'

class UnlockedBodiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @unlocked_body = unlocked_bodies(:one)
  end

  test "should get index" do
    get unlocked_bodies_url, as: :json
    assert_response :success
  end

  test "should create unlocked_body" do
    assert_difference('UnlockedBody.count') do
      post unlocked_bodies_url, params: { unlocked_body: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show unlocked_body" do
    get unlocked_body_url(@unlocked_body), as: :json
    assert_response :success
  end

  test "should update unlocked_body" do
    patch unlocked_body_url(@unlocked_body), params: { unlocked_body: {  } }, as: :json
    assert_response 200
  end

  test "should destroy unlocked_body" do
    assert_difference('UnlockedBody.count', -1) do
      delete unlocked_body_url(@unlocked_body), as: :json
    end

    assert_response 204
  end
end
