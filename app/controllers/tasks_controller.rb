class TasksController < ApplicationController
    before_action :require_user_logged_in
    before_action :set_task, only: [:show, :edit, :update, :destroy]
    
    def index
      @task = current_user.tasks.find_by(id: params[:id])
      unless @task
      flash[:danger] = '再ログイン'
      redirect_to login_url
      end
    end 
    
    def show
      @task = current_user.tasks.find_by(id: params[:id])
      unless @task
        flash[:danger] = '再ログイン'
        redirect_to login_url
      end
    end 
    
    def new
        @task = current_user.tasks.new
    end 
    
    def create
      @task = current_user.tasks.build(task_params)
      if @task.save
        flash[:success] = 'タスクを投稿しました。'
        redirect_to root_url
      else
        @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
        flash.now[:danger] = 'タスクの投稿に失敗しました。'
        render :new
      end
    end
    
    def edit
      @task = current_user.tasks.find_by(id: params[:id])
      unless @task
        flash[:danger] = '再ログイン'
        redirect_to login_url
      end 
    end
    
    def update
        if @task.update(task_params)
            flash[:success] = 'タスクが編集されました'
            redirect_to @task
        else
            flash.now[:danger] = 'タスクが編集されませんでした'
            render :new
        end 
    end 
    
  def destroy
    @task.destroy
    flash[:success] = 'タスクを削除しました。'
    redirect_to root_url
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      flash[:danger] = '再ログイン'
      redirect_to login_url
    end
  end

private

def set_task
    @task = Task.find(params[:id])
end


def task_params
    params.require(:task).permit(:content, :status)
end 
    
end 