include("glicence/config/config.lua")

function GLicence.Message(message)

  chat.AddText(Color(255, 255, 255, 255), "[", GLicence.Config.PrefixColor, GLicence.Config.Prefix, Color(255, 255, 255, 255), "] ", message)

end

net.Receive("glicence_message", function()

  local msg = net.ReadString()
  GLicence.Message(msg)

end)
