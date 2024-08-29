class Guides::InDepth::PostInfo < Bridgetown::Component
  def initialize(authors:, last_update:)
    @authors = Array(authors)
    @last_update = last_update
  end

  def is_guest?(author)
    author_data(author).is_a?(String)
  end

  def author_name(author)
    is_guest?(author) ? author : author_data(author).name
  end

  def github_link(author)
    author_data(author).github.presence
  end

  def author_data(author)
    Bridgetown::Current.site.data.authors[author] || author
  end

  def author_list
    @authors.map {|author|
      "#{author_name(author)} #{author_link(author)}"
    }.join(", ")
  end

  def author_link(author)
    if !is_guest?(author) && github_link(author).present?
      link_to github_link(author), "aria-label": "Go to GitHub" do
        svg "images/icons/github.svg"
      end
    end
  end
end
