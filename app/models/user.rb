class User < ActiveRecord::Base
	
	has_many :tasks, dependent: :destroy
	validates_uniqueness_of :email
	has_secure_password

end
