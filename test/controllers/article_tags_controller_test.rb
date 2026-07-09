require "test_helper"

class ArticleTagsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article_tag = article_tags(:one)
  end

  test "should get index" do
    get article_tags_url
    assert_response :success
  end

  test "should get new" do
    get new_article_tag_url
    assert_response :success
  end

  test "should create article_tag" do
    assert_difference("ArticleTag.count") do
      post article_tags_url, params: { article_tag: { article_id: @article_tag.article_id, tag_id: @article_tag.tag_id } }
    end

    assert_redirected_to article_tag_url(ArticleTag.last)
  end

  test "should show article_tag" do
    get article_tag_url(@article_tag)
    assert_response :success
  end

  test "should get edit" do
    get edit_article_tag_url(@article_tag)
    assert_response :success
  end

  test "should update article_tag" do
    patch article_tag_url(@article_tag), params: { article_tag: { article_id: @article_tag.article_id, tag_id: @article_tag.tag_id } }
    assert_redirected_to article_tag_url(@article_tag)
  end

  test "should destroy article_tag" do
    assert_difference("ArticleTag.count", -1) do
      delete article_tag_url(@article_tag)
    end

    assert_redirected_to article_tags_url
  end
end
