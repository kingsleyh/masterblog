atom_feed :language => 'en-US' do |feed|
  feed.title @title
  feed.updated @updated

  @articles.each do |item|
    next if item.updated_at.blank?

    feed.entry( item ) do |entry|
      entry.url article_url(item)
      entry.title item.title
      entry.content item.display_content, :type => 'html'

      # the strftime is needed to work with Google Reader.
      entry.updated(item.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ"))

      entry.author do |author|
        author.name entry.author
      end
    end
  end
end