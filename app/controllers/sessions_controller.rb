class SessionsController < ApplicationController
  def new
  end

  def create
    @teacher = Teacher.find_by(email: params[:email])
    if @teacher&.authenticate(params[:password])
      session[:teacher_id] = @teacher.id
      redirect_to teacher_path(@teacher)
    else
      flash[:error] = "Invalid email or password"
      render :new
    end
  end

  def destroy
    session[:teacher_id] = nil
    redirect_to root_path
  end
end
