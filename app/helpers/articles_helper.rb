module ArticlesHelper
  def article_images(article)
    return [] unless article.content.present?
    article.content.body.attachables.select { |a| a.respond_to?(:image?) && a.image? }
  end

  def article_excerpt(article, length: 200)
    return "" unless article.content.present?

    fragment = Nokogiri::HTML::DocumentFragment.parse(article.content.body.to_html)
    fragment.css("action-text-attachment, figure").remove

    text = fragment.text
    text = text.gsub(/#\S+/, "")
    text.squish.truncate(length)
  end
end
