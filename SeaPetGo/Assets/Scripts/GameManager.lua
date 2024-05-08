--SHELLS EVENTS
addShellsRequest = Event.new("AddShellsRequest")
addShellsResponse = Event.new("AddShellsResponse")

verifyShellsAgainstRequest = Event.new("VerifyShellsAgainstRequest")
verifyShellsAgainstResponse = Event.new("VerifyShellsAgainstResponse")

--PEARLS EVENTS
addPearlsRequest = Event.new("AddPearlsRequest")
addPearlsResponse = Event.new("AddPearlsResponse")

verifyPearlsAgainstRequest = Event.new("VerifyPearlsAgainstRequest")
verifyShellsAgainstResponse = Event.new("VerifyPearlsAgainstResponse")

--PETS EVENTS
addPetRequest = Event.new("AddPetRequest")
addPetResponse = Event.new("AddPetResponse")

setPetTargetRequest = Event.new("SetPetTargetRequest")
setPetTargetResponse = Event.new("SetPetTargetResponse")

players = {}
playerPets = {}
playerPetsActive = {}

local uiManagerScript : UIManager
local uiPetInventory : UIPetInventory
local petManagerScript : module = require("PetManager")

local function TrackPlayers(game, characterCallback)
    scene.PlayerJoined:Connect(function(scene, player)
        players[player] = {
            player = player,
            shells = IntValue.new("shells" .. tostring(player.id), 0),
            pearls = IntValue.new("pearls" .. tostring(player.id), 0)
        }

        for i=1,2 do
            playerPets[player] = {}
             
            for j=1,20 do
                playerPets[player][j] = StringValue.new("pet" .. tostring(player.id), "")
            end
             
        end

        player.CharacterChanged:Connect(function(player, character) 
            local playerinfo = players[player]
            if (character == nil) then
                return
            end 

            if characterCallback then
                characterCallback(playerinfo)
            end
        end)
    end)

    game.PlayerDisconnected:Connect(function(player)
        players[player] = nil
        playerPets[player] = nil
    end)
end

function self:ClientAwake()
    function OnCharacterInstantiate(playerinfo)
        local player = playerinfo.player
        local character = player.character
    end

    --SHELLS FUNCTIONS
   --AddShells() adds Shells to whichever client calls the function
   function AddShells(amount)
    addShellsRequest:FireServer(amount)
   end

   addShellsResponse:Connect(function(player, shells)
        if(player == client.localPlayer) then
            uiManagerScript.SetPlayerShells(shells)
        end
    end)

    --VerifyShellsAgainst() compares current shells that the Player has against a specific amount, returning true if there's more or equal shells than the amount to whichever client calls the function
   function VerifyShellsAgainst(amountToCompareTo, script)
    verifyShellsAgainstRequest:FireServer(amountToCompareTo, script)
   end

    verifyShellsAgainstResponse:Connect(function(player, response, script)
        if(player == client.localPlayer) then
            script.ManagerResponse(response)
        end
    end)

    --PEARLS FUNCTIONS
    --AddPearls() adds Shells to which ever client calls the function
    function AddPearls(amount)
        addPearlsRequest:FireServer(amount)
    end

    addPearlsResponse:Connect(function(player, pearls)
        if(player == client.localPlayer) then
            uiManagerScript.SetPlayerPearls(pearls)
        end
    end)
    
    --VerifyPearlsAgainst() compares current pearls that the Player has against a specific amount, returning true if there's more or equal pearls than the amount to whichever client calls the function
    function VerifyPearlsAgainst(amountToCompareTo)
        verifyPearlsAgainstRequest:FireServer(amountToCompareTo)
    end

    --PETS FUNCTIONS
    --AddPet() adds Pet to which ever client calls the function
    function AddPet(pet)
        print("Check AddPet #1 - " .. pet)
        addPetRequest:FireServer(pet)
    end

    addPetResponse:Connect(function(player, pet)
        if(player == client.localPlayer) then
            uiPetInventory.AddNewPet(pet)
        end
    end)

    --AddPet() adds Pet to which ever client calls the function
    function SetPetTarget(target)
        print("Check SetPetTarget #1 - " .. target)
        setPetTargetRequest:FireServer(target)
    end

    setPetTargetResponse:Connect(function(player, target)
        print("Check SetPetTarget #3 - " .. target)
        if(player == client.localPlayer) then
            if(player.character.gameObject.transform:GetChild(2)) then
                local playerPet = player.character.gameObject.transform:GetChild(2):GetComponent(PetBehaviour)
                playerPet.FindAndSetTarget(target)
            end
        end
    end)

   local uiManager = GameObject.Find("UIManager")
   uiManagerScript = uiManager.gameObject:GetComponent(UIManager)
   uiPetInventory = uiManager.gameObject:GetComponent(UIPetInventory)
   TrackPlayers(client, OnCharacterInstantiate)
