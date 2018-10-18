include("shared.lua")
include("glicence/config/lang.lua")

surface.CreateFont("GLicence_NPC1", {
  font = "Roboto",
  size = 50,
})


function ENT:Initalize()

	self.AutomaticFrameAdvance = true

end

function ENT:Draw()

	self:DrawModel()

	local ang = self:GetAngles()
	local lpos = Vector(0, -25, 80)
	local pos = self:LocalToWorld(lpos)

	ang:RotateAroundAxis(self:GetAngles():Up(), 90)
	ang:RotateAroundAxis(self:GetAngles():Right(), 270)

	cam.Start3D2D(pos, ang, 0.1)

	draw.RoundedBox(0, 0, 0, 500, 60, Color(0, 0, 0, 200))
	draw.RoundedBox(0, 0, 0, 500, 10, Color(0, 0, 0, 255))
	draw.SimpleText(GLicence.Lang.NPCTitle, "GLicence_NPC1", 250, 35, Color(255, 255, 255), 1, 1)

	cam.End3D2D()

end
