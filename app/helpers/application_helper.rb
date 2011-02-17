module ApplicationHelper
  def current_user
    @user_id = session[:user_id]

    if @user_id.nil?
      @user = nil
    else
      @user = User.find(@user_id)
    end
    @user
  end
end
