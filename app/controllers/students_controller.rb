class StudentsController < ApplicationController
  before_action :require_login

  def index
    @students = Student.all
  end

  def create
    student = Student.find_by(name: params[:student][:name], subject: params[:student][:subject], teacher_id: current_teacher.id)
    if student
      student.marks += params[:student][:marks].to_i
      student.save
    else
      student = current_teacher.students.new(student_params)
     if student.save!
    end
  end
     respond_to do |format|
      # format.html { redirect_to teacher_path(current_teacher) }
      format.js 
     end
  end

  def edit
    @student = Student.find(params[:id])
  end

  def update
    student = Student.find(params[:id])
    student.update(student_params)
    redirect_to teacher_path(current_teacher)
  end

  def destroy
    student = Student.find(params[:id])
    student.destroy
     redirect_to teacher_path(current_teacher), notice: 'Student was successfully deleted.'
  end

  private

  def student_params
    params.require(:student).permit(:name, :subject, :marks)
  end

  def require_login
    unless session[:teacher_id]
      redirect_to root_path
    end
  end
end