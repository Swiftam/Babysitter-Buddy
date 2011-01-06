class DependentsController < ApplicationController
  # POST /dependents
  # POST /dependents.xml
  def index
    redirect_to mypage_url
    return
    #@contacts = Contact.all

    #respond_to do |format|
    #  format.html # index.html.erb
    #  format.xml  { render :xml => @contacts }
    #end
  end

  # POST /dependents
  # POST /dependents.xml
  def create
    @dependent = Dependent.new(params[:dependent])
    @dependent.user_id = session[:user_id]
    @user = User.find(session[:user_id])

    respond_to do |format|
      if @dependent.save
        format.html { redirect_to(@user, :notice => 'Contact was successfully created.') }
        format.xml  { render :xml => @user, :status => :created, :location => @dependent }
        #format.html { redirect_to(@contact, :notice => 'Contact was successfully created.') }
        #format.xml  { render :xml => @contact, :status => :created, :location => @contact }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @dependent.errors, :status => :unprocessable_entity }
      end
    end
  end

end