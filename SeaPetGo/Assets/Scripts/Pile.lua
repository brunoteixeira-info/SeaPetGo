
local pileMesh : MeshRenderer = nil
local pileCollider : Collider = nil

--!SerializeField
local spawner : GameObject = nil
--!SerializeField
local shells : number = 20

local Timed : boolean = false
local shellsInside
local hp
local timer = 10
local spawnerScript = nil

function SetPile()
    MeshRenderer = self.gameObject:GetComponent(MeshRenderer)
    print(MeshRenderer)
    Collider = self.gameObject:GetComponent(Collider)
    print(Collider)
    spawnerScript = spawner.gameObject:GetComponent(StageManager)
    print(spawnerScript)
    shellsInside = math.random(shells - 10, shells + 10)
    hp = shellsInside
    print(hp)
    UpdateSize(hp)
end

function UpdateSize(currentHealth)
    self.transform.localScale = Vector3.new(1 + currentHealth/10, 1 + currentHealth/10, 1 + currentHealth/10)
end

function self:ClientStart()
    SetPile()
end

function self:OnTriggerEnter(collider)
    colliderCharacter = collider.gameObject:GetComponent(Character)
    if(colliderCharacter == nil)then
        return
    end
    player = colliderCharacter.player -- Player Info
    if(client.localPlayer == player)then
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
            spawnerScript.SpawnPile(self.transform.position)
            Object.Destroy(self.gameObject)
        end
    end
end