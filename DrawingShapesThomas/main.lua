-- Title: Drawing shapes
-- Name: Thomas
-- Course: ICS2O/3C

-- set the background colour of the screen
display.setDefault("background", 160/255, 160/255, 160/255)

-- remove the status bar
display.setStatusBar(display.HiddenStatusBar)


local vTrapezoid = { -80, -80, 80, -80, 100, 90, -100, 90}
local Trapezoid = display.newPolygon(210, 192, vTrapezoid)

-- set the width of the border of the Trapezoid
Trapezoid.strokeWidth = 10

-- set the colour of the trapezoid
Trapezoid:setFillColor(0/255, 0/255, 255/255)

-- set the color of the border
Trapezoid:setStrokeColor(0/255, 0/255, 0/255)

local vTriangle = { 0, -100, -140, 0, 0, 100}
local Triangle = display.newPolygon(520, 192, vTriangle)

-- set the width of the border of the Triangle
Triangle.strokeWidth = 10

-- set the colour of the triangle
Triangle:setFillColor(255/255, 0/255, 0/255)

-- set the color of the border
Triangle:setStrokeColor(0/255, 0/255, 0/255)

local vPentagon = { 0, -80, 80, 0, 40, 80, -40, 80, -80, 0 }
local Pentagon = display.newPolygon(810, 192, vPentagon)

-- set the width of the border of the Pentagon
Pentagon.strokeWidth = 10

-- set the colour of the Pentagon
Pentagon:setFillColor(255/255, 255/255, 0/255)

-- set the color of the border
Pentagon:setStrokeColor(0/255, 0/255, 0/255)


local vHexagon = { -50,-50, 50, -50, 80, 0, 50, 50, -50, 50, -80, 0 }
local Hexagon = display.newPolygon(210, 500, vHexagon)

-- set the width of the border of the Hexagon
Hexagon.strokeWidth = 10

-- set the colour of the Hexagon
Hexagon:setFillColor(0/255, 255/255, 0/255)

-- set the color of the border
Hexagon:setStrokeColor(0/255, 0/255, 0/255)

local vOctogon = { -80, -100, 80, -100, 120, -60, 120, 60, 80, 100, -80, 100, -120, 60, -120, -60 }
local Octogon = display.newPolygon(520, 500, vOctogon)

-- set the width of the border of the Octogon
Octogon.strokeWidth = 10

-- set the colour of the octogon
Octogon:setFillColor(255/255, 128/255, 0/255)

-- set the color of the border
Octogon:setStrokeColor(0/255, 0/255, 0/255)



-- display text "Trapezoid"
textObject = display.newText("Trapezoid", 210, 350, nil, 50 )

-- sets the colour of the text
textObject:setTextColor(0/255, 0/255, 255/255)

-- display text "Triangle"
textObject = display.newText("Triangle", 510, 350, nil, 50 )

-- sets the colour of the text
textObject:setTextColor(255/255, 0/255, 0/255)

-- display text "Pentagon"
textObject = display.newText("Pentagon", 810, 350, nil, 50 )

-- sets the colour of the text
textObject:setTextColor(255/255, 255/255, 0/255)

-- display text "Hexagon"
textObject = display.newText("Hexagon", 210, 658, nil, 50 )

-- sets the colour of the text
textObject:setTextColor(0/255, 255/255, 0/255)

-- display text "octogon"
textObject = display.newText("Octogon", 520, 658, nil, 50 )

-- sets the colour of the text 
textObject:setTextColor(255/255, 128/255, 0/255)