require 'test_solution'

class SolutionsController < ApplicationController
  before_action :set_solution, only: [:show, :edit, :update, :destroy]

  # GET /solutions
  # GET /solutions.json
  def index
    redirect_to problems_path if !(logged_in? && is_admin?)
    @solutions = Solution.all
  end

  # GET /solutions/1
  # GET /solutions/1.json
  def show
    redirect_to problems_path if !(logged_in? && (is_admin? || @solution.user == current_user))
  end

  # GET /solutions/new
  def new
    @solution = Solution.new
  end

  def make_tests
    @t1 = Test.new
    @t1.problem_id = 1
    @t1.input = []
    @t1.output = "Hello, World!\n"
    @t1.save
  
    @t2 = Test.new
    @t2.problem_id = 2
    @t2.input = ["1", "2"]
    @t2.output = "3\n"
    @t2.save
    
    @t3 = Test.new
    @t3.problem_id = 3
    @t3.input = ["5"]
    @t3.output = "120\n"
    @t3.save

    redirect_to root_path
  end

  # GET /solutions/1/edit
  def edit
  end

  # POST /solutions
  # POST /solutions.json
  def create
    @solution = Solution.new(solution_params)
    @solution.user = current_user
    @solution.validity = test_code(@solution)
    respond_to do |format|
      if @solution.save
        format.html { redirect_to @solution, notice: 'Solution was successfully created.' }
        format.json { render :show, status: :created, location: @solution }
      else
        format.html { render :new }
        format.json { render json: @solution.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /solutions/1
  # PATCH/PUT /solutions/1.json
  def update
    respond_to do |format|
      if @solution.update(solution_params)
        @solution.validity = test_code(@solution)
        @solution.save
        format.html { redirect_to @solution, notice: 'Solution was successfully updated.' }
        format.json { render :show, status: :ok, location: @solution }
      else
        format.html { render :edit }
        format.json { render json: @solution.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /solutions/1
  # DELETE /solutions/1.json
  def destroy
    @solution.destroy
    respond_to do |format|
      format.html { redirect_to solutions_url, notice: 'Solution was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_solution
      @solution = Solution.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def solution_params
      params.require(:solution).permit(:user_id, :problem_id, :language, :code, :validity)
    end

    def test_code(solution)
      tests = Test.where(problem: solution.problem)
      return true if tests.blank?
      i = 0
      tests.each do |test|
        `touch here1`
        inputs = test.input
        output = test.output
        i = i + 1 if !test_solution(inputs, output, solution)
      end
      if i > 0 
        return false
      else
        return true
      end
    end
end
