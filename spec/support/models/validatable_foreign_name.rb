class ValidatableForeignName < ActiveRecord::Base
  belongs_to :foreigner, class_name: "Associatable"

  validates :foreigner_id, resource_existence: { class_name: "Associatable" }
end
