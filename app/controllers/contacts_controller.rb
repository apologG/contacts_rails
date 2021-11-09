class ContactsController < ApplicationController

  before_action :set_contact, only: %i(edit update destroy)
  before_action :all_groups, only: [:new, :edit, :create]
  
  def index
    @contacts = Contact.by_group(params[:group_id]).search(params[:term]).order(created_at: :desc).page(params[:page])
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      I18n.t('controllers.contact.created')
      redirect_to root_path
    else
      # flash[:error] = I18n.t('controllers.contact.error')
      render :new
    end
  end

  def edit
  end

  def update
    if @contact.update(contact_params)
       I18n.t('controllers.contact.updated')
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @contact.destroy
    flash[:success] = I18n.t('controllers.contact.destroyed')
    redirect_to root_path
  end 

  private

  def contact_params
    params.require(:contact).permit(:name, :address, :email, :company, :phone, :group_id, :avatar)
  end

  def set_contact
    @contact = Contact.find(params[:id])
  end
 
  def all_groups
    @groups = Group.all
  end

end
