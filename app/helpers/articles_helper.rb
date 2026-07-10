module ArticlesHelper
  def article_images(article)
    return [] unless article.content.present?
    article.content.body.attachables.select { |a| a.respond_to?(:image?) && a.image? }
  end
end
