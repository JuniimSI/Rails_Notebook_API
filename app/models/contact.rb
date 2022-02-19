# frozen_string_literal: false

class Contact < ApplicationRecord
  belongs_to :kind, optional: true

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

