# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord 
    before_validation :ensure_session_token
    validates :session_token, presence: true, uniqueness: true
    validates :username, presence: true, uniqueness: true
    validates :password_digest, presence: true

    def password=(password)
        self.password_digest = Bcrypt::Password.create(password)
        @password = password
    end

    def is_password?(password)
        password_object = Bcrypt::Password.new(self.password_digest)
        password_digest.is_password?(password)
    end

    def self.find_by_creditials(username, password)
        user = User.find_by(username: username)
        if user && user.is_password?(password)
            user
        else
            nil
        end
    end

end