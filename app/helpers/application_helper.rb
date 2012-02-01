module ApplicationHelper
  def title(title_str)
    content_for :title do
      title_str
    end
  end
end
