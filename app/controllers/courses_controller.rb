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
		@course.invitation_code = generate_activation_code(6)
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

private

	def generate_activation_code(size)
	  charset = %w{ 2 3 4 6 7 9 A C D E F G H J K M N P Q R T V W X Y Z}
	  (0...size).map{ charset.to_a[rand(charset.size)] }.join
	end

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
