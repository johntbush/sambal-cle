#================
# Chat Room Pages
#================

#
class ChatRoom < BasePage

  frame_element

  value(:total_messages_shown) { |b| b.frame(:class=>"wcwmenu").div(:id=>"chat2_messages_shown_total").text }

  link "Options"

end

class ManageRooms < BasePage

  frame_element

  link "Add Room"

end