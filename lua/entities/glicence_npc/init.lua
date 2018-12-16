AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
include("glicence/config/config.lua")
include("glicence/config/lang.lua")

function ENT:Initialize()
	self:SetModel(GLicence.Config.Model)
	self:SetHullType(HULL_HUMAN)
	self:SetHullSizeNormal()
	self:SetNPCState(NPC_STATE_SCRIPT)
	self:SetSolid(SOLID_BBOX)
	self:CapabilitiesAdd(CAP_ANIMATEDFACE)
	self:SetUseType(SIMPLE_USE)
	self:DropToFloor()
	self:SetTrigger(true)
end

function ENT:AcceptInput(name, activator, caller)
	for k,v in pairs(GLicence.Config.BlockedGroups) do
		if(caller:GetUserGroup() == v) then
			net.Start("glicence_message")
			net.WriteString(GLicence.Lang.NoAccess)
			net.Send(caller)
			if(GLicence.Config.LogNoAccess == true) then
				if GLicence.blogs then
				  GLicence.blogs:Log(bLogs:FormatPlayer(caller) .. " tryed to access the NPC while in a blacklisted group.")
				end
			end
			return
		end
	end
	if(self:GetCooldown() > CurTime()) then
		net.Start("glicence_message")
		net.WriteString(GLicence.Lang.NPCCooldown)
		net.Send(caller)
		if(GLicence.Config.LogCooldown == true) then
			if GLicence.blogs then
				GLicence.blogs:Log(bLogs:FormatPlayer(caller) .. " tryed to access the NPC while on cooldown.")
			end
		end
		return
	end
	self:SetCooldown(GLicence.Config.Cooldown + CurTime())
	net.Start("glicence_openderma_user")
	net.Send(caller)
end
