class LikeAnswersController < ApplicationController
	respond_to :html, :xml, :json
	before_filter :authenticate_user!
	before_filter :correct_user
	before_filter :restrict_if_course_is_inactive

	def create
		@course = Course.find(params[:course_id])
	    @user = current_user
	  	@answer = Answer.find(params[:like_answer][:answer_id])
    	@post = Post.find(@answer.post_id)

	    if @answer.like_answers.exists?
	      @answer.like_answers.each do |like_answer|
	        if like_answer.user_id == @user.id
	          redirect_to :back
	          return
	        end
	      end
	      @like_answer = @answer.like_answers.new(:answer_id => @answer.id, :user_id =>current_user.id)
	      if @like_answer.save
	        respond_with do |format|
	          format.html do
	            if request.xhr?
	              render :partial => "courses/answers", :locals => { :post => @post }, :layout => false, :status => :created
	            else
	              redirect_to @course
	            end
	          end
	        end
	      end
	    else
	      @like_answer = @answer.like_answers.new(:answer_id => @answer.id, :user_id =>current_user.id)
	      if @like_answer.save
	        respond_with do |format|
	          format.html do
	            if request.xhr?
	              render :partial => "courses/answers", :locals => { :post => @post }, :layout => false, :status => :created
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
      	role_found = 0
    	@course = Course.find(params[:course_id])
    	@students = @course.students.all
    	@students.each do |student|
	      	if current_user == student
	        		@context = "student"
	            role_found = 1
	        		return
	      	end
    	end

    	@teachers = @course.teachers.all
    	@teachers.each do |teacher|
	      	if current_user == teacher
	        		@context = "teacher"
	            role_found = 1
	        		return
	      	end
    	end

    	@invite_students = @course.invite_students.all
    	@invite_students.each do |invite_student|
	      	if current_user.email == invite_student.email
	        		@context = "invite_student"
	        		flash[:error] = "Please accept the invitation to participate in this course."
	            role_found = 1
	        		redirect_to dashboard_path
	        		return
	      	end
    	end

    	@invite_teachers = @course.invite_teachers.all
    	@invite_teachers.each do |invite_teacher|
	      	if current_user.email == invite_teacher.email
	        		@context = "invite_teacher"
	        		flash[:error] = "Please accept the invitation to participate in this course."
	            role_found = 1
	        		redirect_to dashboard_path
	        		return
	      	end
    	end

    	if role_found == 0
	        flash[:error] = "You must be an authorized user to view this page."
	    	redirect_to dashboard_path
      	end
	end

	def restrict_if_course_is_inactive
	  	course = Course.find(params[:course_id])
	  	if course.active == FALSE
	    		flash[:error] = "The course is not yet active."
	    		redirect_to dashboard_path
	  	end
	end
end

