--!Type(UI)

--!Bind
local textPlayerShells : UILabel = nil
--!Bind
local textPlayerPearls : UILabel = nil

textPlayerShells:SetPrelocalizedText("000000")
textPlayerPearls:SetPrelocalizedText("000000")

function SetPlayerShells(shells)
    textPlayerShells:SetPrelocalizedText(shells)
end

function SetPlayerPearls(pearls)
    textPlayerPearls:SetPrelocalizedText(pearls)
end