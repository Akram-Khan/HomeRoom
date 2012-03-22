class InviteStudentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :restrict_invite_students_form, :only =>[:new, :create]

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
          @invite_student.invited_by = current_user.id
          if @invite_student.save
            UserMailer.send_invite_to_students(current_user.firstname, current_user.lastname, @invite_student.email, @course.name).deliver
          end
        end
      end
  end

  def decline_student_invitation
    @course = Course.find(params[:id])
    invited_students = @course.invite_students.all
    invited_students.each do |invited_student|
      if current_user.email == invited_student.email
        invited_student.destroy
        redirect_to dashboard_path
        return
      end
    end
    flash[:error] = "Student not found"
    redirect_to dashboard_path
  end

private

  def restrict_invite_students_form
    @course = Course.find(params[:course_id])
    @primary_teacher = @course.teachers.first 
    if current_user == @primary_teacher
      return
    else 
      flash[:error] = "You are not authorised to access this page"
      redirect_to dashboard_path
    end
  end

end
