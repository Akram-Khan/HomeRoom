class CoursesController < ApplicationController
	before_filter :authenticate_user!
	before_filter :correct_user, :only => [:show, :teachers, :students, :join_as_student, :join_as_teacher]
	before_filter :restrict_if_course_is_inactive, :only => [:show]

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
		if @context == "invite_student"
			@course = Course.find(params[:id])
			invited_students = @course.invite_students.all
			invited_students.each do |invited_student|
				if current_user.email == invited_student.email
					invited_student.destroy
				end
			end
			@new_role = @course.roles.new
			@new_role.course_id = @course.id
			@new_role.user_id = current_user.id
			@new_role.name = "student"
			@new_role.save
			flash[:success] = "Successfully Enrolled"
			redirect_to course_path(@course)
		else
			flash[:error] = "You cannot perform this action"
			redirect_to dashboard_path
		end
	end


	def join_as_student_by_invitation_code(course)
		@course = course
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
		if @context == "invite_teacher"
			@course = Course.find(params[:id])
			invited_teachers = @course.invite_teachers.all
			invited_teachers.each do |invited_teacher|
				if current_user.email == invited_teacher.email
					invited_teacher.destroy
				end
			end
			@new_role = @course.roles.new
			@new_role.course_id = @course.id
			@new_role.user_id = current_user.id
			@new_role.name = "teacher"
			@new_role.save
			@course.active = TRUE
			@course.save
			flash[:success] = "Successfully joined as Teacher"
			redirect_to course_path(@course)
		else
			flash[:error] = "You cannot perform this action"
			redirect_to dashboard_path
		end
	end

	def join_as_teacher_by_invitation_code(course)
		@course = course
		@new_role = @course.roles.new
		@new_role.course_id = @course.id
		@new_role.user_id = current_user.id
		@new_role.name = "teacher"
		@course.active = TRUE
		@course.save
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
		@courses = Course.all
		@student = @course.students.build
		@posts = @course.posts.paginate(:page => params[:page], :per_page => 20).order("created_at DESC")
		@user = current_user
	end

	def create
		@course = Course.new(params[:course])
		@course.invitation_code_student = generate_activation_code(6)
		@course.invitation_code_teacher = generate_activation_code(6)
		if @course.save
			if @course.created_by == "Student"
				@new_role = @course.roles.new
				@new_role.course_id = @course.id
				@new_role.user_id = current_user.id
				@new_role.name = "student"				
				@new_role.save
				UserMailer.course_created_by_student(current_user.firstname, current_user.lastname, current_user.email, @course).deliver
				flash[:success] = "Course successfully created, you are the first student. Please note that this course will not be active unless it has a teacher. Please invite your teacher using the form below"
				redirect_to new_course_invite_teacher_path(@course)
			elsif @course.created_by == "Teacher"
				@new_role = @course.roles.new
				@new_role.course_id = @course.id
				@new_role.user_id = current_user.id
				@new_role.name = "teacher"				
				@new_role.save
				@course.active = TRUE
				@course.save
				UserMailer.course_created_by_teacher(current_user.firstname, current_user.lastname, current_user.email, @course).deliver
				flash[:success] = "Course successfully created, you are the Teacher of this course"
				redirect_to new_course_invite_student_path(@course)
			end
		else
			flash[:error] = "This course already exists, to enroll please contact your teacher"
			render :action => "new"
		end
	end

	def join_by_invitation_code
		invitation_code = params[:invitation_code]
		@courses = Course.all
		found = FALSE
		@courses.each do |course|
			if course.invitation_code_student == invitation_code
				found = TRUE
				join_by_invitation_code_student(course)
			elsif course.invitation_code_teacher == invitation_code
				found = TRUE
			 	join_by_invitation_code_teacher(course)
			end
		end
		if found == FALSE
			flash[:error] = "No course found with this invitation code"
			redirect_to dashboard_path
		end
	end

	def join_by_invitation_code_student(course)
		@course = course

		invited_students = course.invite_students.all
		invited_students.each do |invited_student|
			if current_user.email == invited_student.email
				invited_student.destroy
			end
		end

		join_as_student_by_invitation_code(@course)
	end

	def join_by_invitation_code_teacher(course)
		@course = course

		invited_teachers = course.invite_teachers.all
		invited_teachers.each do |invited_teacher|
			if current_user.email == invited_teacher.email
				invited_teacher.destroy
			end
		end

		join_as_teacher_by_invitation_code(@course)
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
			if current_user.email == invite_student.email
				@context = "invite_student"
				return
			end
		end

		@invite_teachers = @course.invite_teachers.all
		@invite_teachers.each do |invite_teacher|
			if current_user.email == invite_teacher.email
				@context = "invite_teacher"
				return
			end
		end

		flash[:error] = "You must be an authorized user to view this page"
		redirect_to dashboard_path
	end

	def restrict_if_course_is_inactive
		course = Course.find(params[:id])
		if course.active == FALSE
			if @context == "student"
				flash[:error] = "The course will not be active unless it has a teacher. If you haven't already done so, please invite your teacher to join the course"
				redirect_to new_course_invite_teacher_path(course)
			elsif @context == "invite_teacher"
				flash[:error] = "This course will not be active unless you Accept to be its teacher."
				redirect_to dashboard_path
			else
				flash[:error] = "You must be an authorized user to view this page."
				redirect_to dashboard_path
			end
		end
	end
end
