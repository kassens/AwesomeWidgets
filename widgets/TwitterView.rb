framework 'foundation'

class TwitterView < NSView
  WIDTH = 250
  PADDING = 10
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
    from = "darthapo"
    body = "Project idea: A meta-language that would 'compile' to any of multiple frameworks (Prototype, Mootools, RightJS, etc)"
    str = "#{from}: #{body}"
    attr_str = NSMutableAttributedString.alloc.initWithString(str, attributes:{
      NSForegroundColorAttributeName => NSColor.whiteColor,
      NSFontAttributeName => NSFont.fontWithName("LucidaGrande", size: 10)
    })
    attr_str.beginEditing
    attr_str.addAttribute(NSFontAttributeName, value: NSFont.fontWithName("LucidaGrande-Bold", size: 10), range:[0, from.length + 1])
    attr_str.endEditing
    # attr_str = NSAttributedString.alloc.initWithHTML(str.dataUsingEncoding(NSUTF8StringEncoding), documentAttributes:nil)
    
    bbox = attr_str.boundingRectWithSize([WIDTH - 2 * PADDING, 0], options:NSStringDrawingUsesLineFragmentOrigin)
    self.frame = [0, 0, WIDTH, bbox.size.height + 2 * PADDING]
    
    if DEBUG
      NSColor.blackColor.colorWithAlphaComponent(0.2).set
      NSRectFill(bounds)
    end
    
    shadow = NSShadow.alloc.init
    shadow.shadowOffset = NSMakeSize(5.0, -5.0)
    shadow.shadowBlurRadius = 3.0
    shadow.shadowColor = NSColor.blackColor.colorWithAlphaComponent(0.3)
    shadow.set
    
    attr_str.drawWithRect([PADDING, PADDING, WIDTH - 2 * PADDING, bbox.size.height], options:NSStringDrawingUsesLineFragmentOrigin);
    
    puts 'done'
  end
  
  def mouseUp(event)
    return unless event.clickCount == 1
    puts 'click'
  end
end
