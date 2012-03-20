class Role < ActiveRecord::Base

  attr_accessible :course_id, :user_id, :name

  validates :course_id, :presence => true
  validates :user_id, :presence => true
  validates :name, :presence => true
  validates_uniqueness_of :course_id, :scope => :user_id, :message => "Already Enrolled!" 

  belongs_to :user
  belongs_to :course
end
