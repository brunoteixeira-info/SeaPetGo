--!SerializeField
local petName : string = "Pet"
--!SerializeField
local petRarity : string = "Rarity"
--!SerializeField
local cPower : number = 0

local target : GameObject = nil

local gameManagerScript : module = require("GameManager")

--!SerializeField
local vecLookAt : Vector3 = Vector3.new(0,0,0)

function SetTarget(targetToFollow)
    target = targetToFollow
    print(target)
end

function self:ClientStart()
    SetTarget(client.localPlayer.character.gameObject)
end

function self:ClientLateUpdate()
    if(target ~= nil) then
        local vectTarget = Vector3.new(target.transform.position.x - 1, target.transform.position.y, target.transform.position.z - 1)
        self.transform.position = vectTarget
        self.transform.rotation = target.transform.rotation
    end
end


