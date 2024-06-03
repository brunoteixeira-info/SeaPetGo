
--!SerializeField
local pileMesh : MeshRenderer = nil
--!SerializeField
local pileCollider : Collider = nil
--!SerializeField
local shells : number = 20
--!SerializeField
local objShells : GameObject = nil
--!SerializeField
local objPearls : GameObject = nil
--!SerializeField
local objParticles : GameObject = nil
--!SerializeField
local objUIPile : GameObject = nil
local uiPileScript : UIPile = nil

--!SerializeField
local sfx_dig : AudioShader = nil
--!SerializeField
local sfx_pileExplosion : AudioShader = nil

local pearlsInside : number = 0

local Timed : boolean = false
local shellsInside
local hp
local petPower = 1;
local newTimer

local gameManagerScript : module = require("GameManager")
local achievementsManagerScript : module = require("AchievementsManager")
local lastPetInteracted : PetBehaviour = nil

local stageManagerObj : GameObject = nil
local stageManager : StageManager = nil

--!SerializeField
local objParent : string = "Spawn"

function SetPile()
    if(stageManagerObj ~= nil) then
        stageManager = stageManagerObj:GetComponent(StageManager)
        uiPileScript = objUIPile:GetComponent(UIPile)
        shellsInside = math.random(shells - 10, shells + 10)
        pearlsInside = shellsInside * 0.1
        hp = shellsInside * 2
        print(hp)
        UpdateSize(hp)
        uiPileScript.SetHP(hp, shellsInside)
    else
        stageManagerObj = GameObject.Find(objParent)
        stageManager = stageManagerObj:GetComponent(StageManager)
        uiPileScript = objUIPile:GetComponent(UIPile)
        shellsInside = math.random(shells - 10, shells + 10)
        pearlsInside = shellsInside * 0.1
        hp = shellsInside * 2
        print(hp)
        UpdateSize(hp)
        uiPileScript.SetHP(hp, shellsInside)
    end
end

function SetSpawnAndPile(spawnerObj, manager)
    self.gameObject.transform:SetParent(spawnerObj.transform)
    stageManagerObj = spawnerObj
    stageManager = manager
    uiPileScript = objUIPile:GetComponent(UIPile)
    shellsInside = math.random(shells - 10, shells + 10)
    pearlsInside = shellsInside * 0.1
    hp = shellsInside * 2
    timer = hp/1.5
    print(hp)
    UpdateSize(hp)
    uiPileScript.SetHP(hp, shellsInside)
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
            if(lastPetInteracted.Curious) then
                shellsInside = shellsInside + (lastPetInteracted.Power * 0.1)
                pearlsInside = shellsInside * 0.1
                hp = shellsInside
                print(hp)
            end
            
            local timeTick = 0.5

            if(lastPetInteracted.Enthusiastic) then
                timeTick = timeTick - (lastPetInteracted.Power * 0.001)
            end

            Timed = true
            newTimer = Timer.Every(timeTick, function() UpdatePileDestruction() end)
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
            uiPileScript.SetHP(hp, shellsInside)
            Audio:PlayShader(sfx_dig)
        else
            --Timer Ended
            lastPetInteracted.SetTarget(client.localPlayer.character.gameObject)
            SpawnShells()
            SpawnPearls()
            stageManager.SpawnPile(self.transform.position)
            local particles = Object.Instantiate(objParticles)
            particles.gameObject.transform.position = self.gameObject.transform.position
            achievementsManagerScript.UpdateDigQuestProgress()
            newTimer:Stop()
            Audio:PlayShader(sfx_pileExplosion)
            Object.Destroy(self.gameObject)
        end
    end
end
