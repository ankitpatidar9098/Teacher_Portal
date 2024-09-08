class TeachersController < ApplicationController
  before_action :require_login, only: [:show]
  def new
    @teacher = Teacher.new
  end

  def create

    @teacher = Teacher.create(
      name: params.dig(:teacher, :name),
      email: params.dig(:teacher, :email),
      password: params.dig(:teacher, :password)
    )
  if @teacher.persisted?
      session[:teacher_id] = @teacher.id
      redirect_to teacher_path(@teacher), notice: "Account created successfully!"
    else
      flash.now[:error] = @teacher.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
    @teacher = Teacher.find(params[:id])
    @students = @teacher.students
  end

  private
  
  def require_login
    unless session[:teacher_id]
      redirect_to root_path, flash: { error: "You must be logged in to access this section" }
    end
  end
end
