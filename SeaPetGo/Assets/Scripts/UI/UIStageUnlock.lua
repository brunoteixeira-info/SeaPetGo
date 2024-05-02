--!Type(UI)

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

textStageUnlock:SetPrelocalizedText("Do you want to spend\nto unlock this mysterious energy barrier?")

function self:ClientStart()
    buttonStageUnlockAccept:RegisterPressCallback(function () TryUnlockStage() end)
    buttonStageUnlockDeny:RegisterPressCallback(function () DenyUnlockStage() end)
    --stageManagerScript = stageManager.gameObject:GetComponent(StageManager)
end

function TryUnlockStage()
    --stageManagerScript.UnlockStage()
end

function DenyUnlockStage()
    print("Deny Unlock Stage")
    containerStageUnlock:AddToClassList("hide")
end


