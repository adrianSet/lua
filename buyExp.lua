require("TSLib")

local touchPos=function(pos)
	local pos1 = {["x"]=pos.x+math.random(10),["y"]=pos.y+math.random(10)}
	touchDown(6,pos1.x,pos1.y)
	touchUp(6,pos1.x,pos1.y)
	mSleep(10);
end


repeat
	touchPos({ x=742,  y=365, 0x5c534b})
	mSleep(300)
	touchPos({  x=941,  y=993, 0x393125})
	mSleep(300)
	touchPos({  x=742,  y=365, 0x5c534b})
until (false)