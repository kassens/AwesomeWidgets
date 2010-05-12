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

# # resolution change with external
# NSConcreteNotification {name = O3DeviceChanged; object = o3dv*04272300}
# NSConcreteNotification {name = O3DeviceTimingChanged; object = o3dv*04272300}
# NSConcreteNotification {name = O3DeviceChanged; object = o3dv*2CC1EB41}
# NSConcreteNotification {name = O3DeviceTimingChanged; object = o3dv*2CC1EB41}
# NSConcreteNotification {name = O3EngineChanged; object = brte*04272300; userInfo = {
#     DisplayID = 69673728;
#     EngineType = 1651668069;
# }}
# 
# # detatch external
# NSConcreteNotification {name =  com.apple.BezelServices.BMDisplayHWReconfiguredEvent; userInfo = {
#     sid = 501;
# }}
# NSConcreteNotification {name = O3DeviceChanged; object = o3dv*04272300}
# NSConcreteNotification {name = O3DeviceTimingChanged; object = o3dv*04272300}
# NSConcreteNotification {name = O3DeviceChanged; object = o3dv*2CC1EB41}
# NSConcreteNotification {name = O3DeviceTimingChanged; object = o3dv*2CC1EB41}
# NSConcreteNotification {name = O3EngineChanged; object = brte*04272300; userInfo = {
#     DisplayID = 69673728;
#     EngineType = 1651668069;
# }}
# 
# # attach external
# NSConcreteNotification {name =  com.apple.BezelServices.BMDisplayHWReconfiguredEvent; userInfo = {
#     sid = 501;
# }}
# NSConcreteNotification {name = O3DeviceChanged; object = o3dv*04272300}
# NSConcreteNotification {name = O3DeviceTimingChanged; object = o3dv*04272300}
# NSConcreteNotification {name = O3EngineChanged; object = brte*04272300; userInfo = {
#     DisplayID = 69673728;
#     EngineType = 1651668069;
# }}


# NSScreenColorSpaceDidChangeNotification
