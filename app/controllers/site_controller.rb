class SiteController < ApplicationController
  def index()
  end

  # GET /site/register
  def register()
    @user_id = session[:user_id]
    if @user_id.nil?
      @user = nil
    else
      @user = User.find(@user_id)
    end
    if @user.nil?
      @user = User.new
      if @user.save
        session[:user_id] = @user.id
      end
    end
    redirect_to :controller => 'users', :action => 'edit', :id => @user.id
  end

  def about()

  end

  def mypage()
    @user_id = session[:user_id]
    if @user_id.nil?
      @user = nil
    else
      @user = User.find(@user_id)
    end
    if @user.nil?
      @user = User.new
      if @user.save
        session[:user_id] = @user.id
      end
    end
    redirect_to :controller => 'users', :action => 'show', :id => @user.id
  end

  def logout()
    redirect_to root_url
  end
end
