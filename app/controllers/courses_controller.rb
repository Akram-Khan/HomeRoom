class CoursesController < ApplicationController
	make_resourceful do
		actions :all
	end

	def students
		@title = "Students"
		@course = Course.find(params[:id])
		@students = @course.students
		render = "students"
	end

	def enroll_as_student
		begin
			@course = Course.find(params[:id])
			@course.students << current_user
			flash[:success] = "Successfully Enrolled"
			redirect_to course_path(@course)
		rescue ActiveRecord::RecordInvalid
			redirect_to course_path(@course)
	    	flash[:error] = "You already enrolled at this course"
	    end
	end

	def show
		@course = Course.find(params[:id])
		@student = @course.students.build
	end

	def create
		@course = Course.new(params[:course])
		if @course.save
			if @course.created_by == "Student"
				@course.students << current_user
				UserMailer.course_created_by_student(current_user.firstname, current_user.lastname, current_user.email, @course).deliver
				flash[:success] = "Course successfully created, you are the first student"
				redirect_to new_course_invite_teacher_path(@course)
			elsif @course.created_by == "Teacher"
				@course.teachers << current_user
				UserMailer.course_created_by_teacher(current_user.firstname, current_user.lastname, current_user.email, @course).deliver
				flash[:success] = "Course successfully created, you are the Teacher of this course"
				redirect_to new_course_invite_student_path(@course)
			end
		else
			flash[:error] = "This course already exists, to enroll please contact your teacher"
			render :action => "new"
		end
	end
end
