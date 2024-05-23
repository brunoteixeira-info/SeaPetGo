--!SerializeField
local pileSmall : GameObject = nil
--!SerializeField
local pileSmallChance : number = 70
--!SerializeField
local pileMedium : GameObject = nil
--!SerializeField
local pileMediumChance : number = 90
--!SerializeField
local pileBig : GameObject = nil
--!SerializeField
local pileBigChance : number = 100
--!SerializeField
local stageBarrier : GameObject
--!SerializeField
local shellsRequired : number = 0
--!SerializeField
local stage : number = 0

local uiStageBarrier : UIStageBarrier
local uiStageUnlock : UIStageUnlock

local gameManagerScript : module = require("GameManager")
local achievementsManagerScript : module = require("AchievementsManager")

function SpawnPile(oldPilePos)
    local pileRoll = math.random(1,100)
    local newPile = nil
    if pileRoll <= pileSmallChance then
        --Spawn Small Pile
        newPile = Object.Instantiate(pileSmall)    
    elseif pileRoll > pileSmallChance and pileRoll <= pileMediumChance then
        --Spawn Medium Pile
        newPile = Object.Instantiate(pileMedium)
    else
        --Spawn Big Pile
        newPile = Object.Instantiate(pileBig)
    end
    newPile.transform.position = oldPilePos
    local pileScript = newPile:GetComponent(Pile)
    pileScript.SetSpawnAndPile(self.gameObject, self)
end

function UnlockStage()
    print("Unlocking Stage")
    gameManagerScript.VerifyShellsAgainst(shellsRequired, self)
end

function ManagerResponse(response)
    if response == 1 then
        print("Unlocked Stage")
        gameManagerScript.AddShells(-shellsRequired)
        stageBarrier:SetActive(false)
        achievementsManagerScript.UpdateAchievementsStageProgress()
        uiStageUnlock.DenyUnlockStage()
    else
        print("Not Enough Shells for new Stage")
        uiStageUnlock.DontUnlockStage()
    end
end

function self:ClientStart()
    local stageBarrierName = self.gameObject.name .. "Barrier"
    stageBarrier = GameObject.Find(stageBarrierName)
    if(stageBarrier ~= nil) then
        uiStageUnlock = stageBarrier.gameObject:GetComponent(UIStageUnlock)
        uiStageUnlock.SetShellsRequired(shellsRequired)
        uiStageUnlock.SetStage(stage)
        stageBarrierName = "UI" .. stageBarrierName
        local stageBarrierUI = GameObject.Find(stageBarrierName)
        if(stageBarrierUI ~= nil) then
            uiStageBarrier = stageBarrierUI:GetComponentInChildren(UIStageBarrier)
            uiStageBarrier.SetStageBarrierText(shellsRequired)
        end
    end
end