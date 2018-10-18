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

  ply:addMoney(ply:getDarkRPVar("money") - GLicence.Config.Cost)
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
