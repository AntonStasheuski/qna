class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  belongs_to :user
  validates :title, :body, presence: true

  has_many_attached :files

end
