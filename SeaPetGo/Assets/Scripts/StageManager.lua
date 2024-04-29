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
local shellsRequired : number = 100

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
    --pileScript.SpawnerScript = self.gameObject:GetComponent("StageManager")
    pileScript.SetPile()
end

function VerifyShellsNeeded(playerShells)
    if(playerShells >= shellsRequired) then
        stageBarrier.SetActive(false)
    end
end