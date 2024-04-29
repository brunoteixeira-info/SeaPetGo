--!SerializeField
local petName : string = "Pet"
--!SerializeField
local cPower : number = 0

local target : GameObject = nil

function self:ClientStart()

end

function self:ClientUpdate()
    if(client.localPlayer.CharacterChanged) then
        --target = client.localPlayer.character.gameObject
        print(client.localPlayer.character.gameObject)
        --transform.position = client.localPlayer.character.gameObject
    end
end

