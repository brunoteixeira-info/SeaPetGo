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

local gameManagerScript : module = require("GameManager")
local uiPetObtained : UIPetObtained
local newPet : GameObject

function GetPet()
    local petRoll = math.random(1,100)
    print("Pet Roll: " .. petRoll)

    if petRoll <= pet1Chance then
        --Spawn Pet1
        Object.Instantiate(pet1)      
    elseif petRoll > pet1Chance and petRoll <= pet2Chance then
        --Spawn Pet2
        Object.Instantiate(pet2)   
    elseif petRoll > pet2Chance and petRoll <= pet3Chance then
        --Spawn Pet3
        Object.Instantiate(pet3)   
    elseif petRoll > pet3Chance and petRoll <= pet4Chance then
        --Spawn Pet4
        Object.Instantiate(pet4)   
    else
        --Spawn Pet5
        Object.Instantiate(pet5)       
    end

    --local petStats = newPet.gameObject:GetComponent(PetBehaviour)
    uiPetObtained.SetPet("Jubei", "LEGEND", 100)
end

function BuyPet()
    print("Buying Pet")
    gameManagerScript.VerifyShellsAgainst(petRollCost, self)
end

function BuyPetResponse(response)
    if response == 1 then
        print("Bought a Pet")
        GetPet()
        gameManagerScript.AddShells(-petRollCost)
    else
        print("Not Enough Shells for Pet")
    end
end

function AcceptPet()
    print("Accept Pet")
end

function DenyPet()
    print("Deny Pet")
    Object.Destroy(newPet)
end

function self:ClientAwake()
    self.gameObject:GetComponent(TapHandler).Tapped:Connect(function() 
        BuyPet()
    end)
end

function self:ClientStart()
    local uiObj = GameObject.Find("UIManager")
    uiPetObtained = uiObj:GetComponent(UIPetObtained)
end