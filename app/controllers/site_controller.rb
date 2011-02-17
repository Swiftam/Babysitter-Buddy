class SiteController < ApplicationController
  def index()
  end

  # GET /site/register
  def register()
    @user = current_user

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

  def login()
    session[:user_id] = nil
    @user = User.where(:email => params[:email] ).first
    if @user.nil?
      redirect_to root_url
    else
      cat_s = @user.id.to_s << params[:password]
      crypt_password = Digest::SHA512.hexdigest(cat_s)

      if @user.password == crypt_password
        session[:user_id] = @user.id
        redirect_to :controller => 'users', :action => 'show', :id => @user.id
      else
        redirect_to about_url
      end
    end
  end

  def mypage()
    @user = self.current_user
    if @user.nil?
      @user = User.new
      if @user.save
        session[:user_id] = @user.id
      end
    end
    redirect_to :controller => 'users', :action => 'show', :id => @user.id
  end

  def logout()
    session[:user_id] = nil
    redirect_to root_url
  end
end
