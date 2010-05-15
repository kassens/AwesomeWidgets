framework 'calendarstore'

class CalendarView < WidgetView
  UPDATE_INTERVAL = 60
  
  def update
    now = NSDate.date.timeIntervalSinceReferenceDate
    @data = upcoming_events.map { |e|
      start = e.startDate.timeIntervalSinceReferenceDate
      if start > now
        "#{seconds_to_words(start - now)} until #{e.title}"
      else
        "#{seconds_to_words(now - start)} since #{e.title}"
      end
    }.join("\n")
  end
  
  def drawRect(rect)
    super
    return unless @data
    set_shadow
    @data.drawAtPoint([10, 10], withAttributes:normalFontAttributes)
  end
  
  def seconds_to_words(distance_in_secs)
    distance_in_mins = distance_in_secs / 60
    distance_in_hrs = distance_in_mins / 60
    
    if distance_in_secs < 60
      return "< 1 min"
    elsif distance_in_mins.round == 1
      return "1 min"
    elsif distance_in_mins.round < 60
      return "#{distance_in_mins.round} mins"
    elsif distance_in_hrs.round > 4
      return "#{distance_in_hrs.round} hrs"
    else
      return "#{distance_in_hrs.floor} hrs and #{distance_in_mins.floor % 60} mins"
    end
  end
  
  def upcoming_events
    startDate = NSDate.date
    endDate = startDate.dateByAddingTimeInterval(60*60*24) # in seconds = 24 hrs
    eventsForThisYear = CalCalendarStore.eventPredicateWithStartDate(startDate, endDate:endDate, calendars:CalCalendarStore.defaultCalendarStore.calendars)
    CalCalendarStore.defaultCalendarStore.eventsWithPredicate(eventsForThisYear)
  end
end
