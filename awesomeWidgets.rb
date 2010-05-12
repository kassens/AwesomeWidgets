#!/usr/bin/env macruby
framework 'appkit'
BASE_PATH = File.dirname(__FILE__)

DEBUG = false

class MainView < NSView
  def drawRect(rect)
    NSColor.clearColor.set
    NSRectFill(bounds)
    if DEBUG
      NSColor.blackColor.colorWithAlphaComponent(0.1).set
      NSRectFill(bounds)
    end
  end
end

frame = [80, 80, 450, 250]

# screenFrame = NSScreen.mainScreen.frame
# origin = NSPoint.new(80, screenFrame.origin.y + screenFrame.size.height - 300) # "top left"-ish

window = NSWindow.alloc.initWithContentRect(frame, styleMask:NSBorderlessWindowMask, backing:NSBackingStoreBuffered, defer:false)

window.level = CGWindowLevelForKey(KCGDesktopIconWindowLevelKey)
window.opaque = false

mainView = MainView.alloc.initWithFrame(frame)
window.contentView = mainView

require File.join(BASE_PATH, 'CPUView.rb')
cpuView = CPUView.alloc.initWithFrame([0, 0, 300, 100])
mainView.addSubview(cpuView)

require File.join(BASE_PATH, 'CalendarView.rb')
calendarView = CalendarView.alloc.initWithFrame([0, 110, 300, 100])
mainView.addSubview(calendarView)

window.makeKeyAndOrderFront(nil) # Show the window

NSApp.run
