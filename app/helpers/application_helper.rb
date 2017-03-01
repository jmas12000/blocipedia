module ApplicationHelper
  def markdown(wikitext)
    renderOptions = {hard_wrap: true, filter_html: true}
    markdownOptions = {autolink: true, no_intra_emphasis: true, highlight: true, strikethrough: true, superscript: true}
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(renderOptions), markdownOptions)
    markdown.render(wikitext).html_safe
  end
end
