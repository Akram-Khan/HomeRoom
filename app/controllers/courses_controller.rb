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

	def teachers
		@title = "Teachers"
		@course = Course.find(params[:id])
		@teachers = @course.teachers
		render = "teachers"
	end

	def join_as_student
		@course = Course.find(params[:id])
		@new_role = @course.roles.new
		@new_role.course_id = @course.id
		@new_role.user_id = current_user.id
		@new_role.name = "student"
		if @new_role.save
			flash[:success] = "Successfully Enrolled"
			redirect_to course_path(@course)
		else
			flash[:error] = "You are already enrolled at this course"
			redirect_to course_path(@course)
		end
	end

	def join_as_teacher
		@course = Course.find(params[:id])
		@new_role = @course.roles.new
		@new_role.course_id = @course.id
		@new_role.user_id = current_user.id
		@new_role.name = "teacher"
		if @new_role.save
			flash[:success] = "Successfully joined as Teacher"
			redirect_to course_path(@course)
		else
			flash[:error] = "You are already enrolled at this course"
			redirect_to course_path(@course)
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
				@new_role = @course.roles.new
				@new_role.course_id = @course.id
				@new_role.user_id = current_user.id
				@new_role.name = "student"				
				@new_role.save
				UserMailer.course_created_by_student(current_user.firstname, current_user.lastname, current_user.email, @course).deliver
				flash[:success] = "Course successfully created, you are the first student"
				redirect_to new_course_invite_teacher_path(@course)
			elsif @course.created_by == "Teacher"
				@new_role = @course.roles.new
				@new_role.course_id = @course.id
				@new_role.user_id = current_user.id
				@new_role.name = "teacher"				
				@new_role.save
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
