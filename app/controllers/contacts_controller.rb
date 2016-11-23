class ContactsController < ApplicationController
  # GET /contacts
  # GET /contacts.xml
  def index
    redirect_to mypage_url
    return
    #@contacts = Contact.all

    #respond_to do |format|
    #  format.html # index.html.erb
    #  format.xml  { render :xml => @contacts }
    #end
  end

  # GET /contacts/1
  # GET /contacts/1.xml
  def show
    @contact = Contact.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contact }
    end
  end

  # GET /contacts/new
  # GET /contacts/new.xml
  def new
    @contact = Contact.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @contact }
    end
  end

  # GET /contacts/1/edit
  def edit
    @contact = Contact.find(params[:id])
  end

  # POST /contacts
  # POST /contacts.xml
  def create
    @contact = Contact.new(contact_params)
    @contact.user_id = session[:user_id]
    @user = User.find(session[:user_id])

    respond_to do |format|
      if @contact.save
        format.html { redirect_to(@user, :notice => 'Contact was successfully created.') }
        format.xml  { render :xml => @user, :status => :created, :location => @contact }
        #format.html { redirect_to(@contact, :notice => 'Contact was successfully created.') }
        #format.xml  { render :xml => @contact, :status => :created, :location => @contact }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /contacts/1
  # PUT /contacts/1.xml
  def update
    @contact = Contact.find(params[:id])

    respond_to do |format|
      if @contact.update_attributes(contact_params)
        format.html { redirect_to(@contact, :notice => 'Contact was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.xml
  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy

    respond_to do |format|
      format.html { redirect_to(contacts_url) }
      format.xml  { head :ok }
    end
  end

  private
    def contact_params
      # Ensure posted record contains the correct fields 
      # Whitelist nested elements
      params.require(:contact).permit(:name, :number)
    end
end
