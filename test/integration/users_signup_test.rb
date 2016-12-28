require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test "invalid signup information" do
      get signup_path
      asser_no_difference 'User.count' do
          post_users_path, params: {user: {name: "",
                                           tag: "" } }
      end
      assert_template 'users/new'
  end
  
  # test "the truth" do
  #   assert true
  # end
end
