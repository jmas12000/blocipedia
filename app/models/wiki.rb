class Wiki < ActiveRecord::Base
  
  has_many :collaborations
  has_many :collaborators, through: :collaborations, source: :user #-> { distinct }
  belongs_to :user

  default_scope { order('created_at DESC') }
  scope :visible_to, -> (user) { user ? where(private: false) : 'There was an error.' }
  
  def markdown_title
    markdown_to_html(self.title)
  end

  def markdown_body
    markdown_to_html(self.body)
  end
  
  def public?
    !private?
  end
  
  def markdown_to_html(markdown)
    renderer = Redcarpet::Render::HTML.new
    extensions = {fenced_code_blocks: true, autolink: true, no_intra_emphasis: true, highlight: true, strikethrough: true, superscript: true}
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    (redcarpet.render markdown).html_safe
  end
  
end
