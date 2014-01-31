def active?(tag = nil)
  if tag.nil?
    if params[:tagged].nil?
      'active'
    else
      ''
    end
  elsif params[:tagged].present? && params[:tagged].include?(tag)
    'active'
  else
    ''
  end
end

def human_formatted_hash(input = {})
  output = ""
  input.each do |key, value|
    output += "#{Rack::Utils.escape_html(key)}: #{Rack::Utils.escape_html(value)}<br><br>"
  end
  output
end
