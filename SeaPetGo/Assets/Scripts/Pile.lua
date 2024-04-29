--!SerializeField
local Timed : boolean = false
--!SerializeField
local Lightning : boolean = false
--!SerializeField
local shells : number = 20

local shellsInside
local hp

local timer = 10

local playerManagerScript = require("PlayerManager")
SpawnerScript = nil

function SetPile()
    shellsInside = math.random(shells - 10, shells + 10)
    hp = shellsInside
    print(hp)
    UpdateSize(hp)
end

function UpdateSize(currentHealth)
    self.transform.localScale = Vector3.new(1 + currentHealth/10, 1 + currentHealth/10, 1 + currentHealth/10)
end

function self:Start()
    SetPile()
end

function self:OnTriggerEnter(collider)
    colliderCharacter = collider.gameObject:GetComponent(Character)
    if(colliderCharacter == nil)then
        return
    end
    player = colliderCharacter.player -- Player Info
    if(client.localPlayer == player)then

        gameAudio.playSound(Clip)

        playerManagerScript.AddEnergy(Energy)
        if(SpawnerScript)then SpawnerScript.activeOrbs = SpawnerScript.activeOrbs - 1 end -- Only change the Spawner Script's orb count if it is spawned by the spawner

        if(Lightning)then
            playerManagerScript.StrikeKaiju(Energy)
        end

        Object.Destroy(self.gameObject)
    end
end

function self:Update()
    if(Timed)then
        if(timer > 0)then
            timer = timer - Time.deltaTime
        else
            --Timer Ended
            Object.Destroy(self.gameObject)
        end
    end
end