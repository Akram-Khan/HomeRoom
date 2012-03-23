class InviteTeacher < ActiveRecord::Base
  attr_accessible :email, :firstname, :lastname

  name_regex = /^(([a-z]_)|[a-z])([a-z])*$/i
  email_regex = /^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/i


  validates :email,     :presence   => true,
                        :length     => { :within => 1..30 },
                        :format => {:with => email_regex, :message => "Please enter a valid email address" }
  validates :firstname, :presence   => true, 
                        :length     => { :within => 1..30 },
                        :format => {:with => name_regex, :message => "Only English language letters allowed" }
  validates :lastname,  :presence   => true, 
                        :length     => { :within => 1..30 },
                        :format => {:with => name_regex, :message => "Only English language letters allowed" }
  
  validates_uniqueness_of :email, :scope => [:course_id], :message => "This teacher is already invited to join the course"
  belongs_to :course
end
