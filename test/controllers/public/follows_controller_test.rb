require "test_helper"

class Public::FollowsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_follows_index_url
    assert_response :success
  end
end
