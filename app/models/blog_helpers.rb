module BlogHelpers

  def get_snippet(snippet_name)
    ERB.new(Snippet.find_by_name(snippet_name).content).result(binding)
  end

  def section_slug(section_name)
      Section.find_by_name(section_name).slug
    end

    def tags_with_links(article, section)
      tags = article.tags
      tags.empty? ? "Home" : tags.split(",").collect { |tag| '<a href="' + section_article_path(section_slug(section), tag.strip) + '">' + tag.strip + '</a>' }.join(",")
    end

    def author_with_links(article, section)
      '<a href="' + section_article_path(section_slug(section), article.user.slug) + '">' + article.author + '</a>'
    end

    def captcha
      '<div id="captchator-image"><img src="http://captchator.com/captcha/image/' + $captcha_key + '" /></div>'
    end

    def paginate(model)
      current = model.current_page

      prev = '<a href="?page=' + (current-1).to_s + '">prev</a>'
      prev_s = '<a href="?page=' + (current-2).to_s + '">' + (current-2).to_s + '</a>'
      prev_n = '<a href="?page=' + (current-1).to_s + '">' + (current-1).to_s + '</a>'
      nxt_n = '<a href="?page=' + (current+1).to_s + '">' + (current+1).to_s + '</a>'
      nxt_s = '<a href="?page=' + (current+2).to_s + '">' + (current+2).to_s + '</a>'
      nxt = '<a href="?page=' + (current+1).to_s + '">next</a>'

      pages = ['<div>']
      pages << prev if current > 1
      pages << prev_s if current > 2
      pages << prev_n if current > 1
      pages << '<span class="current">' + current.to_s + '</span>'
      pages << nxt_n if current < model.num_pages
      pages << nxt_s if current+2 <= model.num_pages
      pages << nxt if current < model.num_pages
      pages << "</div></div>"
      pages.join("")
    end

    def pages(model)
      "Page #{model.current_page} of #{model.num_pages}"
    end

end