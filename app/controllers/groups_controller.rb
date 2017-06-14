class GroupsController < ApplicationController
before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def show
    @group = Group.find(params[:id])
  end

  def edit
    @group = Group.find(params[:id])
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      @group.user = current_user
      redirect_to groups_path
    else
      render :new
    end
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      flash[:notice] = "更新成功"
      redirect_to groups_path
    else
      render :edit
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    flash[:alert] = "删除成功"
    redirect_to groups_path
  end

  def join
    @group = Group.find(params[:id])
    if !current_user.is_member_of?(@group)
      current_user.join!(@group)
      flash[:notice] = "加入讨论版成功"
    else
      flash[:warning] = "你已经是本讨论版成员了"
    end
  end

  def quit
    @group = Group.find(params[:id])
    if current_user.is_member_of?(@group)
      current_user.quit!(@group)
      flash[:alert] = "已退出讨论版"
    else
      flash[:warning] = "你不是讨论版成员怎么退出"
    end
  end

  private

  def group_params
    params.require(:group).permit(:title, :description)
  end

end
