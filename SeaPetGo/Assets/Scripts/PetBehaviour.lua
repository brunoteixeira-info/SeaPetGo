--!SerializeField
local petName : string = "Pet"
--!SerializeField
local cPower : number = 0
--!SerializeField
local petRarity : string = "Rarity"

local target : GameObject = nil

local gameManagerScript : module = require("GameManager")
local petManager : module = require("PetManager")

function SetTarget(targetToFollow)
    target = targetToFollow
    print("Target: " .. target.name)
end

function FindAndSetTarget(targetName)
    target = GameObject.Find(targetName)
    print("Target: " .. target.name)
end

function self:ClientAwake()
    Name = petName
    Power = cPower
    Rarity = petRarity
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


