class StudentsController < ApplicationController
  def new
    @student = Student.new
  end
  
  def create
    @student = Student.create(student_params)
    if @student.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

  def student_params
    params.require(:student).permit(:name, :result, :mother_existance, :parent_income)
  end
end
