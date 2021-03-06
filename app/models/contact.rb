# frozen_string_literal: false

class Contact < ApplicationRecord
  # Kaminari
  paginates_per 10

  # Validates
  validates_presence_of :kind
  validates_presence_of :address

  # Associations
  belongs_to :kind
  has_many :phones
  has_one :address

  accepts_nested_attributes_for :phones, allow_destroy: true
  accepts_nested_attributes_for :address, update_only: true

  def birthdate_br
    I18n.l(birthdate) unless birthdate.blank?
  end

  def as_json(options = {})
    h = super(options)
    h[:birthdate] = birthdate_br
    h
  end

  # def author
  #   'Junior Fernandes'
  # end

  # def kind_description
  #   kind.description
  # end

  # def as_json(options={})
  #   super(
  #     root: true,
  #     methods: %i[author kind_description]
  #   )
  # end
end

