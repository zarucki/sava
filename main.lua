dofile('utilities.lua')
white = {255, 255, 255}
black = {0, 0, 0}
transparent = {0, 0, 0, 0}
lablelTextColor = black

function love.load()
  screen = {}
  screen.width = 800
  screen.height = 600

  local minDimension = math.min(screen.width, screen.height)
  board = {}
  board.width = minDimension / 2 - 20
  board.height = board.width
  board.rankCount = 3
  board.outerCircleRatios = { 0.42, 0.65, 0.92 }
  board.numberOfFieldsOnCircles = 16
  board.fieldRadius = board.width / 16
  board.files = { {'A', 'F'}, {'B', 'E'}, {'C', 'H'}, {'D', 'G'} }
  board.labelCenterOffset = 35

  love.graphics.setFont(love.graphics.newFont(10))
  love.graphics.setBackgroundColor(white)
end

function love.conf(t)
  t.screen.width = screen.width
  t.screen.height = screen.height
end

function love.keypressed(key)
  if key == 'escape' then
    love.event.push('quit') -- Quit the game : <
  end
end

function love.draw()
  love.graphics.setColor(black)

  for value = 1, board.rankCount do
    local currentRankRadius = (board.outerCircleRatios[value] or 0) * board.width
    local currentCircle = Circle(screen.width/2, screen.height/2, currentRankRadius)
    local circleForLabels = Circle(screen.width/2, screen.height/2, currentRankRadius + board.labelCenterOffset)
    love.graphics.FilledCircle(currentCircle, nil, black)

    local degreeStep = 360 / board.numberOfFieldsOnCircles
    local currentDegree = 0

    for i = 1, board.numberOfFieldsOnCircles do
      local x, y = currentCircle:GetPointByAngle(math.toRadians(currentDegree))
      love.graphics.FilledCircle(Circle(x, y, board.fieldRadius), white, black)

      local labelX, labelY = circleForLabels:GetPointByAngle(math.toRadians(currentDegree))
      love.graphics.setColor(lablelTextColor)
      local currentFont = love.graphics.getFont()
      love.graphics.print('AB1', labelX - currentFont:getWidth('AB1') / 2, labelY, math.toRadians(currentDegree + 90), 1)
      currentDegree = currentDegree + degreeStep
    end
  end
end

function math.toRadians(angleInDegrees)
  return angleInDegrees * math.pi / 180
end
