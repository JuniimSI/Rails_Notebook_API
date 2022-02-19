# frozen_string_literal: false

class Contact < ApplicationRecord
  # Associations
  belongs_to :kind, optional: true
  has_many :phones

  def birthdate_br
    I18n.l(birthdate) unless birthdate.blank?
  end

  def to_br
    {
      name: name,
      email: email,
      birthdate: birthdate_br
    }
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

