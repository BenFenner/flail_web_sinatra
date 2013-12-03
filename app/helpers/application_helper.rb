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
