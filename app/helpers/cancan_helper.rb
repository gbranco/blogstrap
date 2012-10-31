module CancanHelper

  def user_can_handle_actions_for_model?(model, &block)
    permissions_type = [:manage, :read, :create, :update, :destroy]

    permissions_type.each do |permission|
      if can? permission, model.constantize
        yield   
        break 
      end
    end
		
  end

end

