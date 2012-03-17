class Course < ActiveRecord::Base
	attr_accessible :number, :name, :school, :term, :year, :created_by

	validates :number, :presence => {:message => "Course Number can't be blank" }
	validates :name, :presence => {:message => "Course Name can't be blank" }
	validates :school, :presence => {:message => "School can't be blank" }
	validates :term, :presence => {:message => "Term can't be blank" }
	validates :year, :presence => {:message => "Year can't be blank" }
	validates :created_by, :presence => {:message => "Created by can't be blank" }

end
