#!/usr/bin/env macruby
framework 'appkit'

class NotificationListener
  
  def self.registered_listeners
    @registered_listeners ||= []
  end
  
  def initialize
    NotificationListener.registered_listeners << self
    NSNotificationCenter.defaultCenter.addObserver self,
      selector:'receive:',
      name:NSApplicationDidChangeScreenParametersNotification,
      object:NSApp
  end
  
  def receive(notification)
    p notification.description
  end
  
end

NotificationListener.new

NSApp.run
