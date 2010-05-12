framework 'calendarstore'

class CalendarView < NSView
  def initWithFrame(frame)
    super
    Thread.new do
      loop do
        self.needsDisplay = true
        sleep 60
      end
    end
    self
  end
  
  def drawRect(rect)
    if DEBUG
      NSColor.blackColor.colorWithAlphaComponent(0.2).set
      NSRectFill(bounds)
    end
    
    shadow = NSShadow.alloc.init
    shadow.shadowOffset = NSMakeSize(5.0, -5.0)
    shadow.shadowBlurRadius = 3.0
    shadow.shadowColor = NSColor.blackColor.colorWithAlphaComponent(0.3)
    shadow.set

    str = upcoming_events.map { |e| "#{time_until(e)} until #{e.title}" }.join("\n")
    str.drawAtPoint(NSPoint.new(10, 10), withAttributes:{
      NSForegroundColorAttributeName => NSColor.whiteColor,
      NSFontAttributeName => NSFont.fontWithName("Futura", size: 12)
    })
  end
  
  def time_until(event)
    a = NSDate.date.timeIntervalSinceReferenceDate
    b = event.startDate.timeIntervalSinceReferenceDate
    
    distance_in_secs = b - a
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
