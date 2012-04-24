class CommentsController < ApplicationController
	respond_to :html, :xml, :json
	before_filter :authenticate_user!
	before_filter :correct_user
	before_filter :restrict_if_course_is_inactive


	def create
	    @post = Post.find(params[:comment][:post_id])
	    @comment = @post.comments.new(:comment=> params[:comment][:comment], :user_id =>current_user.id)
	    @comment.save
	    redirect_to :back  
  	end


	def destroy
		@course = Course.find(params[:course_id])
		@user = current_user
		@comment = Comment.find(params[:id])
		@post = @comment.post
		if @user.id == @comment.user.id || @user.id == @course.teachers.first.id
		    if @comment.destroy
			    respond_with do |format|
			      	format.html do
			      		if request.xhr?
			      			render :partial => "courses/post_comments", :locals => {:post => @post}, :layout => false, :status => :destroyed
			      		else
			      			redirect_to @course
			      		end
			      	end
			    end
			end
	    end
	end

private

  	def correct_user
      	@course = Course.find(params[:course_id])
      	@students = @course.students.all
      	@students.each do |student|
        	if current_user == student
          		@context = "student"
          		return
        	end
      	end

      	@teachers = @course.teachers.all
      	@teachers.each do |teacher|
        	if current_user == teacher
          		@context = "teacher"
          		return
        	end
      	end

      	@invite_students = @course.invite_students.all
      	@invite_students.each do |invite_student|
        	if current_user.email == invite_student.email
          		@context = "invite_student"
          		flash[:notice] = "Please accept the invitation to post on this course."
          		redirect_to dashboard_path
          		return
        	end
      	end

      	@invite_teachers = @course.invite_teachers.all
      	@invite_teachers.each do |invite_teacher|
        	if current_user.email == invite_teacher.email
          		@context = "invite_teacher"
          		flash[:notice] = "Please accept the invitation to post on this course."
          		redirect_to dashboard_path
          		return
        	end
      	end

      	flash[:error] = "You must be an authorized user to view this page."
      	redirect_to dashboard_path
  	end

  	def restrict_if_course_is_inactive
    	course = Course.find(params[:course_id])
    	if course.active == FALSE
      		flash[:error] = "The course is not yet active."
      		redirect_to dashboard_path
    	end
  	end

end
