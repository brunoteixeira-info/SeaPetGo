--!Type(UI)
--!Bind
local buttonJoystick_1 : UIButton = nil
--!Bind
local imageJoystick_1 : UIImage = nil
--!Bind
local buttonJoystick_2 : UIButton = nil
--!Bind
local imageJoystick_2 : UIImage = nil
--!Bind
local buttonJoystick_3 : UIButton = nil
--!Bind
local imageJoystick_3 : UIImage = nil
--!Bind
local buttonJoystick_4 : UIButton = nil
--!Bind
local imageJoystick_4 : UIImage = nil
--!Bind
local buttonJoystick_5 : UIButton = nil
--!Bind
local imageJoystick_5 : UIImage = nil
--!Bind
local buttonJoystick_6 : UIButton = nil
--!Bind
local imageJoystick_6 : UIImage = nil
--!Bind
local buttonJoystick_7 : UIButton = nil
--!Bind
local imageJoystick_7 : UIImage = nil
--!Bind
local buttonJoystick_8 : UIButton = nil
--!Bind
local imageJoystick_8 : UIImage = nil
--!Bind
local buttonJoystick_9 : UIButton = nil
--!Bind
local imageJoystick_9 : UIImage = nil

--!SerializeField
local spriteJoystick_1 : Texture = nil
--!SerializeField
local spriteJoystick_1H : Texture = nil
--!SerializeField
local spriteJoystick_2 : Texture = nil
--!SerializeField
local spriteJoystick_2H : Texture = nil
--!SerializeField
local spriteJoystick_3 : Texture = nil
--!SerializeField
local spriteJoystick_3H : Texture = nil
--!SerializeField
local spriteJoystick_4 : Texture = nil
--!SerializeField
local spriteJoystick_4H : Texture = nil
--!SerializeField
local spriteJoystick_5 : Texture = nil
--!SerializeField
local spriteJoystick_5H : Texture = nil
--!SerializeField
local spriteJoystick_6 : Texture = nil
--!SerializeField
local spriteJoystick_6H : Texture = nil
--!SerializeField
local spriteJoystick_7 : Texture = nil
--!SerializeField
local spriteJoystick_7H : Texture = nil
--!SerializeField
local spriteJoystick_8 : Texture = nil
--!SerializeField
local spriteJoystick_8H : Texture = nil
--!SerializeField
local spriteJoystick_9 : Texture = nil
--!SerializeField
local spriteJoystick_9H : Texture = nil

arrayJoysticks = {}

Joystick_1 = { direction = 1, button = buttonJoystick_1, image = imageJoystick_1, sprite = spriteJoystick_1, spriteHighlighted = spriteJoystick_1H }
Joystick_2 = { direction = 2, button = buttonJoystick_2, image = imageJoystick_2, sprite = spriteJoystick_2, spriteHighlighted = spriteJoystick_2H }
Joystick_3 = { direction = 3, button = buttonJoystick_3, image = imageJoystick_3, sprite = spriteJoystick_3, spriteHighlighted = spriteJoystick_3H }
Joystick_4 = { direction = 4, button = buttonJoystick_4, image = imageJoystick_4, sprite = spriteJoystick_4, spriteHighlighted = spriteJoystick_4H }
Joystick_5 = { direction = 5, button = buttonJoystick_5, image = imageJoystick_5, sprite = spriteJoystick_5, spriteHighlighted = spriteJoystick_5H }
Joystick_6 = { direction = 6, button = buttonJoystick_6, image = imageJoystick_6, sprite = spriteJoystick_6, spriteHighlighted = spriteJoystick_6H }
Joystick_7 = { direction = 7, button = buttonJoystick_7, image = imageJoystick_7, sprite = spriteJoystick_7, spriteHighlighted = spriteJoystick_7H }
Joystick_8 = { direction = 8, button = buttonJoystick_8, image = imageJoystick_8, sprite = spriteJoystick_8, spriteHighlighted = spriteJoystick_8H }
Joystick_9 = { direction = 9, button = buttonJoystick_9, image = imageJoystick_9, sprite = spriteJoystick_9, spriteHighlighted = spriteJoystick_9H }

arrayJoysticks = { Joystick_1, Joystick_2, Joystick_3, Joystick_4, Joystick_5, Joystick_6, Joystick_7, Joystick_8, Joystick_9 }

function self:ClientStart()
    arrayJoysticks[1].image.image = arrayJoysticks[1].sprite
    arrayJoysticks[1].button:RegisterPressCallback(function () MovePlayer(Vector3.new(10, 0, 10), 1) end)
    arrayJoysticks[2].image.image = arrayJoysticks[2].sprite
    arrayJoysticks[2].button:RegisterPressCallback(function () MovePlayer(Vector3.new(10, 0, 0), 2) end)
    arrayJoysticks[3].image.image = arrayJoysticks[3].sprite
    arrayJoysticks[3].button:RegisterPressCallback(function () MovePlayer(Vector3.new(10, 0, -10), 3) end)
    arrayJoysticks[4].image.image = arrayJoysticks[4].sprite
    arrayJoysticks[4].button:RegisterPressCallback(function () MovePlayer(Vector3.new(0, 0, 10), 4) end)
    arrayJoysticks[5].image.image = arrayJoysticks[5].sprite
    arrayJoysticks[5].button:RegisterPressCallback(function () MovePlayer(Vector3.new(0, 0, 0), 5) end)
    arrayJoysticks[6].image.image = arrayJoysticks[6].sprite
    arrayJoysticks[6].button:RegisterPressCallback(function () MovePlayer(Vector3.new(0, 0, -10), 6) end)
    arrayJoysticks[7].image.image = arrayJoysticks[7].sprite
    arrayJoysticks[7].button:RegisterPressCallback(function () MovePlayer(Vector3.new(-10, 0, 10), 7) end)
    arrayJoysticks[8].image.image = arrayJoysticks[8].sprite
    arrayJoysticks[8].button:RegisterPressCallback(function () MovePlayer(Vector3.new(-10, 0, 0), 8) end)
    arrayJoysticks[9].image.image = arrayJoysticks[9].sprite
    arrayJoysticks[9].button:RegisterPressCallback(function () MovePlayer(Vector3.new(-10, 0, -10), 9) end)
end

function MovePlayer(direction, joystickDir)
    print("Direction: " .. joystickDir)
    playerPos = client.localPlayer.character.transform.localPosition
    client.localPlayer.character.MoveTo(client.localPlayer.character, Vector3.new(playerPos.x + direction.x, playerPos.y, playerPos.z + direction.z), -1, 0, function() end)

    for i = 1, #arrayJoysticks do
        if(arrayJoysticks[i].direction == joystickDir) then
            arrayJoysticks[i].image.image = arrayJoysticks[i].spriteHighlighted
        else
            arrayJoysticks[i].image.image = arrayJoysticks[i].sprite
        end
    end 
end