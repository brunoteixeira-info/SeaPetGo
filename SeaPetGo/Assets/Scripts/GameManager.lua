addShellsRequest = Event.new("AddShellsRequest")
verifyShellsAgainstRequest = Event.new("VerifyShellsAgainst")

players = {}
playerShells = {}

--!SerializeField
--local uiManagerScript : LuaScript = nil

local function TrackPlayers(game, characterCallback)
    scene.PlayerJoined:Connect(function(scene, player)
        players[player] = {
            player = player,
            shells = IntValue.new("shells" .. tostring(player.id), 20)
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
    end)
end

function self:ClientAwake()
    function OnCharacterInstantiate(playerinfo)
        local player = playerinfo.player
        local character = player.character
    end

   --AddShells() adds Shells to which ever client calls the function
   function AddShells(amount)
    addShellsRequest:FireServer(amount)
   end

   function VerifyShellsAgainst(amountToCompareTo)
    verifyShellsAgainstRequest:FireServer(amountToCompareTo)
   end

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

    verifyShellsAgainstRequest:Connect(function(player, amountToCompareTo) -- Here the player is just the client that sent the request to the server, so when AddShells() is called it gives Shells to whoever calls it
        local playerInfo = players[player]
        local playerShell = playerInfo.shells.value
        
        if playerShell >= amountToCompareTo then 
            print("MORE OR EQUAL Shells than amount")
            return true
        else
            print("LESS Shells than amount")
            return false
        end
    end)
end