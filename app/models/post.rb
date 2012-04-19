class Post < ActiveRecord::Base

	attr_accessible :description, :course_id, :user_id

	belongs_to :course
	belongs_to :user 

	has_many :comments, :dependent => :destroy
	has_many :likes, :dependent => :destroy

	validates :course_id, :presence => true
	validates :user_id, :presence => true
end
