class Post < ApplicationRecord
  belongs_to :user
  belongs_to :group, optional: true
  has_many :comments, dependent: :destroy

  validates :content, presence: true, length:{maximum:20}

  def self.search_for(content, method)
    if method == 'perfect'
      Post.where(content: content)
    elsif method == 'forward'
      Post.where('content LIKE ?', content + '%')
    elsif method == 'backward'
      Post.where('content LIKE ?', '%' + content)
    else
      Post.where('content LIKE ?', '%' + content + '%')
    end
  end
end
