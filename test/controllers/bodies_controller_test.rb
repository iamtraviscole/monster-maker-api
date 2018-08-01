require 'test_helper'

class BodiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @body = bodies(:one)
  end

  test "should get index" do
    get bodies_url, as: :json
    assert_response :success
  end

  test "should create body" do
    assert_difference('Body.count') do
      post bodies_url, params: { body: { type: @body.type } }, as: :json
    end

    assert_response 201
  end

  test "should show body" do
    get body_url(@body), as: :json
    assert_response :success
  end

  test "should update body" do
    patch body_url(@body), params: { body: { type: @body.type } }, as: :json
    assert_response 200
  end

  test "should destroy body" do
    assert_difference('Body.count', -1) do
      delete body_url(@body), as: :json
    end

    assert_response 204
  end
end
