--!Type(ClientAndServer)
local gameManagerScript : module = require("GameManager")
local achievementsManagerScript : module = require("AchievementsManager")
Shells = 0

--!SerializeField
local sfx_gotShells : AudioShader = nil

function self:OnTriggerEnter(other : Collider)
    local playerCharacter = other.gameObject:GetComponent(Character)
    if playerCharacter == nil then
        return
    end

    local player = playerCharacter.player -- Player Info
    
    if client.localPlayer == player then
        print("Collected Shell")
        gameManagerScript.AddShells(Shells)
        achievementsManagerScript.UpdateShellsQuestProgress(Shells)
        Audio:PlayShader(sfx_gotShells)
        Object.Destroy(self.gameObject)
    end
end