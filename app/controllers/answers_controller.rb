class AnswersController < ApplicationController
  respond_to :html, :xml, :json
  before_filter :authenticate_user!
  before_filter :correct_user
  before_filter :restrict_if_course_is_inactive

  def index
  end

  def new
  	@course = Course.find(params[:course_id])
  	@answer = Answer.new

    respond_to do | format |  
        format.js {render :layout => false}  
    end
  end

  def create
    @course = Course.find(params[:course_id])
    @post = Post.find(params[:answer][:post_id])
    @answer = Answer.new(params[:answer])

    if @answer.save
      respond_with do |format|
        format.html do
          if request.xhr?
            render :partial => "courses/answers", :locals => { :post => @post }, :layout => false, :status => :created
          else
            redirect_to course_path(@course)
          end
        end
      end
    else
      redirect_to course_path(@course)
    end
  end


  def show
  end

  def destroy
    @course = Course.find(params[:course_id])
    @answer = Answer.find(params[:id])
    @post = Post.find(@answer.post_id)

    @user = current_user
    if @user.id == @answer.user.id || @user.id == @course.teachers.first.id
      if @answer.destroy
        respond_with do |format|
            format.html do
              if request.xhr?
                render :partial => "courses/answers", :locals => {:post => @post}, :layout => false, :status => :created
              else
                redirect_to @course
              end
            end
        end
      else
        redirect_to @course
      end
    else
      redirect_to @course
    end
  end

  def mark_as_correct
    @course = Course.find(params[:course_id])
    @answer = Answer.find(params[:answer_id])
    @post = Post.find(@answer.post_id)
    @user = current_user
    
    if @user.id == @answer.post.user.id || @user.id == @course.teachers.first.id
      @answer.correct = TRUE
      if @answer.save
        respond_with do |format|
            format.html do
              if request.xhr?
                logger.debug "-------> HERE"
                render :partial => "courses/answers", :locals => {:post => @post}, :layout => false, :status => :created
              else
                logger.debug "------> NOT POSSIBLE"
                redirect_to @course
              end
            end
        end
      else
        redirect_to @course
      end
    else
      flash[:error] = "You are not authorized to perform this action"
      redirect_to @course
    end
  end


private

  def correct_user
      role_found = 0
      @course = Course.find(params[:course_id])
      @students = @course.students.all
      @students.each do |student|
        if current_user == student
          @context = "student"
          role_found = 1
          return
        end
      end

      @teachers = @course.teachers.all
      @teachers.each do |teacher|
        if current_user == teacher
          @context = "teacher"
          role_found = 1
          return
        end
      end

      @invite_students = @course.invite_students.all
      @invite_students.each do |invite_student|
        if current_user.email == invite_student.email
          @context = "invite_student"
          flash[:error] = "Please accept the invitation to post on this course."
          role_found = 1
          redirect_to dashboard_path
          return
        end
      end

      @invite_teachers = @course.invite_teachers.all
      @invite_teachers.each do |invite_teacher|
        if current_user.email == invite_teacher.email
          @context = "invite_teacher"
          flash[:error] = "Please accept the invitation to post on this course."
          role_found = 1
          redirect_to dashboard_path
          return
        end
      end

      if role_found == 0
        flash[:error] = "You must be an authorized user to view this page."
        redirect_to dashboard_path
      end
  end

  def restrict_if_course_is_inactive
    course = Course.find(params[:course_id])
    if course.active == FALSE
      flash[:error] = "The course is not yet active."
      redirect_to dashboard_path
    end
  end
end