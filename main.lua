RAND = math.random
math.randomseed( os.time() )
local bars ={}

local function NewBar( x,y,width,height,speed )
	local tempRect = display.newRect( x, y, width, height )
	tempRect.anchorX = 0

	local function NewScale()
		transition.cancel(tempRect.transition)
		tempRect.transition = transition.to( tempRect, {time=speed*.75,xScale = RAND(1,4) } )
	end
	tempRect.transition = transition.to( tempRect, {time=speed*.75,xScale = RAND(1,4) } )
	tempRect.timer = timer.performWithDelay( speed+RAND(1,10)*10, NewScale, -1 )
	table.insert( bars,tempRect)
end


for i=1,100 do
	local height = 10
	local myBar = NewBar(1,i*(height*1.75),100,10,500)
end

-- Clean up function
function DestroyAllBars()
	for k,v in pairs(bars) do
		timer.cancel( v.timer )
		transition.cancel( v.transition )
		v:removeSelf()
	end
end

-- For testing purposes, we'll destroy all the test
-- bars after 10 seconds
timer.performWithDelay( 10000, DestroyAllBars, 1 )
