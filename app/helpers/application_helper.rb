module ApplicationHelper
  def article_excerpt(article, length: 200)
    return "" unless article.content.present?

    fragment = Nokogiri::HTML::DocumentFragment.parse(article.content.body.to_html)
    fragment.css("action-text-attachment, figure").remove

    text = fragment.text
    text = text.gsub(/#\S+/, "")   # delete hashtags from text
    text.squish.truncate(length)
  end
end
