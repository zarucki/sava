Circle = {}
Circle.__index = Circle
setmetatable(Circle, {
  __call = function(_, ...)
    return Circle.new(...)
  end
})

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

function Circle:__tostring()
  return 'centerX: ' .. self.centerX .. ', centerY: ' .. self.centerY .. ', radius: ' .. self.radius
end

function love.graphics.FilledCircle(circle, fillColor, countourColor)
  local circleRadius = circle.radius
  if countourColor then
    love.graphics.setColor(countourColor)
    love.graphics.circle("line", circle.centerX, circle.centerY, circleRadius)
    circleRadius = circleRadius - love.graphics.getLineWidth()
  end

  if fillColor then
    love.graphics.setColor(fillColor)
    love.graphics.circle("fill", circle.centerX, circle.centerY, circleRadius)
  end
end
