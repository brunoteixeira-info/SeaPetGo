--!Type(ClientAndServer)
local gameManagerScript : module = require("GameManager")
local achievementsManagerScript : module = require("AchievementsManager")
Pearls = 0

function self:OnTriggerEnter(other : Collider)
    local playerCharacter = other.gameObject:GetComponent(Character)
    if playerCharacter == nil then
        return
    end

    local player = playerCharacter.player -- Player Info
    
    if client.localPlayer == player then
        print("Collected Pearl")
        gameManagerScript.AddPearls(Pearls)
        achievementsManagerScript.UpdatePearlsQuestProgress(Pearls)
        Object.Destroy(self.gameObject)
    end
end