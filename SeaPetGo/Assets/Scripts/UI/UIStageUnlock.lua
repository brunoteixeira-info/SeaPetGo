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

local stageManager : GameObject
local stageManagerScript : StageManager

local stageCurrent : number

--!SerializeField
local sfx_popup : AudioShader = nil
--!SerializeField
local sfx_uiClose : AudioShader = nil
--!SerializeField
local sfx_uiNotEnough : AudioShader = nil

textStageUnlock:SetPrelocalizedText("Do you want to spend " .. shellsRequired .. " shells\nto unlock this mysterious energy barrier?")

function self:ClientStart()
    self.gameObject:GetComponent(TapHandler).Tapped:Connect(function() 
        OpenUI()()
    end)

    buttonStageUnlockAccept:RegisterPressCallback(function () TryUnlockStage() end)
    buttonStageUnlockDeny:RegisterPressCallback(function () DenyUnlockStage() end)
    containerStageUnlock:AddToClassList("hide")
end

function OpenUI()
    containerStageUnlock:RemoveFromClassList("hide")
    Audio:PlayShader(sfx_popup)
end

function TryUnlockStage()
    stageManagerScript.UnlockStage()
end

function DontUnlockStage()
    textStageUnlock:SetPrelocalizedText("Oops! You don't have enough shells!\n")
    Audio:PlayShader(sfx_uiNotEnough)
end

function DenyUnlockStage()
    print("Deny Unlock Stage")
    containerStageUnlock:AddToClassList("hide")
    ResetUI()
    Audio:PlayShader(sfx_uiClose)
end

function ResetUI()
    textStageUnlock:SetPrelocalizedText("Do you want to spend " .. shellsRequired .. " shells\nto unlock this mysterious energy barrier?")
end

function SetShellsRequired(shells)
    shellsRequired = shells
    ResetUI()
end

function SetStage(stage)
    stageCurrent = stage
    local stageName = "Stage" .. stageCurrent
    print(stageName)
    stageManager = GameObject.Find(stageName)
    stageManagerScript = stageManager:GetComponent(StageManager)
end
