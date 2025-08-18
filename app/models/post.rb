class Post < ApplicationRecord
  belongs_to :user
  belongs_to :group, optional: true
  has_many :comments, dependent: :destroy

  validates :content, presence: true, length:{maximum:20}
end
