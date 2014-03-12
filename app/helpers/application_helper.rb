module ApplicationHelper
  def markdown(content)
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, space_after_headers: true, fenced_code_blocks: true, filter_html: true, no_styles: true)
    @markdown.render(content)
  end

  def vimeo_summary_cleanup(summary)
    index = summary.index('Cast: ')
    return summary if index.nil?
    return summary[0, index]
  end
end