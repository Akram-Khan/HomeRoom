class InviteStudentsController < ApplicationController
  def new
  	@course = Course.find(params[:course_id])
  	@invite_student = InviteStudent.new
  end

  def create
  	@course = Course.find(params[:course_id])
  	@emails_text = params[:invite_student][:email]
  	@emails = @emails_text.split(/\s*,\s*/)
  	@emails.each do |email|
  		@invite_student = @course.invite_students.new
  		@invite_student.email = email
  		@invite_student.course_id = @course.id
  		@invite_student.save
  	end
  	redirect_to root_url
  end
end
