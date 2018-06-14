module Admin
  class StudentsController < ApplicationController
    before_action :set_student, only: [:edit, :show, :update, :destroy]
 
    def index
      @students = Student.all
    end

    def new
      @student = Student.new
    end

    def edit
    end

    def show
    end

    def create
      @student = Student.create(student_params)
      if @student.save
        redirect_to admin_students_path
      else
        render 'new'
      end
    end

    def update
      if @student.update(student_params)
        redirect_to admin_students_path
      else
        render 'edit'
      end
    end

    def destroy
      @student.destroy
      redirect_to admin_students_path
    end

    private

    def student_params
      params.require(:student).permit(:name, :result, :mother_existance, :parent_income)
    end

    def set_student
      @student = Student.find(params[:id])
    end
  end
end
