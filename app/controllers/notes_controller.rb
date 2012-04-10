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

end
