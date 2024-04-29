--!SerializeField
local pileMesh : MeshRenderer = nil
--!SerializeField
local pileCollider : Collider = nil
--!SerializeField
local shells : number = 20

local Timed : boolean = false
local shellsInside
local hp

local timer = 10

local playerManagerScript = require("PlayerManager")
SpawnerScript = nil

function SetPile()
    SpawnerScript = self.gameObject:GetComponentInParent(StageManager)
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
        playerManagerScript.AddEnergy(Energy)
        pileMesh.enabled = false
        pileCollider.enabled = false
        timer = math.random(7, 12)
        Timed = true
    end
end

function self:Update()
    if(Timed)then
        if(timer > 0)then
            timer = timer - Time.deltaTime
        else
            --Timer Ended
            SpawnerScript.SpawnPile(self.transform.position)
            Object.Destroy(self.gameObject)
        end
    end
end