class AddKindToContact < ActiveRecord::Migration[6.0]
  def change
    add_reference :contacts, :kind
  end
end

