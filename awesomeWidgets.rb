#!/usr/bin/env macruby
framework 'appkit'

BASE_PATH = File.dirname(__FILE__)

require File.join(BASE_PATH, 'WidgetView.rb')

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

class Application
  # screenFrame = NSScreen.mainScreen.frame
  # origin = NSPoint.new(80, screenFrame.origin.y + screenFrame.size.height - 300) # "top left"-ish
  FRAME = [80, 80, 450, 450]

  def initialize
    create_window
    
    @mainView = MainView.alloc.initWithFrame(FRAME)
    @window.contentView = @mainView
    
    load_plugin('CPUView', [0, 0, 300, 100])
    load_plugin('CalendarView', [0, 110, 300, 100])
    load_plugin('TrafficView', [0, 220, 400, 40])
    # load_plugin('TwitterView', [0, 220, 400, 100])
    
    @window.makeKeyAndOrderFront(nil) # Show the window
    listen_to_screen_change
  end
  
  def create_window
    @window = NSWindow.alloc.initWithContentRect(FRAME,
        styleMask:NSBorderlessWindowMask,
        backing:NSBackingStoreBuffered,
        defer:false)
    @window.level = CGWindowLevelForKey(KCGDesktopIconWindowLevelKey)
    @window.opaque = false
  end
  
  def load_plugin(name, frame)
    require File.join(BASE_PATH, 'widgets', name + '.rb')
    view = Kernel.const_get(name).alloc.initWithFrame(frame)
    @mainView.addSubview(view)
  end
  
  def listen_to_screen_change
    NSNotificationCenter.defaultCenter.addObserver self,
      selector:'did_change_screen_parameters:',
      name:NSApplicationDidChangeScreenParametersNotification,
      object:NSApp
  end
  
  def did_change_screen_parameters(notification)
    @window.frameOrigin = [80,80]
  end
  
  def run
    NSApp.run
  end
  
end

Application.new.run
