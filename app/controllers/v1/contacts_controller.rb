# frozen_string_literal: false
module V1
  class ContactsController < ApplicationController
    # before_action :authenticate_user!

    # TOKEN = "secret123"
    # include ActionController::HttpAuthentication::Basic::ControllerMethods
    # http_basic_authenticate_with name: "junior", password: "secret"
    # include ActionController::HttpAuthentication::Digest::ControllerMethods
    # USERS = {"junior" => Digest::MD5.hexdigest(["jack", "Application", "secret"].join(":"))}
    # include ActionController::HttpAuthentication::Token::ControllerMethods

    before_action :set_contact, only: %i[show update destroy]

    # GET /contacts
    def index
      page_number = params[:page].try(:[], :number)
      per_page = params[:page].try(:[], :size)
      @contacts = Contact.all.page(page_number).per(per_page)

      render json: @contacts
     # paginate json: @contacts # API PAGINATE
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

    # def authenticate
    #   # authenticate_or_request_with_http_digest("Application") do |username|
    #   #   USERS[username]
    #   # end
    #   hmac_secret = 'my$ecret'

    #   authenticate_or_request_with_http_token do |token, options|
    #     JWT.decode token, hmac_secret, true
    #     # ActiveSupport::SecurityUtils.secure_compare(
    #     #   ::Digest::SHA256.hexdigest(token),
    #     #   ::Digest::SHA256.hexdigest(TOKEN)
    #     # )
    #   end
    # end
  end
end
