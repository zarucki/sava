dofile('utilities.lua')
white = {255, 255, 255}
black = {0, 0, 0}

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

  love.graphics.setBackgroundColor(white)
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
    love.graphics.setColor(black)
    love.graphics.circle("line", currentCircle.centerX, currentCircle.centerY, currentCircle.radius)

    local degreeStep = 360 / board.numberOfFieldsOnCircles
    local currentDegree = 0

    for i = 1, board.numberOfFieldsOnCircles do
      local x, y = currentCircle:GetPointByAngle(math.toRadians(currentDegree))
      drawShapeWithContour(black, white, board.fieldRadius,
        function (fillMode, radius)
          love.graphics.circle(fillMode, x, y, radius)
        end)
      -- love.graphics.setColor(0, 0, 0)
      -- love.graphics.circle("line", x, y, board.fieldRadius)
      -- love.graphics.setColor(255, 255, 255)
      -- love.graphics.circle("fill", x, y, board.fieldRadius - love.graphics.getLineWidth())
      currentDegree = currentDegree + degreeStep
    end
  end
end

function drawShapeWithContour(contourColor, fillColor, radius, drawShapeFunction)
  love.graphics.setColor(contourColor)
  drawShapeFunction("line", radius)

  love.graphics.setColor(fillColor)
  drawShapeFunction("fill", radius - love.graphics.getLineWidth())
end

function math.toRadians(angleInDegrees)
  return angleInDegrees * math.pi / 180
end
