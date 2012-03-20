class UserMailer < ActionMailer::Base
  default :from => "admin@akaruilabs.com"
  #default_url_options[:host] = "http://footyaddicts.co.uk"
  default_url_options[:host] = "homeroom9.com"

  def course_created_by_student(firstname, lastname, email, course)
  	@firstname = firstname
  	@lastname = lastname
  	@email = email
  	@course = course
  	@coursename = @course.name
    mail(:to => @email, :subject => "HomeRoom Course #{@coursename.capitalize} Created")
  end

  def course_created_by_teacher(firstname, lastname, email, course)
  	@firstname = firstname
  	@lastname = lastname
  	@email = email
  	@course = course
  	@coursename = @course.name
    mail(:to => @email, :subject => "HomeRoom Course #{@coursename.capitalize} Created")
  end

  def send_invite_to_teacher(firstname, lastname, email, invited_by_firstname, invited_by_lastname, coursename)
  	@firstname = firstname
  	@lastname = lastname
  	@email = email
  	@invited_by_firstname = invited_by_firstname
  	@invited_by_lastname = invited_by_lastname
  	@coursename = coursename
    mail(:to => @email, :subject => "HomeRoom: Your student #{@invited_by_firstname} has invited you to join the course #{@coursename}")
  end

end
