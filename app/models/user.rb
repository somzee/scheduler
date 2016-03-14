class User < ActiveRecord::Base
	
	has_many :tasks, dependent: :destroy
	has_secure_password

end
