require 'file_size_validator' 
class Post < ActiveRecord::Base

	mount_uploader :attached, AttachedUploader



	attr_accessible :attached, :url, :description, :course_id, :user_id

	belongs_to :course
	belongs_to :user 

	has_many :comments, :dependent => :destroy
	has_many :likes, :dependent => :destroy
	has_many :answers, :dependent => :destroy

	validates :course_id, :presence => true
	validates :user_id, :presence => true
end
