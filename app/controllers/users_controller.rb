class UsersController < ApplicationController
  def index
    # @users = User.where('name LIKE(?)', "%#{params[:keyword]}%").where.not(id: params[:user_ids]).limit(20)
    @users = User.where('name LIKE(?)', "%#{params[:keyword]}%")
    respond_to do |format|
      format.html
      format.json{ render 'index', json: @users }
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path, notice: "変更が完了しました"
    else
      render :edit
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email)
    end
end
