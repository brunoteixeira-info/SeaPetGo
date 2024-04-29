--!SerializeField
local inventoryScript : LuaScript = nil

scene.PlayerJoined:Connect(function(scene, player)
    player.CharacterChanged:Connect(function(player, newCharacter, oldCharacter)
        newCharacter.gameObject:AddScript(inventoryScript);
    end)
end)