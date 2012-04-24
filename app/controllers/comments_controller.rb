class CommentsController < ApplicationController
	respond_to :html, :xml, :json
	before_filter :authenticate_user!

	def create
		@course = Course.find(params[:course_id])
	  	@post = Post.find(params[:comment][:post_id])
	  	@comment = @post.comments.new(:comment=> params[:comment][:comment], :user_id =>current_user.id)

	    if @comment.save
	    	respond_with do |format|
	        	format.html do
	          		if request.xhr?
	            		render :partial => "courses/post_comments", :locals => { :post => @post }, :layout => false, :status => :created
	          		else
	            		redirect_to @course
	          		end
	        	end
	      	end
	    end
	end


	def destroy
		comment = Comment.find(params[:id])
	    comment.destroy
	    redirect_to :back or root_path
	end
end
