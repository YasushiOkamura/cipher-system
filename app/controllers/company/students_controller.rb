module Company
  class StudentsController < ApplicationController
    def index
    end

    def result
      #@results = {mother_existance: { result_sum: 50, number_sum: 3 } }
      @results = CipherResult.new.execute
    end
  end
end
