--!SerializeField
local petName : string = "Pet"

local target : GameObject = nil

local gameManagerScript : module = require("GameManager")
local petManager : module = require("PetManager")

Name = "Pet"
Power = 0
Rarity = "Common"

function SetTarget(targetToFollow)
    target = targetToFollow
    print("Target: " .. target.name)
end

function FindAndSetTarget(targetName)
    target = GameObject.Find(targetName)
    print("Target: " .. target.name)
end

function self:ClientAwake()
    local petObtained = petManager.GetPet(petName)
    Name = petObtained.name
    Power = petObtained.cPower
    Rarity = petObtained.rarity
end

function self:ClientStart()
    SetTarget(client.localPlayer.character.gameObject)
    self.gameObject.transform:SetParent(client.localPlayer.character.gameObject.transform)
end

function self:ClientLateUpdate()
    if(target ~= nil) then
        local vectTarget = Vector3.new(target.transform.position.x - 1, target.transform.position.y, target.transform.position.z - 1)
        self.transform.position = vectTarget
        self.transform.rotation = target.transform.rotation
    end
end


