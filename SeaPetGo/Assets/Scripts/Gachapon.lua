--!SerializeField
local pet1 : GameObject = nil
--!SerializeField
local pet1Chance : number = 30
--!SerializeField
local pet2 : GameObject = nil
--!SerializeField
local pet2Chance : number = 60
--!SerializeField
local pet3 : GameObject = nil
--!SerializeField
local pet3Chance : number = 80
--!SerializeField
local pet4 : GameObject = nil
--!SerializeField
local pet4Chance : number = 90
--!SerializeField
local pet5 : GameObject = nil
--!SerializeField
local pet5Chance : number = 100
--!SerializeField
local petRollCost : number = 150
--!SerializeField
local uiGachapon : GameObject = nil

local gameManagerScript : module = require("GameManager")
local petManagerScript : module = require("PetManager")
local uiPetObtained : UIPetObtained
local uiPetUnlock : UIPetUnlock
local newPet : GameObject

function GetPet()
    local petRoll = math.random(1,100)
    print("Pet Roll: " .. petRoll)

    if petRoll <= pet1Chance then
        --Spawn Pet1
        newPet = Object.Instantiate(pet1)      
    elseif petRoll > pet1Chance and petRoll <= pet2Chance then
        --Spawn Pet2
        newPet = Object.Instantiate(pet2)   
    elseif petRoll > pet2Chance and petRoll <= pet3Chance then
        --Spawn Pet3
        newPet = Object.Instantiate(pet3)   
    elseif petRoll > pet3Chance and petRoll <= pet4Chance then
        --Spawn Pet4
        newPet = Object.Instantiate(pet4)   
    else
        --Spawn Pet5
        newPet = Object.Instantiate(pet5)       
    end

    local petStats = newPet.gameObject:GetComponent(PetBehaviour)
    uiPetObtained.SetGachapon(self)
    uiPetObtained.SetPet(petStats.Name, petStats.Power, petStats.Rarity)
end

function BuyPet()
    print("Buying Pet")
    gameManagerScript.VerifyShellsAgainst(petRollCost, self)
end

function ManagerResponse(response)
    if response == 1 then
        print("Bought a Pet")
        GetPet()
        gameManagerScript.AddShells(-petRollCost)
        uiPetUnlock.DenyUnlockStage()
    else
        print("Not Enough Shells for Pet")
        uiPetUnlock.DontUnlockStage()
    end
end

function AcceptPet()
    print("Accept Pet")
    local petStats = newPet.gameObject:GetComponent(PetBehaviour)
    print(petStats.Name)
    if(client.localPlayer.character.gameObject.transform:GetChild(2)) then
        Object.Destroy(client.localPlayer.character.gameObject.transform:GetChild(2).gameObject)
    end
    gameManagerScript.AddPet(petStats.Name)

end

function DenyPet()
    print("Deny Pet")
    Object.Destroy(newPet.gameObject)
end

function self:ClientStart()
    local uiObj = GameObject.Find("UIManager")
    uiPetObtained = uiObj:GetComponent("UIPetObtained")
    uiGachapon:GetComponent("UIGachapon").SetPlayerShellsNeeded(petRollCost)
    uiPetUnlock = self.gameObject:GetComponent("UIPetUnlock")
    uiPetUnlock.SetGachapon(petRollCost)
end