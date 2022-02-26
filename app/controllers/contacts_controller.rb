# frozen_string_literal: false

class ContactsController < ApplicationController
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  http_basic_authenticate_with name: "junior", password: "secret"
  
  before_action :set_contact, only: %i[show update destroy]

  # GET /contacts
  def index
    @contacts = Contact.all

    render json: @contacts
  end

  # GET /contacts/1
  def show
    render json: @contact, include: [:kind, :address, :phones], meta: { author: 'Junior F' }
  end

  # POST /contacts
  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      render json: @contact, include: [:kind], meta: { author: 'Junior F' },
             status: :created, location: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /contacts/1
  def update
    if @contact.update(contact_params)
      render json: @contact, include: [:kind], meta: { author: 'Junior F' }
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # DELETE /contacts/1
  def destroy
    @contact.destroy
  end

  private
  # Use callbacks to share comm"on setup or constraints between actions.
  def set_contact
    @contact = Contact.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def contact_params
    # params.require(:contact).permit(
    #   :name, :email, :birthdate, :kind_id,
    #   phones_attributes: [:id, :number, :_destroy],
    #   address_attributes: [:id, :street, :city],
    # )
    ActiveModelSerializers::Deserialization.jsonapi_parse(params)
  end
end

