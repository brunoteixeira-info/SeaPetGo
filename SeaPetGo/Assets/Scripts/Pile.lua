
--!SerializeField
local pileMesh : MeshRenderer = nil
--!SerializeField
local pileCollider : Collider = nil
--!SerializeField
local shells : number = 20

local pearlsInside : number = 0

local Timed : boolean = false
local shellsInside
local hp
local timer = 10
local spawnerScript = nil
local petPower = 1;

local gameManagerScript : module = require("GameManager")
local lastPetInteracted : PetBehaviour = nil

function SetPile()
    spawnerScript = self.gameObject:GetComponentInParent(StageManager)
    shellsInside = math.random(shells - 10, shells + 10)
    pearlsInside = shellsInside * 0.1
    hp = shellsInside
    timer = hp/1.5
    print(hp)
    UpdateSize(hp)
end

function SetSpawnAndPile(spawnerObj)
    spawnerScript = spawnerObj.gameObject:GetComponent(StageManager)
    shellsInside = math.random(shells - 10, shells + 10)
    hp = shellsInside
    timer = hp/1.5
    print(hp)
    UpdateSize(hp)
end

function UpdateSize(currentHealth)
    self.transform.localScale = Vector3.new(1 + currentHealth/10, 1 + currentHealth/10, 1 + currentHealth/10)
end

function self:ClientAwake()
    self.gameObject:GetComponent(TapHandler).Tapped:Connect(function() 
        gameManagerScript.SetPetTarget(self.gameObject.name)
    end)
end

function self:ClientStart()
    SetPile()
end

function self:OnTriggerEnter(collider)
    lastPetInteracted = collider.gameObject:GetComponent(PetBehaviour)
    if(lastPetInteracted == nil) then 
        return 
    else
        petPower = lastPetInteracted.Power
        Timed = true
        print(self.gameObject.name .. " being targeted")
    end
end

function self:Update()
    if(Timed)then
        if(hp > 0)then
            hp = hp - (Time.deltaTime * (petPower/100))
            UpdateSize(hp)
        else
            --Timer Ended
            lastPetInteracted.SetTarget(client.localPlayer.character.gameObject)
            gameManagerScript.AddShells(shellsInside)
            gameManagerScript.AddPearls(pearlsInside)
            spawnerScript.SpawnPile(self.transform.position)
            Object.Destroy(self.gameObject)
        end
    end
end