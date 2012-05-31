class Answer < ActiveRecord::Base
	attr_accessible :description, :course_id, :user_id, :post_id

	belongs_to :course
	belongs_to :user 
	belongs_to :post

	validates :course_id, :presence => true
	validates :user_id, :presence => true
	validates :post_id, :presence => true
end
