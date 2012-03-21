class InviteTeachersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :restrict_invite_teacher_form, :only =>[:new, :create]

  def new
  	@course = Course.find(params[:course_id])
  	@invite_teacher = InviteTeacher.new
  end

  def create
  	@course = Course.find(params[:course_id])
    @invite_teacher = @course.invite_teachers.build(params[:invite_teacher])
    if @invite_teacher.email == current_user.email
      flash[:error] = "You cannot be both a student and teacher of the same course"
      render :action => "new"
    else
      if @invite_teacher.save
        UserMailer.send_invite_to_teacher(@invite_teacher.firstname, @invite_teacher.lastname, @invite_teacher.email, current_user.firstname, current_user.lastname, @course.name).deliver
      	flash[:success] = "Thank You! The teacher has been invited to join the course"
      	redirect_to dashboard_path
      else
      	flash[:error] = "We are sorry but there was some problem and the teacher could not be invited. Please try again"
      	render :action => "new"
      end
    end

  end


private

  def restrict_invite_teacher_form
    @course = Course.find(params[:course_id])
    @primary_student = @course.students.first 
    if current_user == @primary_student
      return
    else 
      flash[:error] = "You are not authorised to access this page"
      redirect_to dashboard_path
    end
  end

end
