class CommentsController < ApplicationController
	before_filter :authenticate_user!

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
		if @user.id == @comment.user.id || @user.id == @course.teachers.first.id
	      @comment.destroy
	    else
	      redirect_to @course
	    end
	    respond_to do |format|
	    	format.html { redirect_to @course }
      		format.js   {render :nothing => true}
    	end
	end

end
