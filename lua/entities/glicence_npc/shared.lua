ENT.Type = "ai"
ENT.Base = "base_ai"
ENT.PrintName = "Licence Dealer"
ENT.Category = "GLicence"
ENT.Spawnable = true
ENT.AutomaticFrameAdvance = true

function ENT:SetupDataTables()

  self:NetworkVar("Int", 1, "Cooldown")

end
