class User < ActiveRecord::Base
  # Include default devise modules.
  mount_uploader :image, ProficUploader
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable#, :omniauthable
  include DeviseTokenAuth::Concerns::User
  validates :name, presence: true, length: { minimum: 5, maximum: 40 }
end
