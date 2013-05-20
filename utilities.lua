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
