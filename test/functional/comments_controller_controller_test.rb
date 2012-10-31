require 'test_helper'

class Admin::CommentsControllerTest < ActionController::TestCase
 

  setup do
    @comment = comments(:comentario_um)
  end

  test 'should get admin/index' do 
  	get :index
  	assert_response :success
  end

end
