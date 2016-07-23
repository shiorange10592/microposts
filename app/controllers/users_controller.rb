class UsersController < ApplicationController
  
  before_action :logon_check, only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user

    else
      render 'new'
    end
  end
  

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    
    @user = User.find(params[:id])
    puts '----------------------------'
    puts @user.update(user_params)
    puts '-------------------------------'
    puts user_params
    
    if @user.update(user_params)
      # 保存に成功し  た場合はトップページへリダイレクト
      #  redirect_to user_path(current_user.id) , notice: 'ユーザ情報を更新しました'
    
      flash[:success] = "ユーザ情報を更新しました"
      redirect_to @user
    
    else  
        # 保存に失敗した場合は編集画面へ戻す
        render 'edit'
    end
    
    
  end


  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                  :password_confirmation, :region)
  end
  
  def logon_check
    
    #unless logged_in?
    #  redirect_to root_path
    
    @user = User.find(params[:id])
    redirect_to root_path if @user != current_user
   
    
  end
  
end