class NotesController < ApplicationController
  respond_to :html, :xml, :json
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
      respond_with do |format|
        format.html do
          if request.xhr?
            render :partial => "courses/show_note", :locals => { :post => @note }, :layout => false, :status => :created
          else
            redirect_to course_path(@course)
          end
        end
      end
    end
  end


  def show
  end

end
