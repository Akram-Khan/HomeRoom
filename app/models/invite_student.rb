class InviteStudent < ActiveRecord::Base
	attr_accessible :email

    email_regex = /^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/i

    validates :email,   :presence   => true,
  						:uniqueness => {:message => "This student is already invited to join the course"}
                      

	belongs_to :course

end
