class Shift < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :start_time, presence: true
end
