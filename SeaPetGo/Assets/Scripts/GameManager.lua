addShellsRequest = Event.new("AddShellsRequest")
verifyShellsAgainstRequest = Event.new("VerifyShellsAgainst")
verifyShellsAgainstResponse = Event.new("VerifyShellsAgainstResponse")

addPearlsRequest = Event.new("AddPearlsRequest")
verifyPearlsAgainstRequest = Event.new("VerifyPearlsAgainst")

players = {}
playerShells = {}
playerPearls = {}
playerPets = {}

local uiManagerScript : UIManager

local function TrackPlayers(game, characterCallback)
    scene.PlayerJoined:Connect(function(scene, player)
        players[player] = {
            player = player,
            shells = IntValue.new("shells" .. tostring(player.id), 10),
            pearls = IntValue.new("pearls" .. tostring(player.id), 0)
        }

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
        playerShells[player] = nil
        playerPearls[player] = nil
    end)
end

function self:ClientAwake()
    function OnCharacterInstantiate(playerinfo)
        local player = playerinfo.player
        local character = player.character
    end

   --AddShells() adds Shells to whichever client calls the function
   function AddShells(amount)
    addShellsRequest:FireServer(amount)
   end

    --VerifyShellsAgainst() compares current shells that the Player has against a specific amount, returning true if there's more or equal shells than the amount to whichever client calls the function
   function VerifyShellsAgainst(amountToCompareTo, script)
    verifyShellsAgainstRequest:FireServer(amountToCompareTo, script)
   end

    verifyShellsAgainstResponse:Connect(function(player, response, script)
        if(player == client.localPlayer) then
            script.ManagerResponse(response)
        end
    end)

    --AddPearls() adds Shells to which ever client calls the function
    function AddPearls(amount)
        addPearlsRequest:FireServer(amount)
    end
    
    --VerifyPearlsAgainst() compares current pearls that the Player has against a specific amount, returning true if there's more or equal pearls than the amount to whichever client calls the function
    function VerifyPearlsAgainst(amountToCompareTo)
        verifyPearlsAgainstRequest:FireServer(amountToCompareTo)
    end

   local uiManager = GameObject.Find("UIManager")
   uiManagerScript = uiManager.gameObject:GetComponent(UIManager)
   TrackPlayers(client, OnCharacterInstantiate)
end

function self:ServerAwake()
    TrackPlayers(server)

    addShellsRequest:Connect(function(player, amount) -- Here the player is just the client that sent the request to the server, so when AddShells() is called it gives Shells to whoever calls it
        local playerInfo = players[player]
        local playerShell = playerInfo.shells.value
        local playerShell = playerShell + amount
        playerInfo.shells.value = playerShell
        --uiManagerScript.SetPlayerShells(playerInfo.shells.value)
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

    addShellsRequest:Connect(function(player, amount) -- Here the player is just the client that sent the request to the server, so when AddPearls() is called it gives Shells to whoever calls it
        local playerInfo = players[player]
        local playerPearl = playerInfo.pearls.value
        local playerPearl = playerPearl + amount
        playerInfo.pearls.value = playerPearl
        --uiManagerScript.SetPlayerPearls(playerInfo.pearls.value)
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
end