--!Type(UI)

--!Bind
local textPlayerShells : UILabel = nil
--!Bind
local textPlayerPearls : UILabel = nil

textPlayerShells:SetPrelocalizedText("100")
textPlayerPearls:SetPrelocalizedText("0")

function SetPlayerShells(shells)
    textPlayerShells:SetPrelocalizedText(shells)
end

function SetPlayerPearls(pearls)
    textPlayerPearls:SetPrelocalizedText(pearls)
end