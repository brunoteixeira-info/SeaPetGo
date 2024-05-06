--!Type(UI)
--!Bind
local contPetObtained : UIImage = nil
--!Bind
local containerPetInventory : UIImage = nil
--!Bind
local textPetSlots : UILabel = nil
--!Bind
local containerPetSlot : UIButton = nil
--!Bind
local imagePetSlot : UIImage = nil
--!Bind
local textPetSlotRarity : UILabel = nil
--!Bind
local textPetSlotPower : UILabel = nil
--!Bind
local textButtonPetEquip : UILabel = nil
--!Bind
local textButtonPetRelease : UILabel = nil
--!Bind
local buttonPetEquip : UIButton = nil
--!Bind
local buttonPetRelease : UIButton = nil
--!Bind
local buttonCloseInventory : UIButton = nil
--!Bind
local buttonPlayerPets : UILabel = nil

textPetSlots:SetPrelocalizedText("Storage: 0/25")
textPetSlotRarity:SetPrelocalizedText("C")
textPetSlotPower:SetPrelocalizedText("50")
textButtonPetEquip:SetPrelocalizedText("Equip")
textButtonPetRelease:SetPrelocalizedText("Release")

function self:ClientStart()
    buttonPlayerPets:RegisterPressCallback(function () OpenInventory() end)
    buttonCloseInventory:RegisterPressCallback(function () CloseInventory() end)
    buttonPetEquip:RegisterPressCallback(function () EquipPet() end)
    buttonPetRelease:RegisterPressCallback(function () ReleasePet() end)
    containerPetInventory:AddToClassList("hide")
end

function CloseInventory()
    containerPetInventory:AddToClassList("hide")
    buttonPlayerPets:RemoveFromClassList("hide")
end

function OpenInventory()
    containerPetInventory:RemoveFromClassList("hide")
    buttonPlayerPets:AddToClassList("hide")
end

function AddNewPet(pet)
    print("Adding new Pet to Inventory")
    print("Check AddPet #3 - " .. pet)
    local slot = containerPetSlot.new()
    slot.AddToClassList("pet-inventory")
end

function EquipPet()
    print("Equipping Pet")
end

function ReleasePet()
    print("Releasing Pet from Inventory")
end