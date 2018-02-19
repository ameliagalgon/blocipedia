module RedcarpetMethods

  def display(wiki)
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true)
    markdown = Redcarpet::Markdown.new(renderer)
    markdown.render( wiki.body ).html_safe
  end
end
