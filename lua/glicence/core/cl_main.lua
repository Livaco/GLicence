include("glicence/config/config.lua")
include("glicence/config/lang.lua")

function GLicence:Message(message)
  chat.AddText(Color(255, 255, 255, 255), "[", GLicence.Config.PrefixColor, GLicence.Config.Prefix, Color(255, 255, 255, 255), "] ", message)
end

net.Receive("glicence_message", function()
  local msg = net.ReadString()
  GLicence:Message(msg)
end)

net.Receive("glicence_openderma_user", function()
  surface.CreateFont("GLicence_User1", {
    font = "Roboto",
    size = ScrH() * 0.05,
  })
  surface.CreateFont("GLicence_User2", {
    font = "Roboto",
    size = ScrH() * 0.025,
  })

  local frame = vgui.Create("DFrame")
  frame:SetSize(ScrW() * 0.5, ScrH() * 0.5)
  frame:SetTitle("")
  frame:SetDraggable(false)
  frame:ShowCloseButton(false)
  frame:Center()
  frame:MakePopup()
  frame.Paint = function(s, w, h)
    draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 230))
    draw.RoundedBox(0, 0, 0, w, h * 0.05, Color(0, 0, 0, 255))
    draw.SimpleText(GLicence.Lang.UserMenuTitle, "GLicence_User1", w / 2, h * 0.075, Color(255, 255, 255, 255), 1, 0)

    surface.SetDrawColor(255, 255, 255, 255)
    surface.DrawLine(w * 0.1, h * 0.2, w * 0.9, h * 0.2)
  end

  local CloseButton = vgui.Create("DButton", frame)
  CloseButton:SetPos(frame:GetWide() * 0.95, 0)
  CloseButton:SetSize(frame:GetWide() * 0.05, frame:GetTall() * 0.05)
  CloseButton:SetText("")
  CloseButton.Paint = function(s, w, h)
    draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 255))
    draw.SimpleText("X", "GLicence_User2", w / 2, h / 2, Color(255, 255, 255, 255), 1, 1)
  end
  CloseButton.DoClick = function()
    frame:Close()
  end

  local TextPanel = vgui.Create("DPanel", frame)
  TextPanel:SetPos(frame:GetWide() * 0.1, frame:GetTall() * 0.3)
  TextPanel:SetSize(frame:GetWide() * 0.8, frame:GetTall() * 0.3)
  TextPanel.Paint = function(s, w, h)
    draw.SimpleText(string.format(GLicence.Lang.NPCMessage, GLicence.Config.Cost), "GLicence_User2", w / 2, h / 2, Color(255, 255, 255, 255), 1, 1)
  end

  local BuyButton = vgui.Create("DButton", frame)
  BuyButton:SetPos(frame:GetWide() * 0.1, frame:GetTall() * 0.8)
  BuyButton:SetSize(frame:GetWide() * 0.8, frame:GetTall() * 0.1)
  BuyButton:SetText("")
  local BuyLerp = 0
  BuyButton.Paint = function(s, w, h)
    if(BuyButton:IsHovered() == true) then
      BuyLerp = Lerp(0.05, BuyLerp, w)
    else
      BuyLerp = Lerp(0.05, BuyLerp, 0)
    end
    draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 200))
    draw.RoundedBox(0, 0, 0, BuyLerp, h, GLicence.Config.ButtonAnimColor)
    draw.SimpleText(string.format(GLicence.Lang.BuyButton, GLicence.Config.Cost), "GLicence_User2", w / 2, h / 2, Color(255, 255, 255, 255), 1, 1)
  end
  BuyButton.DoClick = function()
    net.Start("glicence_buy")
    net.SendToServer()
    frame:Close()
  end
end)
