class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable, :omniauthable and :trackable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :omniauthable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :address, :phone, :name
  # attr_accessible :title, :body

  def self.from_omniauth(auth)
    provider = auth.provider.to_s
    uid = auth.provider.to_s
    where(provider: provider, uid: uid).first_or_create do |user|
      user.name = auth.info.name.to_s
      user.provider = provider
      user.uid = uid
      user.email = nil
    end
  end

  def password_required?
    super && provider.blank?
  end

  def email_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      params.delete :current_password
      update_attributes(params, *options)
    else
      super
    end
  end
end
