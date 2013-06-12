dofile('utilities.lua')

local white = {255, 255, 255}
local black = {0, 0, 0}
local transparent = {0, 0, 0, 0}
local lablelTextColor = black

function love.load()
  screen = {}
  screen.width = love.graphics.getWidth()
  screen.height = love.graphics.getHeight()

  local minDimension = math.min(screen.width, screen.height)
  board = {}
  board.marginFromScreen = 20
  board.width = minDimension / 2 - board.marginFromScreen * 2
  board.height = board.width
  board.rankCount = 3
  board.outerCircleRatios = { 0.42, 0.65, 0.92 }
  board.numberOfFieldsOnCircles = 16
  board.fieldRadius = board.width / 16
  board.files = { {'A', 'F'}, {'B', 'E'}, {'C', 'H'}, {'D', 'G'} }

  local newFont = love.graphics.newFont(12)
  love.graphics.setFont(newFont)
  love.graphics.setBackgroundColor(white)
  board.labelCenterOffset = board.fieldRadius + newFont:getHeight()
end

function love.keypressed(key)
  if key == 'escape' then
    love.event.push('quit') -- Quit the game : <
  end
end

function love.draw()
  drawBoard()
end

function drawBoard()
  love.graphics.push()
  love.graphics.translate(screen.width/2, screen.height/2)
  for value = 1, board.rankCount do
    local currentCircle = Circle(0, 0, (board.outerCircleRatios[value] or 0) * board.width)
    Circle.drawFilledCircle(currentCircle, nil, black)

    local degreeStep = 2*math.pi / board.numberOfFieldsOnCircles
    love.graphics.push()
    love.graphics.rotate(degreeStep * 6)
    local startLetter = string.byte('A')
    for i = 1, board.numberOfFieldsOnCircles do
      love.graphics.rotate(degreeStep)
      Circle.drawFilledCircle(Circle(0, currentCircle.radius, board.fieldRadius), white, black)

      love.graphics.setColor(lablelTextColor)
      local currentFont = love.graphics.getFont()
      local labelText = string.char(startLetter)
      if i % 2 == 0 then
        labelText = labelText .. string.char(startLetter + 1)
        startLetter = startLetter + 1
      end
      labelText = labelText .. (board.rankCount - value + 1)

      love.graphics.print(labelText,
        currentFont:getWidth(labelText) / 2, 
        currentCircle.radius + currentFont:getHeight()/2 + board.labelCenterOffset,
        math.pi
      )
    end

    love.graphics.pop()
  end
  love.graphics.pop()
end

function math.toRadians(angleInDegrees)
  return angleInDegrees * math.pi / 180
end

--     love.graphics.setPointSize(5)
--     love.graphics.point(width/2, height/2)
