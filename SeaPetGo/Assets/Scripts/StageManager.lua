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
local stageBarrier : GameObject = nil
--!SerializeField
local shellsRequired : number = 0

local uiStageBarrier : UIStageBarrier = nil;
local uiStageUnlock : UIStageUnlock = nil;

local gameManagerScript : module = require("GameManager")

function SpawnPile(oldPilePos)
    local pileRoll = math.random(1,100)
    if pileRoll <= pileSmallChance then
        --Spawn Small Pile
        local newPile = Object.Instantiate(pileSmall)    
    elseif pileRoll > pileSmallChance and pileRoll <= pileMediumChance then
        --Spawn Medium Pile
        local newPile = Object.Instantiate(pileMedium)
    else
        --Spawn Big Pile
        local newPile = Object.Instantiate(pileBig)
    end
    newPile.transform.position = oldPilePos
    local pileScript = newPile:GetComponent("Pile")
    pileScript.SetPile()
end

function UnlockStage()
    print("Unlocking Stage")
    if gameManagerScript.VerifyShellsAgainst(shellsRequired) then
        print("Unlocked Stage")
        gameManagerScript.AddShells(-shellsRequired)
        stageBarrier.SetActive(false)
        --uiStageUnlock.DenyUnlockStage()
    else
        print("Not Enough Shells")
        gameManagerScript.AddShells(-shellsRequired)
        stageBarrier.SetActive(false)
        --uiStageUnlock.DenyUnlockStage()
    end
end

function self:ClientStart()
    uiStageUnlock = stageBarrier.gameObject:GetComponent(UIStageUnlock)
    uiStageUnlock.SetShellsRequired(shellsRequired)
    uiStageBarrier = stageBarrier.gameObject:GetComponentInChildren(UIStageBarrier)
    uiStageBarrier.SetStageBarrierText(shellsRequired)
end