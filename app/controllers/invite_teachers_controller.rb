class InviteTeachersController < ApplicationController

  def new
  	@course = Course.find(params[:course_id])
  	@invite_teacher = InviteTeacher.new
  end

  def create
  	@course = Course.find(params[:course_id])
    @invite_teacher = @course.invite_teachers.build(params[:invite_teacher])
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