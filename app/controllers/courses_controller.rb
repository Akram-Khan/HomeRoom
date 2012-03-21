class CoursesController < ApplicationController
	before_filter :authenticate_user!
	before_filter :correct_user, :only => [:show, :teachers, :students]

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

private

	def correct_user

		@course = Course.find(params[:id])
		@students = @course.students.all
		@students.each do |student|
			if current_user == student
				@context = "student"
				return
			end
		end

		@teachers = @course.teachers.all
		@teachers.each do |teacher|
			if current_user == teacher
				@context = "teacher"
				return
			end
		end

		@invite_students = @course.invite_students.all
		@invite_students.each do |invite_student|
			if current_user == invite_student
				@context = "invite_student"
				return
			end
		end

		@invite_teachers = @course.invite_teachers.all
		@invite_teachers.each do |invite_teacher|
			if current_user == invite_teacher
				@context = "invite_teacher"
				return
			end
		end

		flash[:error] = "You must be an authorized user to view this page"
		redirect_to dashboard_path
	end

end
