class InviteStudentsController < ApplicationController

  def new
  	@course = Course.find(params[:course_id])
  	@invite_student = InviteStudent.new
  end

  def create
  	@course = Course.find(params[:course_id])
  	@emails_text = params[:invite_student][:email]
    valid_email(@emails_text)
    redirect_to dashboard_path
  end

  def valid_email(emails_text)
      @emails = emails_text.split(/\s*,\s*/)
      @emails.each do |email|
        if email =~ /\b[A-Z0-9._%a-z-]+@(?:[A-Z0-9a-z-]+.)+[A-Za-z]{2,4}\z/ && email != current_user.email
          @invite_student = @course.invite_students.new
          @invite_student.email = email
          @invite_student.course_id = @course.id
          if @invite_student.save
            UserMailer.send_invite_to_students(current_user.firstname, current_user.lastname, @invite_student.email, @course.name).deliver
          end
        end
      end
  end

end
