--!Type(ClientAndServer)
local gameManagerScript : module = require("GameManager")
local achievementsManagerScript : module = require("AchievementsManager")
Pearls = 0

--!SerializeField
local sfx_gotPearls : AudioShader = nil

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
        Audio:PlayShader(sfx_gotPearls)
        Object.Destroy(self.gameObject)
    end
end