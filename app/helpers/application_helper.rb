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

def database_connected?
  ActiveRecord::Base.connection.active?
rescue ActiveRecord::ConnectionNotEstablished
  false
end

def distance_of_time_in_words(from_time, to_time = DateTime.now)

  from_time = from_time.to_time if from_time.respond_to?(:to_time)
  to_time = to_time.to_time if to_time.respond_to?(:to_time)
  from_time, to_time = to_time, from_time if from_time > to_time
  distance_in_minutes = ((to_time - from_time)/60.0).round

  text = nil

  case distance_in_minutes
    when 0                then text = "less than 1 minute ago"
    when 1                then text = "1 minute ago"
    when 2...45           then text = "#{distance_in_minutes} minutes ago"
    when 45...90          then text = "about 1 hour ago"
    # 90 mins up to 24 hours
    when 90...1440        then text = "about #{(distance_in_minutes.to_f / 60.0).round} hours ago"
    # 24 hours up to 42 hours
    when 1440...2520      then text = "1 day ago"
    # 42 hours up to 30 days
    when 2520...43200     then text = "#{(distance_in_minutes.to_f / 1440.0).round} days ago"
    # 30 days up to 60 days
    when 43200...86400    then text = "about #{(distance_in_minutes.to_f / 43200.0).round} months ago"
    # 60 days up to 365 days
    when 86400...525600   then text = "#{(distance_in_minutes.to_f / 43200.0).round} months ago"
    else
      if from_time.acts_like?(:time) && to_time.acts_like?(:time)
        fyear = from_time.year
        fyear += 1 if from_time.month >= 3
        tyear = to_time.year
        tyear -= 1 if to_time.month < 3
        leap_years = (fyear > tyear) ? 0 : (fyear..tyear).count{|x| Date.leap?(x)}
        minute_offset_for_leap_year = leap_years * 1440
        # Discount the leap year days when calculating year distance.
        # e.g. if there are 20 leap year days between 2 dates having the same day
        # and month then the based on 365 days calculation
        # the distance in years will come out to over 80 years when in written
        # english it would read better as about 80 years.
        minutes_with_offset = distance_in_minutes - minute_offset_for_leap_year
      else
        minutes_with_offset = distance_in_minutes
      end
      remainder                   = (minutes_with_offset % 525600)
      distance_in_years           = (minutes_with_offset.div 525600)
      if remainder < 131400
        text = "about #{distance_in_years} years ago"
      elsif remainder < 394200
        text = "over #{distance_in_years} years ago"
      else
        text = "almost #{distance_in_years + 1} years ago"
      end
  end
end
