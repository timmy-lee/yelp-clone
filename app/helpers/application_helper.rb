module ApplicationHelper
  def time_options
    hours = (1..11).to_a.unshift(12)
    minutes = (0..55).to_a.select do |min|
      min % 5 == 0
    end

    minutes = minutes.map { |min| '%02d' % min }

    options = ["Closed"]
    hours.each do |hr|
      minutes.each do |min|
        options.push("#{hr}:#{min} AM")
      end
    end

    hours.each do |hr|
      minutes.each do |min|
        options.push("#{hr}:#{min} PM")
      end
    end

    options
  end

  def days_of_week
    ['sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday']
  end

  def format_hours(object, day)
    opening_time = object["#{day}_hr"]
    closing_time = object["#{day}_closing_hr"]
    if opening_time == 'Closed' || closing_time == 'Closed'
      'Closed'
    else
      opening_time + ' - ' + closing_time
    end
  end

  def rating_options
    [ ["1 - Bad", 1], ["2 - Meh", 2], ["3 - Decent", 3], ["4 - Good", 4], ["5 - Excellent!", 5] ]
  end

  def pricing_options
    [["$ - <$10", "$"], ["$$ - $11-$30", "$$"], ["$$$ - $31-60", "$$$"], ["$$$$ - >$61", "$$$$"]]
  end

  def pluralize_reviews(count)
    count.to_s + (count == 1 ? ' review' : ' reviews')
  end

  def stars_class_name(num)
    avg = round_to_half_of_whole(num)
    format_num_to_class(avg)
  end

  def format_paragraphs(text)
    paragraphs = text.split(/\n/)

    paragraphs
  end

  def format_time(date)
    year = date.year
    month = date.month
    day = date.day
    "#{month}/#{day}/#{year}"
  end

  private

  def round_to_half_of_whole(num)
    ((num * 2).round.to_f / 2).round(1)
  end

  def format_num_to_class(num)
    digits_string = num.to_s.split('.')
    if digits_string.last == '5'
      "#{digits_string.first}half"
    else
      digits_string.first
    end
  end
end
