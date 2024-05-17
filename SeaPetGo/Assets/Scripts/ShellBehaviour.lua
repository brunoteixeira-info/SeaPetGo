--!Type(ClientAndServer)
local gameManagerScript : module = require("GameManager")
Shells = 0

function self:OnTriggerEnter(other : Collider)
    local playerCharacter = other.gameObject:GetComponent(Character)
    if playerCharacter == nil then
        return
    end

    local player = playerCharacter.player -- Player Info
    
    if client.localPlayer == player then
        print("Collected Shell")
        gameManagerScript.AddShells(Shells)
        Object.Destroy(self.gameObject)
    end
end