include("glicence/config/config.lua")

hook.Add("bLogs_FullyLoaded", "glicence_loadblogs", function()
  GLicence.blogs = bLogs:Module()
  GLicence.blogs.Category = "Livaco's Scripts"
  GLicence.blogs.Name     = "GLicence"
  GLicence.blogs.Colour   = Color(120, 120, 120, 255)

  bLogs:AddModule(GLicence.blogs)
end)

// All the net messages
util.AddNetworkString("glicence_message")
util.AddNetworkString("glicence_openderma_user")
util.AddNetworkString("glicence_buy")

net.Receive("glicence_buy", function(len, ply)
  for k,v in pairs(GLicence.Config.BlockedGroups) do
		if(ply:GetUserGroup() == v) then
			net.Start("glicence_message")
			net.WriteString(GLicence.Lang.NoAccess)
			net.Send(ply)
			if(GLicence.Config.LogNoAccess == true) then
				if GLicence.blogs then
				  GLicence.blogs:Log(bLogs:FormatPlayer(ply) .. " tryed to buy from the NPC while in a blacklisted group.")
				end
			end
			return
		end
	end

  if(GLicence.Config.CheckForLicence == true) then
    if(ply:getDarkRPVar("HasGunlicense") == true) then
      net.Start("glicence_message")
      net.WriteString(GLicence.Lang.AlreadyHasLicence)
      net.Send(ply)
      if(GLicence.Config.LogAlreadyHas == true) then
        if GLicence.blogs then
          GLicence.blogs:Log(bLogs:FormatPlayer(ply) .. " tryed to buy a gun licence but already had one!")
        end
      end
      return
    end
  end

  if(ply:getDarkRPVar("money") < GLicence.Config.Cost) then
    net.Start("glicence_message")
    net.WriteString(GLicence.Lang.CantAffordLicence)
    net.Send(ply)
    if(GLicence.Config.LogAlreadyHas == true) then
      if GLicence.blogs then
        GLicence.blogs:Log(bLogs:FormatPlayer(ply) .. " tryed to buy a gun licence but can't afford it!")
      end
    end
    return
  end
  ply:addMoney(GLicence.Config.Cost - (GLicence.Config.Cost * 2))
  ply:setDarkRPVar("HasGunlicense", true)

  net.Start("glicence_message")
  net.WriteString(string.format(GLicence.Lang.BuySuccessful, GLicence.Config.Cost))
  net.Send(ply)

  if(GLicence.Config.LogSucessfulBuy == true) then
    if GLicence.blogs then
      GLicence.blogs:Log(bLogs:FormatPlayer(ply) .. " bought a gun licence for " .. GLicence.Config.Cost)
    end
  end
end)

// Version Check
local RanCheck = false
hook.Add("PlayerConnect", "glicence_checkversion", function()
  if(RanCheck == true) then return end
  GLicence:Print("Running version check!")
  // Post request.
  http.Post("https://livacoweb.000webhostapp.com/libaries/versions/glicence.php", {RunningVar = "1.3"}, function(result)
    GLicence:Print(result)
  end, function(fail)
    GLicence:Print("Error: " .. fail)
    GLicence:Print("This is most likely due to my website being down. Try again later.")
  end)
  RanCheck = true
end)