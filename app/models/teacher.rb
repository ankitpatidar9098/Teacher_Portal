class Teacher < ApplicationRecord
  has_many :students, dependent: :destroy

  has_secure_password
  
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
