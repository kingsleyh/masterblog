module ApplicationHelper

  def selected?(selection, kind)
    result = ""
    if selection.is_a?(Upload)

      if kind == :markdown
        result = selection.is_text_file? ? 'selected="selected"' : ""
      end

      if kind == :css
        result = selection.is_css_file? ? 'selected="selected"' : ""
      end

      if kind == :javascript
        result = selection.is_javascript_file? ? 'selected="selected"' : ""
      end

      if kind == :ruby
              result = selection.is_ruby_file? ? 'selected="selected"' : ""
      end

    elsif selection.is_a?(Section)

      if kind == :text_html
        result = 'selected="selected"'
      end

    elsif selection.is_a?(Systemfile)

      if kind == :markdown
        result = selection.is_text_file? ? 'selected="selected"' : ""
      end

      if kind == :css
        result = selection.is_css_file? ? 'selected="selected"' : ""
      end

      if kind == :javascript
        result = selection.is_javascript_file? ? 'selected="selected"' : ""
      end

      if kind == :ruby
              result = selection.is_ruby_file? ? 'selected="selected"' : ""
      end

    end
    result
  end

end
