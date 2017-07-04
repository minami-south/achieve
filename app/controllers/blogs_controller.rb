class BlogsController < ApplicationController
  before_action :set_blog, only: [:edit, :update, :destroy]
  
  def index
    @blogs = Blog.all
  end

  def new
    if params[:back]
    @blog = Blog.new(blogs_params)
    else
    @blog = Blog.new
    end
  end

  def create
    @blog = Blog.new(blogs_params)
    if @blog.save
    #保存成功⇒indexに移動＋noticeを表示
    redirect_to blogs_path, notice: "ブログを作成しました！"
    else
    #newを再レンダリング
    render 'new'
    end
  end

  def edit
  end

  def update
    if @blog.update(blogs_params)
    #保存成功⇒indexに移動＋noticeを表示
    redirect_to blogs_path, notice: "ブログを編集しました！"
    else
    #editを再レンダリング
    render 'edit'
    end
  end
  
  def destroy
    @blog.destroy
    redirect_to blogs_path, notice: "ブログを削除しました！"
  end
  
  def confirm
    @blog = Blog.new(blogs_params)
    #バリデーションが失敗したら実行
    render :new if @blog.invalid? 
  end
  
  private
    def blogs_params
      params.require(:blog).permit(:title, :content)
    end
    def set_blog
      @blog = Blog.find(params[:id])
    end
    
end