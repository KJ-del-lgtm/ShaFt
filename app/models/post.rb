class Post < ApplicationRecord
  belongs_to :user
  belongs_to :group, optional: true

  validates :content, presence: true, length:{maximum:20}
end
