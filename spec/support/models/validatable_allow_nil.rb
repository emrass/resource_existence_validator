class ValidatableAllowNil < ActiveRecord::Base
  self.table_name = "validatables"

  belongs_to :associatable

  validates :associatable_id, resource_existence: { allow_nil: true }
end
