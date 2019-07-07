local tapCount = 0

local background = display.newImageRect("bkg_clouds.png", 360, 570)
background.x = display.contentCenterX
background.y = display.contentCenterY

local tapText = display.newText(tapCount, display.contentCenterX, 20, native.systemFont, 40)
tapText:setFillColor(0,0,0)

local floor = display.newImageRect("grass.png", 300, 50)
floor.x = display.contentCenterX
floor.y = display.contentHeight - 25

local balloon = display.newImageRect("balloon_yellow.png", 112, 112)
balloon.x = display.contentCenterX
balloon.y = display.contentCenterY
balloon.alpha = 0.8

local physics = require("physics")
physics.start()

physics.addBody(balloon, { radius=50, bounce = 0.3})
physics.addBody(floor, "static")

local function push()
  balloon:applyLinearImpulse(0, -0.75, balloon.x, balloon.y)
  tapCount = tapCount + 1
  tapText.text = tapCount
end

balloon:addEventListener("tap", push)