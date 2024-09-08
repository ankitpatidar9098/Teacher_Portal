class ApplicationController < ActionController::Base
   helper_method :current_teacher

  def current_teacher
    @current_teacher ||= Teacher.find(session[:teacher_id]) if session[:teacher_id]
  end
end

