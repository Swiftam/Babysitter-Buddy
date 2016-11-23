class UsersController < ApplicationController
  # GET /users
  # GET /users.xml
  def index
    redirect_to mypage_url
    return
    #@users = User.all
    #
    #respond_to do |format|
    #  format.html # index.html.erb
    #  format.xml  { render :xml => @users }
    #end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    #@user = User.find(params[:id])
    @user = current_user
    @contacts = Contact.find_by(:user_id => @user.id)
    @contact = Contact.new(:user_id => @user.id)
    @children = Dependent.find_by(:user_id => @user.id)
    @dependent = Dependent.new

    respond_to do |format|
      format.html # show.html.erb
      format.rss
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    #@user = User.find(params[:id])
    @user = current_user
    @status = 'unsubscribed'

    # Detect whether user is subscribed to Mailing List
    if @user.email.to_s.length > 0
      h = Hominid::API.new('bc8d1da101dc2024b124e30af36fb513-us1')
      member_info = h.list_member_info('98f9b77c0b', [@user.email] )
      if member_info['success'] > 0
        @status = member_info['data'][0]['status']
      end
    end
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to(@user, :notice => 'User was successfully created.') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    #@user = User.find(params[:id])
    @user = current_user

    respond_to do |format|
      if @user.update_attributes(params[:user])
        password = @user.id.to_s << @user.password
        crypt_password = Digest::SHA512.hexdigest(password)
        User.update(@user.id, :password => crypt_password)
        # Subscribe to the Mailchimp list
        begin
          h = Hominid::API.new('bc8d1da101dc2024b124e30af36fb513-us1')
          if params[:mailing_list]
            first_name, last_name = @user.name.split(/\s+/, 2)
            if first_name.to_s.strip.length == 0
              first_name = ''
            end
            if last_name.to_s.strip.length == 0
              last_name = ''
            end
            h.list_subscribe('98f9b77c0b', @user.email, {'FNAME' => first_name, 'LNAME' => last_name}, 'html', true, true, true, true)
          else
            h.list_unsubscribe('98f9b77c0b', @user.email, false, true, true)
          end
        rescue Hominid::APIError
          # Fail gracefully - this will occur when user attempts to unsubscribe
          # when they haven't yet subscribed (such as when an account is created
          # with the 'subscribe' option unchecked
        end

        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    #@user = User.find(params[:id])
    @user = current_user
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end
