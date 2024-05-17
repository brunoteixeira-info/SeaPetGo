
--!SerializeField
local pileMesh : MeshRenderer = nil
--!SerializeField
local pileCollider : Collider = nil
--!SerializeField
local shells : number = 20
--!SerializeField
local parentObj : string = ""
--!SerializeField
local objShells : GameObject = nil
--!SerializeField
local objPearls : GameObject = nil
--!SerializeField
local objParticles : GameObject = nil
--!SerializeField
local objUIPile : GameObject = nil
local uiPileScript : UIPile = nil

local pearlsInside : number = 0

local Timed : boolean = false
local shellsInside
local hp
local petPower = 1;
local newTimer

local gameManagerScript : module = require("GameManager")
local lastPetInteracted : PetBehaviour = nil

function SetPile()
    objUIPile = self.gameObject.transform:GetChild(4)
    uiPileScript = objUIPile.gameObject:GetComponent("UIPile")
    shellsInside = math.random(shells - 10, shells + 10)
    pearlsInside = shellsInside * 0.1
    hp = shellsInside
    print(hp)
    UpdateSize(hp)
    uiPileScript.SetPile(hp, shellsInside)
end

function SetSpawnAndPile(spawnerObj, parent)
    self.gameObject.transform:SetParent(spawnerObj.transform)
    parentObj = parent
    shellsInside = math.random(shells - 10, shells + 10)
    hp = shellsInside
    timer = hp/1.5
    print(hp)
    UpdateSize(hp)
    --uiPileScript.SetPile(hp, shellsInside)
end

function UpdateSize(currentHealth)
    self.transform.localScale = Vector3.new(1 + currentHealth/10, 1 + currentHealth/10, 1 + currentHealth/10)
end

function self:ClientAwake()
    self.gameObject:GetComponent(TapHandler).Tapped:Connect(function() 
        StartPileDestruction()
    end)
end

function self:ClientStart()
    SetPile()
end

function SpawnShells()
    local shellsToSpawn = math.random(shellsInside - 5, shellsInside)
    local shellValue = shellsInside / shellsToSpawn
    print("Spawning " .. shellsToSpawn .. " shells with the value of " .. shellValue .. " each")
    for i = 1, shellsToSpawn do
        local shell = Object.Instantiate(objShells)
        local randomPos = Vector3.new(math.random(self.gameObject.transform.position.x - 0.5, self.gameObject.transform.position.x + 0.5), 0, math.random(self.gameObject.transform.position.z - 0.5, self.gameObject.transform.position.z + 0.5))
        shell.gameObject.transform.position = randomPos
        shellScript = shell:GetComponent(ShellBehaviour)
        shellScript.Shells = shellValue
    end
end

function SpawnPearls()
    local pearlsToSpawn = math.random(pearlsInside - 1, pearlsInside)
    local pearlValue = pearlsInside / pearlsToSpawn
    print("Spawning " .. pearlsToSpawn .. " pearls with the value of " .. pearlValue .. " each")
    for i = 1, pearlsToSpawn do
        local pearl = Object.Instantiate(objPearls)
        local randomPos = Vector3.new(math.random(self.gameObject.transform.position.x - 0.5, self.gameObject.transform.position.x + 0.5), 0, math.random(self.gameObject.transform.position.z - 0.5, self.gameObject.transform.position.z + 0.5))       
        pearl.gameObject.transform.position = randomPos
        pearlScript = pearl:GetComponent(PearlBehaviour)
        pearlScript.Pearls = pearlValue
    end
end

function StartPileDestruction()
    if(Timed)then
        return
    else
        gameManagerScript.SetPetTarget(self.gameObject.name)
        lastPetInteracted = client.localPlayer.character.gameObject.transform:GetChild(2):GetComponent(PetBehaviour)
        if(lastPetInteracted == nil) then 
            return 
        else
            petPower = lastPetInteracted.Power
            Timed = true
            newTimer = Timer.Every(0.5, function() UpdatePileDestruction() end)
            print(self.gameObject.name .. " being targeted")
        end
    end
end

function UpdatePileDestruction()
    print("Update Pile Destruction")
    if(Timed)then
        if(hp > 0)then
            hp = hp - (petPower/10)
            UpdateSize(hp)
            --uiPileScript.SetPile(hp, shellsInside)
        else
            --Timer Ended
            lastPetInteracted.SetTarget(client.localPlayer.character.gameObject)
            SpawnShells()
            SpawnPearls()
            GameObject.Find(parentObj):GetComponent(StageManager).SpawnPile(self.transform.position, parentObj)
            local particles = Object.Instantiate(objParticles)
            particles.gameObject.transform.position = self.gameObject.transform.position
            newTimer:Stop()
            Object.Destroy(self.gameObject)
        end
    end
end
