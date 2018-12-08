include("glicence/config/config.lua")

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

      return

    end

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

-- Console Print
local function conprint(msg)

  MsgC(Color(200, 200, 200), "[")
  MsgC(Color(255, 150, 150), "GLicence")
  MsgC(Color(200, 200, 200), "] ")
  MsgC(Color(200, 200, 200), msg)
  MsgC(Color(200, 200, 200), "\n")

end

// Version Check
local RanCheck = false

hook.Add("PlayerConnect", "glicence_checkversion", function()

  if(RanCheck == true) then return end

  conprint("Running version check!")

  // Post request.
  http.Post("https://livacoweb.000webhostapp.com/libaries/versions/glicence.php", {RunningVar = "1.2"}, function(result)

    conprint(result)

  end, function(fail)

    conprint("Error: " .. fail)
    conprint("This is most likely due to my website being down. Try again later.")

  end)

  RanCheck = true

end)