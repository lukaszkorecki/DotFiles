tell application "System Events" to set adiumisrunning to (name of processes) contains "Adium"
if adiumisrunning then
  tell application "Adium"
    set tabs to count of chats
    set unreads to 0
    repeat with loopi from 1 to tabs
      set unreads to unreads + (unread message count of chat loopi)
    end repeat
    return "Adium Unread: " & unreads
  end tell
else
  return "Adium is off"
end if
