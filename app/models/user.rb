class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:github,:google_oauth2,:facebook,:twitter]

         has_many :posts ,dependent: :destroy
         has_many :comments , dependent: :destroy
         has_many :likes 

         
         def role?
            if self.has_role? :admin
              return "Admin"
            else
              return "user"
            end
         end

#          def self.from_omniauth(auth)
#           where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
#           user.email = auth.info.email
#           user.password = Devise.friendly_token[0,20]
#         end
#           #user.name = auth.info.name   # assuming the user model has a name
# end

    def self.from_omniauth(access_token)
        data = access_token.info
        user = User.where(email: data['email']).first

        # Uncomment the section below if you want users to be created if they don't exist
        unless user
            user = User.create(
               email: data['email'],
               password: Devise.friendly_token[0,20]
            )
        end
        user
    end

end
