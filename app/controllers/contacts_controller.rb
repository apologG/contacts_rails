class ContactsController < ApplicationController

  before_action :set_contact, only: [:edit, :update]
  before_action :all_groups, only: [:new, :edit, :create]
  
  def index
    show_by_group
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
      flash[:success] = I18n.t('controllers.contact.updated')
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def show_by_group
    if params[:group_id] && !params[:group_id].empty?
      @contacts = Group.find(params[:group_id]).contacts.order(created_at: :desc).page(params[:page])
    else
      @contacts = Contact.order(created_at: :desc).page(params[:page])
    end
  end

  def contact_params
    params.require(:contact).permit(:name, :address, :email, :company, :phone, :group_id)
  end

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def all_groups
    @groups = Group.all
  end
end
