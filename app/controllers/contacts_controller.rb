class ContactsController < ApplicationController

  def index
    show_by_group
  end

  private

  def show_by_group
    if params[:group_id] && !params[:group_id].empty?
      @contacts = Group.find(params[:group_id]).contacts.page(params[:page])
    else
      @contacts = Contact.page(params[:page])
    end
  end

end
