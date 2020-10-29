class User < ApplicationRecord
  has_many :questions
  has_many :answers
  has_many :attachments
  has_many :rewards
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def author?(resource)
    id == resource.user_id
  end
end
