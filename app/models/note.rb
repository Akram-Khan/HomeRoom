class Note < ActiveRecord::Base

	attr_accessible :note, :course_id, :user_id

	validates :note, :presence => {:message => "Note can't be blank" }
	validates :course_id, :presence => true
	validates :user_id, :presence => true

	belongs_to :course
	belongs_to :user 

	has_many :comments, :dependent => :destroy
	has_many :likes, :dependent => :destroy
	
end
