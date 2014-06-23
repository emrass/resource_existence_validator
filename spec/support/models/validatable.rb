class Validatable < ActiveRecord::Base
  belongs_to :associatable

  validates :associatable_id, resource_existence: true
end
