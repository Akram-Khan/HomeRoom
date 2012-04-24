class LikesController < ApplicationController
	respond_to :html, :xml, :json
	before_filter :authenticate_user!

	def create
		@course = Course.find(params[:course_id])
	  	@post = Post.find(params[:like][:post_id])
	  	@like = @post.likes.new(:post_id => @post.id, :user_id =>current_user.id)
	 
	    if @like.save
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

end
