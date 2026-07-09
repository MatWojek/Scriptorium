<% content_for :title, t("articles.index.title") %>

<div class="md:w-4/5 w-full mx-auto">
  <%= render "article_show", article: @article %>
</div>