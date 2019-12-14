class ArticlesController < ApplicationController
  # Hierarchy: index, show, new, edit, create, update, and destroy
  
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)
    
    # Validating that article.save return results
    # Returns false if the it doesnt meet model requirements
    if @article.save
      redirect_to @article
    else
      # @article object is passed back to the new template
      # Since the article failed validation (lossless error)
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  private
    def article_params
      # :article is a symbol -- being the identifying scope
      # The fields are parameters which are referencable in
      # the controller. params[:article] is the data we receive
      # which would represent our model instance.
      # We requires that the article exists
      # and the title and text keys are permitted
      params.require(:article).permit(:title, :text)
    end
end
