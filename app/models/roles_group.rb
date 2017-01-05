class RolesGroup < ApplicationRecord
  has_many :users
  has_many :roles_models, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
