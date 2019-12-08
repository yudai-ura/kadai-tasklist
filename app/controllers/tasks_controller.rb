class TasksController < ApplicationController
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user_logged_in, only: [:show, :new, :create, :edit, :update, :destroy]
  
  def index
    if logged_in?
      @task = current_user.tasks.build  # form_with 用
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
    end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = "タスクが保存されました"
      redirect_to @task
    else
      flash[:danger] = "タスクが保存されませんでした"
      render :new
    end
  end

  def edit
  end

  def update

    if @task.update(task_params)
      flash[:success] = 'タスクは正常に更新されました'
      redirect_to root_url
    else
      flash.now[:danger] = 'タスクは更新されませんでした'
      render :edit
    end
  end

  def destroy
    @task.destroy
    flash[:success] = "タスクは削除されました"
    redirect_to root_url
  end


  private
  
  
  def task_params
    params.require(:task).permit(:content, :status)
  end

  


  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to login_url
    end
  end
  
  
  

end