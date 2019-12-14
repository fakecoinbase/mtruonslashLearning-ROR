class ArticlesController < ApplicationController
  # Hierarchy: index, show, new, edit, create, update, and destroy
  
  def index
    @articles = Article.all
  end


  def show
    @article = Article.find(params[:id])
  end

  def new
  end

  def create
    @article = Article.new(article_params)
    
    @article.save
    redirect_to @article
  end

  private
    def article_params
      # :article is a symbol -- being the identifying scope
      # The fields are parameters which are referencable in
      # the controller. params[:article] is the data we receive
      # which would represent our model instance.
      params.require(:article).permit(:title, :text)
    end
end
