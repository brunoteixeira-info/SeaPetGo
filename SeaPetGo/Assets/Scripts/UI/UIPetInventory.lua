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
local textPetEquipped : UILabel = nil
--!Bind
local buttonPetEquip : UIButton = nil
--!Bind
local buttonPetRelease : UIButton = nil
--!Bind
local buttonCloseInventory : UIButton = nil
--!Bind
local buttonPlayerPets : UILabel = nil

local petAmount : number = 0

textPetEquipped:SetPrelocalizedText("")
textPetSlotRarity:SetPrelocalizedText("C")
textPetSlotPower:SetPrelocalizedText("50")
textButtonPetEquip:SetPrelocalizedText("Equip")
textButtonPetRelease:SetPrelocalizedText("Release")

function self:ClientStart()
    textPetSlots:SetPrelocalizedText("Storage: " .. petAmount .. "/25")
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
    CreatePetSlot()
end

function EquipPet()
    print("Equipping Pet")
end

function ReleasePet()
    print("Releasing Pet from Inventory")
end

function CreatePetSlot()
    print("Creating Pet Slot in Inventory")

    local slotPet = UIButton.new()
    slotPet:AddToClassList("containerPetSlot")
    containerPetInventory:Add(slotPet)
    
    local imageSlotPet = UIImage.new()
    imageSlotPet:AddToClassList("imagePetSlot")
    slotPet:Add(imageSlotPet)

    --local textSlotPetRarity = UILabel.new()
    --textSlotPetRarity:AddToClassList("textPetSlotRarity")
    --imageSlotPet:Add(textSlotPetRarity)

    --local textPetSlotPower = UILabel.new()
    --textPetSlotPower:AddToClassList("textPetSlotPower")
    --imageSlotPet:Add(textPetSlotPower)

    petAmount = petAmount + 1
    textPetSlots:SetPrelocalizedText("Storage: " .. petAmount .. "/25")
end