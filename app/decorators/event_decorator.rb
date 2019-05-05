module EventDecorator
  def define_gen
    case start_date.strftime("%H:%M")
    when "08:50" then
      "1限"
    when "10:30" then
      "2限"
    when "12:00" then
      "2'限"
    when "13:00" then
      "3限"
    when "14:40" then
      "4限"
    when "16:20" then
      "5限"
    when "18:00" then
      "6限"
    when "19:40" then
      "7限"
    when "21:10" then
      "7'限"
    end
  end

  def get_date
    start_date.strftime("%Y年%m月%d日")
  end
end
