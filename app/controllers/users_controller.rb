class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    #redirect_to root_path if !logged_in? || !is_admin?
    @users = User.where(admin: false).sort {|a,b| get_points(b) <=> get_points(a)}
  end

  # GET /users/1
  # GET /users/1.json
  def show
    redirect_to root_path if !(logged_in? && (is_admin? || current_user == @user))
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.name = @user.name.downcase
    @user.admin = false;
    respond_to do |format|
      if @user.save
        log_in @user
        remember @user
        flash[:success] = "Welcome to the BitProxima CodeJam"
        format.html { redirect_to root_path }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    redirect_to root_path if !logged_in? && !is_admin?
    respond_to do |format|
      if @user.update(user_params)
        flash[:success] = 'User was successfully updated.'
        format.html { redirect_to @user}
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    redirect_to root_path if !logged_in? || !is_admin?
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :tag)
    end

    def get_points(user)
      return Problem.where(id: Solution.where(user: user).where(validity: true).pluck(:problem_id)).sum(:points)
    end
end
