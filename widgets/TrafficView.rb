require 'net/http'

class TrafficView < WidgetView
  UPDATE_INTERVAL = 60
  
  def update
    content = Net::HTTP.get 'bigbrother.hrz.tu-darmstadt.de', '/acct/index.php?ScriptTyp=MainFrame'
    matches = content.scan(/[0-9\.]* (?:GB|MB)/)
    if matches.length == 4
      total, incoming, outgoing, quota = matches
      @data = "#{total} of #{quota.gsub /\.0/, ''} used."
    else
      @data = nil
    end
  end
  
  def drawRect(rect)
    super
    return unless @data
    set_shadow
    @data.drawAtPoint([10, 10], withAttributes:normalFontAttributes)
  end
end
