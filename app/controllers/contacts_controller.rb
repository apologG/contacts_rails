class ContactsController < ApplicationController

  def index
    show_by_group
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      flash[:success] = I18n.t('controllers.contact.created')
      redirect_to root_path
    else
      flash[:error] = I18n.t('controllers.contact.error')
      render :new
    end
  end

  private

  def show_by_group
    if params[:group_id] && !params[:group_id].empty?
      @contacts = Group.find(params[:group_id]).contacts.page(params[:page])
    else
      @contacts = Contact.page(params[:page])
    end
  end

  def contact_params
    params.require(:contact).permit(:name, :address, :email, :company, :phone, :group_id)
  end

end
