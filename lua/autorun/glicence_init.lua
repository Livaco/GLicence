GLicence = {}
GLicence.Config = GLicence.Config or {}
GLicence.Lang = GLicence.Lang or {}

function GLicence:Print(msg)
  MsgC(Color(200, 200, 200), "[")
  MsgC(Color(255, 150, 150), "GLicence")
  MsgC(Color(200, 200, 200), "] ")
  MsgC(Color(200, 200, 200), msg)
  MsgC(Color(200, 200, 200), "\n")
end

// Shared files. Not printed in console.
AddCSLuaFile("glicence/config/lang.lua")
AddCSLuaFile("glicence/config/config.lua")

if SERVER then
  GLicence:Print("Loading serverside...")

  include("glicence/core/sv_main.lua") GLicence:Print("sv_main.lua")

  AddCSLuaFile("glicence/core/cl_main.lua")

  GLicence:Print("Loaded serverside.")
else
  GLicence:Print("Loading clientside...")

  include("glicence/core/cl_main.lua") GLicence:Print("cl_main.lua")

  GLicence:Print("Loaded clientside.")
end
