class WidgetView < NSView
  def initWithFrame(frame)
    super
    Thread.new do
      loop do
        update
        self.needsDisplay = true
        sleep UPDATE_INTERVAL
      end
    end
    self
  end
  
  def drawRect(rect)
    if DEBUG
      NSColor.blackColor.colorWithAlphaComponent(0.2).set
      NSRectFill(bounds)
    end
  end
  
  def set_shadow
    shadow = NSShadow.alloc.init
    shadow.shadowOffset = NSMakeSize(5.0, -5.0)
    shadow.shadowBlurRadius = 3.0
    shadow.shadowColor = NSColor.blackColor.colorWithAlphaComponent(0.3)
    shadow.set
  end
  
  def normalFontAttributes
    {
      NSForegroundColorAttributeName => NSColor.whiteColor,
      NSFontAttributeName => NSFont.fontWithName("Futura", size: 12)
    }
  end
end
