--!Type(UI)
--!Bind
local contStageUnlock : UIImage = nil
--!Bind
local containerStageUnlock : UIImage = nil
--!Bind
local textStageUnlock : UILabel = nil
--!Bind
local buttonStageUnlockAccept : UIButton = nil
--!Bind
local buttonStageUnlockDeny : UIButton = nil

local shellsRequired : number = 0

--!SerializeField
local stageManager : GameObject = nil
local stageManagerScript : StageManager = nil

textStageUnlock:SetPrelocalizedText("Do you want to spend " .. shellsRequired .. " shells\nto unlock this mysterious energy barrier?")

function self:ClientStart()
    self.gameObject:GetComponent(TapHandler).Tapped:Connect(function() 
        containerStageUnlock:RemoveFromClassList("hide")()
    end)

    buttonStageUnlockAccept:RegisterPressCallback(function () TryUnlockStage() end)
    buttonStageUnlockDeny:RegisterPressCallback(function () DenyUnlockStage() end)
    containerStageUnlock:AddToClassList("hide")
    stageManagerScript = stageManager.gameObject:GetComponent(StageManager)
end

function TryUnlockStage()
    stageManagerScript.UnlockStage()
end

function TryUnlockStage()
    textStageUnlock:SetPrelocalizedText("Oops! You don't have enough shells!\n")
end

function DenyUnlockStage()
    print("Deny Unlock Stage")
    containerStageUnlock:AddToClassList("hide")
    ResetUI()
end

function ResetUI()
    textStageUnlock:SetPrelocalizedText("Do you want to spend " .. shellsRequired .. " shells\nto unlock this mysterious energy barrier?")
end

function SetShellsRequired(shells)
    shellsRequired = shells
    ResetUI()
end
