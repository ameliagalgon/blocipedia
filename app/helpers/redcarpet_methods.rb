module RedcarpetMethods
  renderer = Redcarpet::Render::HTML.new(hard_wrap: true)
  @markdown = Redcarpet::Markdown.new(renderer)

  def display
    @markdown.render( @wiki.body ).html_safe
  end
end
