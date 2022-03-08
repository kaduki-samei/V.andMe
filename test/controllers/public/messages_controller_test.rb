require "test_helper"

class Public::MessagesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_messages_new_url
    assert_response :success
  end
end
