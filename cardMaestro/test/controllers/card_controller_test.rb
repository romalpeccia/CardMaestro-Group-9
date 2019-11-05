require 'test_helper'

class CardControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get card_new_url
    assert_response :success
  end

  test "should get create_card_owned" do
    get card_create_card_owned_url
    assert_response :success
  end

  test "should get create_card_needed" do
    get card_create_card_needed_url
    assert_response :success
  end

end