end

function self:ServerAwake()
    TrackPlayers(server)

    --SHELLS FUNCTIONS
    addShellsRequest:Connect(function(player, amount) -- Here the player is just the client that sent the request to the server, so when AddShells() is called it gives Shells to whoever calls it
        local playerInfo = players[player]
        local playerShell = playerInfo.shells.value
        local playerShell = playerShell + amount
        playerInfo.shells.value = playerShell
        addShellsResponse:FireAllClients(player, playerInfo.shells.value)
    end)

    verifyShellsAgainstRequest:Connect(function(player, amountToCompareTo, script) -- Here the player is just the client that sent the request to the server, so when VerifyShellsAgainst() is called it gives Shells to whoever calls it
        local playerInfo = players[player]
        local playerShell = playerInfo.shells.value
        
        if playerShell >= amountToCompareTo then 
            print(playerShell .. " shells are MORE OR EQUAL than required amount " .. amountToCompareTo)
            verifyShellsAgainstResponse:FireAllClients(player, 1, script)
        else
            print(playerShell .. " are LESS than required amount " .. amountToCompareTo)
            verifyShellsAgainstResponse:FireAllClients(player, 0, script)
        end
    end)

    --PEARLS FUNCTIONS
    addPearlsRequest:Connect(function(player, amount) -- Here the player is just the client that sent the request to the server, so when AddPearls() is called it gives Shells to whoever calls it
        local playerInfo = players[player]
        local playerPearl = playerInfo.pearls.value
        local playerPearl = playerPearl + amount
        playerInfo.pearls.value = playerPearl
        addPearlsResponse:FireAllClients(player, playerInfo.pearls.value)
    end)

    verifyPearlsAgainstRequest:Connect(function(player, amountToCompareTo) -- Here the player is just the client that sent the request to the server, so when VerifyPearlsAgainst() is called it gives Shells to whoever calls it
        local playerInfo = players[player]
        local playerPearl = playerInfo.pearls.value
        
        if playerPearl >= amountToCompareTo then 
            print(playerPearl .. " shells are MORE OR EQUAL than required amount " .. amountToCompareTo)
            return true
        else
            print(playerPearl .. " are LESS than required amount " .. amountToCompareTo)
            return false
        end
    end)

    --PETS FUNCTIONS
    addPetRequest:Connect(function(player, pet) -- Here the player is just the client that sent the request to the server, so when AddPet() is called it gives a Pet to whoever calls it
        local playerInfo = players[player]
        local playerPets = playerPets[player]
        print("Check AddPet #2 - " .. pet)
        for i=1,2 do
            playerPets[player] = {}

            for j=1,20 do
                print(playerPets[player][j])
                if(playerPets[player][j] == "" or playerPets[player][j] == nil) then
                    playerPets[player][j] = pet
                    addPetResponse:FireAllClients(player, pet)
                    break
                end
            end             
        end
    end)

    setPetTargetRequest:Connect(function(player, target) -- Here the player is just the client that sent the request to the server, so when AddPet() is called it gives a Pet to whoever calls it
        print("Check SetPetTarget #2 - " .. target)
        setPetTargetResponse:FireAllClients(player, target)
    end)
end