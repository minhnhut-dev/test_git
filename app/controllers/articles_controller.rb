class ArticlesController < ApplicationController
  def index
    if params[:title].blank?
      @articles = Article.all
    else
      @articles = Article.search_title(params[:title])
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(blog_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: "Micropost was successfully created." }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.update(blog_params)
    redirect_to root_path
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to root_path, status: :see_other
  end

  private

  def blog_params
    params.require(:article).permit(:title, :body, :description)
  end
end
