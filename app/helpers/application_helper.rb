module ApplicationHelper

  def logo
  	image_tag "homeroom_logo.png", :alt => "Home Room"
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def course_correct_user
      @course = Course.find(params[:course_id])
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
          flash[:notice] = "Please accept the invitation to post on this course."
          redirect_to dashboard_path
          return
        end
      end

      @invite_teachers = @course.invite_teachers.all
      @invite_teachers.each do |invite_teacher|
        if current_user.email == invite_teacher.email
          @context = "invite_teacher"
          flash[:notice] = "Please accept the invitation to post on this course."
          redirect_to dashboard_path
          return
        end
      end

      flash[:error] = "You must be an authorized user to view this page."
      redirect_to dashboard_path
  end

  def course_restrict_if_course_is_inactive
    course = Course.find(params[:course_id])
    if course.active == FALSE
      flash[:error] = "The course is not yet active."
      redirect_to dashboard_path
    end
  end

end
