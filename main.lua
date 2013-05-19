function love.load()
  screen = {}
  screen.width = 800
  screen.height = 600

  local minDimension = math.min(screen.width, screen.height)
  board = {}
  board.width = minDimension / 2 - 20
  board.height = board.width
  board.outerCircleRatios = { 0.42, 0.65, 0.92 }
  board.numberOfFieldsOnCircles = 16
  board.fieldRadius = board.width / 16

  love.graphics.setBackgroundColor(255, 255, 255)
end

function love.conf(t)
	t.screen.width = screen.width
	t.screen.height = screen.height
end

function love.keypressed(key)
  if key == "escape" then
    love.event.push('quit') -- Quit the game : <
  end
end

function love.draw()
  for index, value in ipairs(board.outerCircleRatios) do
    local currentCircle = Circle(screen.width/2, screen.height/2, value * board.width)
    love.graphics.setColor(0, 0, 0)
    love.graphics.circle("line", currentCircle.centerX, currentCircle.centerY, currentCircle.radius)

    local degreeStep = 360 / board.numberOfFieldsOnCircles
    local currentDegree = 0

    for i = 1, board.numberOfFieldsOnCircles do
      local x, y = currentCircle:GetPointByAngle(math.toRadians(currentDegree))
      love.graphics.setColor(0, 0, 0)
      love.graphics.circle("line", x, y, board.fieldRadius)
      love.graphics.setColor(255, 255, 255)
      love.graphics.circle("fill", x, y, board.fieldRadius-1)
      currentDegree = currentDegree + degreeStep
    end
  end
end

function math.toRadians(angleInDegrees)
  return angleInDegrees * math.pi / 180
end

-- TODO: Extract this to new file? Circle class
Circle = {}
Circle.__index = Circle
setmetatable(Circle, { __call = function(_, ...) return Circle.new(...) end })

function Circle.new(x, y, radius)
  local newObject = {}
  setmetatable(newObject, Circle)
  newObject.centerX = x
  newObject.centerY = y
  newObject.radius = radius
  return newObject
end

function Circle:GetPointByAngle(angleInDegrees)
  local newX = self.centerX + self.radius * math.cos(angleInDegrees)
  local newY = self.centerY + self.radius * math.sin(angleInDegrees)
  return newX, newY
end
