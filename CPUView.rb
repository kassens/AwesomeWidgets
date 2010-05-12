class CPUView < NSView
  WIDTH = 150
  HEIGHT = 30
  PADDING = 10
  
  DATA_POINTS = 60
  
  def initWithFrame(frame)
    super
    @data = []
    data = @data
    Thread.new do
      loop do
        m = `sar 1`.match /^\d\d:\d\d:\d\d +(\d+) +(\d+) +(\d+) +\d+$/
        usr, nice, sys = m[1].to_i, m[2].to_i, m[3].to_i
        data << (usr + nice + sys) / 100.0
        data.shift if data.length > DATA_POINTS
        self.needsDisplay = true
      end
    end
    self
  end

  def drawRect(rect)
    if DEBUG
      NSColor.blackColor.colorWithAlphaComponent(0.2).set
      NSRectFill(bounds)
    end

    NSColor.whiteColor.colorWithAlphaComponent(0.2).set
    path = NSBezierPath.bezierPath
    path.moveToPoint NSMakePoint(PADDING + 0.5, PADDING + HEIGHT + 0.5)
    path.lineToPoint NSMakePoint(PADDING + 0.5, PADDING + 0.5)
    path.lineToPoint NSMakePoint(PADDING + WIDTH + 0.5, PADDING + 0.5)
    path.stroke
    
    shadow = NSShadow.alloc.init
    shadow.shadowOffset = NSMakeSize(5.0, -5.0)
    shadow.shadowBlurRadius = 3.0
    shadow.shadowColor = NSColor.blackColor.colorWithAlphaComponent(0.2)
    shadow.set
    
    return if @data.length < 1
    
    NSColor.whiteColor.set
    path = NSBezierPath.bezierPath
    path.lineJoinStyle = NSRoundLineJoinStyle
    path.lineCapStyle = NSRoundLineCapStyle
    path.lineWidth = 3
    
    value = @data.first
    path.moveToPoint NSMakePoint(PADDING, value * HEIGHT + PADDING)
    for i in 1...@data.length
      value = @data[i]
      path.lineToPoint NSMakePoint(WIDTH * i / (DATA_POINTS - 1) + PADDING, value * HEIGHT + PADDING)
    end
    path.stroke
    
    str = "CPU #{(value * 100).round}%"
    str.drawAtPoint(NSPoint.new(WIDTH + 2 * PADDING, HEIGHT / 2 - 10), withAttributes:{
      NSForegroundColorAttributeName => NSColor.whiteColor,
      NSFontAttributeName => NSFont.fontWithName("Futura", size: 24)
    })
  end
end
