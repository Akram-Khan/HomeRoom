class CommentsController < ApplicationController
	before_filter :authenticate_user!

	def create
	    @note = Note.find(params[:comment][:note_id])
	    @comment = @note.comments.new(:comment=> params[:comment][:comment], :user_id =>current_user.id)
	    @comment.save
	    redirect_to :back  
  	end


	def destroy
		comment = Comment.find(params[:id])
	    comment.destroy
	    redirect_to :back or root_path
	end
end
