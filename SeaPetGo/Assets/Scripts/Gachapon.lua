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

function GetPet()
    local petRoll = math.random(1,100)
    if petRoll <= pet1Chance then
        --Spawn Pet1
        local newPet = Object.Instantiate(pet1)    
    elseif petRoll > pet1Chance and petRoll <= pet2Chance then
        --Spawn Pet2
        local newPet = Object.Instantiate(pet2)    
    elseif petRoll > pet2Chance and petRoll <= pet3Chance then
        --Spawn Pet3
        local newPet = Object.Instantiate(pet3)    
    elseif petRoll > pet3Chance and petRoll <= pet4Chance then
        --Spawn Pet4
        local newPet = Object.Instantiate(pet4)    
    else
        --Spawn Pet5
        local newPet = Object.Instantiate(pet5)    
    end

    --GET PET UI
    --RECEIVE/DENY PET
end