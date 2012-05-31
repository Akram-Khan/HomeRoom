class Comment < ActiveRecord::Base
	belongs_to :post
	belongs_to :user

	validates :comment, :presence => {:message => "Comment can't be blank" }
end

