class LikesController < ApplicationController
	before_filter :authenticate_user!

	def create
		@post = Post.find(params[:like][:post_id])
	    @like = @post.likes.new(:post_id => @post.id, :user_id =>current_user.id)
	    @like.save
	    redirect_to :back
	end
end
