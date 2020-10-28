class Reward < ApplicationRecord
  belongs_to :question
  belongs_to :answer, optional: true

  has_one_attached :file

  validates :title, :file, presence: true
end
