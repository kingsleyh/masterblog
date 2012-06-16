class FeedsController < ApplicationController

  def articles
    @title = "Articles"
    @articles = Article.order("updated_at desc")
    @updated = @articles.first.updated_at unless @articles.empty?

    respond_to do |format|
      format.atom { render :layout => false}
      format.rss { render :layout => false}
    end
  end



end
