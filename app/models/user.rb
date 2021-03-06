class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :dishes
  has_many :reviews
  has_many :favorites

  mount_uploader :avatar, PhotoUploader

  def avatar_file_name # temp fix!!
    begin
      super
    rescue
      ""
    end
  end
end
