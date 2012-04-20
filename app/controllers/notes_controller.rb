class NotesController < ApplicationController
	before_filter :authenticate_user!

  def index
  end

  def new
  	@course = Course.find(params[:course_id])
  	@note = Note.new
  end

  def create
  	@course = Course.find(params[:course_id])
  	@note = Note.new(params[:note])
  	if @note.save
  		redirect_to course_path(@course)
  	else
  		render :action => "new"
  	end
  end

  def show
  end

  def destroy
    @course = Course.find(params[:course_id])
    @note = Note.find(params[:id])
    @user = current_user
    if @user.id == @note.user.id || @user.id == @course.teachers.first.id
      @note.destroy
    else
      redirect_to @course
    end
    respond_to do |format|
      format.html { redirect_to @course }
      format.js   {render :nothing => true}
    end
  end

end
