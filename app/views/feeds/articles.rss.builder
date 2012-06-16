xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title Setting.get('rss_feed_title')
    xml.description Setting.get('rss_feed_description')
    xml.link root_url

    for article in @articles
      xml.item do
        xml.title article.title
        xml.description article.display_content
        xml.pubDate article.created_at.to_s(:rfc822)
      end
    end
  end
end