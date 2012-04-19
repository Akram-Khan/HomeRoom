class Course < ActiveRecord::Base
	attr_accessible :number, :name, :school, :term, :year, :created_by

	validates :number, :presence => {:message => "Course Number can't be blank" }
	validates :name, :presence => {:message => "Course Name can't be blank" }
	validates :school, :presence => {:message => "School can't be blank" }
	validates :term, :presence => {:message => "Term can't be blank" }
	validates :year, :presence => {:message => "Year can't be blank" }
	validates :created_by, :presence => {:message => "Created by can't be blank" }

    validates_uniqueness_of :number, :scope => [:school, :term, :year], :message => "This course already exists, to enroll please contact your teacher" 

    has_many  :roles, :dependent => :destroy
    has_many  :teachers,  :through => :roles, :source => :user, :conditions => ['roles.name = ?', 'teacher']
    has_many  :students, :through => :roles, :source => :user, :conditions => ['roles.name = ?', 'student']

    has_many :invite_teachers, :dependent => :destroy
    has_many :invite_students, :dependent => :destroy
    has_many :posts, :dependent => :destroy
    has_many :comments, :dependent => :destroy

end
