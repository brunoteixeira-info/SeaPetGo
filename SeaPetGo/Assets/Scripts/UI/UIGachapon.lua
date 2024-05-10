--!Type(UI)
--!Bind
local textShellsNeeded : UILabel = nil
--!Bind
local imageShells : UIImage = nil

textShellsNeeded:SetPrelocalizedText("000")

function SetPlayerShellsNeeded(shells)
    textShellsNeeded:SetPrelocalizedText(shells)
end
