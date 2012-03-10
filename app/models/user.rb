class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :firstname, :lastname

  name_regex = /^(([a-z]_)|[a-z])([a-z])*$/i

  validates :firstname, :presence   => true, 
                        :length     => { :within => 1..30 },
                        :format => {:with => name_regex, :message => "Only English language letters allowed" }
  validates :lastname,  :presence   => true, 
                        :length     => { :within => 1..30 },
                        :format => {:with => name_regex, :message => "Only English language letters allowed" }
end
