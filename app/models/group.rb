class Group < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users
  has_many :shifts, dependent: :destroy
  has_many :messages, dependent: :destroy

  validates :name, presence: true

end
