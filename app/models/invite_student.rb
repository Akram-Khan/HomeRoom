class InviteStudent < ActiveRecord::Base
	attr_accessible :email

    email_regex = /^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/i


	belongs_to :course
end
