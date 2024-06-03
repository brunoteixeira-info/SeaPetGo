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
    if pileRoll <= pileSmallChance then
        --Spawn Small Pile
        -- Create a new Timer object. Interval: 5, Callback:function()..end, Repeating: false
        local timeToSpawn = math.random(10,15)
        local newTimer = Timer.new(timeToSpawn, function() CreateSmallPile(oldPilePos) end, false)
    elseif pileRoll > pileSmallChance and pileRoll <= pileMediumChance then
        --Spawn Medium Pile
        -- Create a new Timer object. Interval: 5, Callback:function()..end, Repeating: false
        local timeToSpawn = math.random(15,20)
        local newTimer = Timer.new(timeToSpawn, function() CreateMediumPile(oldPilePos) end, false)
    else
        --Spawn Big Pile
        -- Create a new Timer object. Interval: 5, Callback:function()..end, Repeating: false
        local timeToSpawn = math.random(20,25)
        local newTimer = Timer.new(timeToSpawn, function() CreateBigPile(oldPilePos) end, false)
    end
end

function CreateSmallPile(oldPilePos)
    local newPile = Object.Instantiate(pileSmall)
    newPile.transform.position = oldPilePos
    local pileScript = newPile:GetComponent(Pile)
    pileScript.SetSpawnAndPile(self.gameObject, self)    
end

function CreateMediumPile(oldPilePos)
    local newPile = Object.Instantiate(pileMedium)
    newPile.transform.position = oldPilePos
    local pileScript = newPile:GetComponent(Pile)
    pileScript.SetSpawnAndPile(self.gameObject, self)    
end

function CreateBigPile(oldPilePos)
    local newPile = Object.Instantiate(pileBig)
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