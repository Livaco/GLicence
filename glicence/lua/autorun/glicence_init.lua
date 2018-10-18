-- Just to save me time
local function conprint(msg)

  MsgC(Color(200, 200, 200), "[")
  MsgC(Color(255, 150, 150), "GLicence")
  MsgC(Color(200, 200, 200), "] ")
  MsgC(Color(200, 200, 200), msg)
  MsgC(Color(200, 200, 200), "\n")

end

GLicence = {}
GLicence.Config = GLicence.Config or {}
GLicence.Lang = GLicence.Lang or {}

// Shared files. Not printed in console.
AddCSLuaFile("glicence/config/lang.lua")
AddCSLuaFile("glicence/config/config.lua")

if SERVER then

  conprint("Loading serverside...")

  include("glicence/core/sv_blogs.lua")
  include("glicence/core/sv_netmessages.lua")
  include("glicence/core/sv_main.lua")

  AddCSLuaFile("glicence/core/cl_main.lua")
  AddCSLuaFile("glicence/core/vgui/cl_vgui.lua")
  AddCSLuaFile("glicence/core/vgui/cl_fonts.lua")

  conprint("Loaded serverside.")

else

  conprint("Loading clientside...")

  include("glicence/core/cl_main.lua")
  include("glicence/core/vgui/cl_vgui.lua")

  conprint("Loaded clientside.")

end
