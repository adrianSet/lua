

math.randomseed(tostring(os.time()):reverse():sub(1, 6))  
local eventListener={
	
}

local registor =function(event,func,delay)
		eventListener[event]={}
		eventListener[event].func = func
		if delay==nil then
			delay=-1
		end 
		eventListener[event].delay = delay
end

local touchPos=function(pos)
	local pos1 = {["x"]=pos.x+math.random(10),["y"]=pos.y+math.random(10)}
	touchDown(6,pos1.x,pos1.y)
	touchUp(6,pos1.x,pos1.y)
	mSleep(10);
end


local pointList={
	["standard"]={x=1235,y=93},
	["mid"]={x=369,y=940},
	["right"]={x=431,y=686},
	["blank"]={x=1134,y=1912},
	["break"]={x=105,y=1966},
	["isGroupA"]={{x=218,y=1944,color=0xffffff},{x=254,y=2007,color=0xffffff},{x=261,y=1975,color=0xffebdf}},
	["isGroupB"]={{x=395,y=1948,color=0xffffff},{x=426,y=2004,color=0xffffff},{x=444,y=1975,color=0xffebdf}},
	["isGroupC"]={{x=1421,y=439,color=0x2c2017},{x=1425,y=472,color=0x603f21},{x=1419,y=387,color=0xf2edda}},
	["confirm"]={["y"]={x=837,y=803},["n"]={x=832,y=1250}}, 
}
 


--******************事件注册*********************************

	--******************司机退出 退出副本*********************************	
--registor("isGroupEvent",function(arg) 
--		touchPos(pointList["break"]);
--		mSleep(800);
--		touchPos(pointList.confirm.y);
--	end,10);


--registor("clickRightEvent",function(arg) 
--			touchPos(pointList["right"]);
--		end,3);


registor("clickMidEvent",function(arg) 
			touchPos(pointList["mid"]);
		end,5);




registor("standardEvent",function(arg) 
			touchPos(pointList["standard"]);
		end);



registor("acceptGroupEvent",function(arg) 
			touchPos(arg);
		end);
	




local calcCount=0 

repeat
	local x, y;
	local arg={["x"]=-1,["y"]=-1}
	--******************准备扫描 是否准备*********************************
	
	x, y = findImageInRegionFuzzy("standard.png", 10, 1183,   53,  1373,  280, 0); 
	if x~=-1 and y~=-1 then
		local listener = eventListener["standardEvent"]
		if listener~=nil then
			listener.func(arg)
		end
	end
	
	--******************-- 接受组队*********************************
	x, y = findImageInRegionFuzzy("accpet.png",10,366,1776,452,1868, 0); 
	if x~=-1 and y~=-1 then
		local listener = eventListener["acceptGroupEvent"]
		if listener~=nil then
			arg.x,arg.y=x,y
			listener.func(arg)
		end
	end
	
	local listener;
	--******************--是否在组队状态*********************************
	
	listener = eventListener["isGroupEvent"]
	if listener~=nil and calcCount%listener.delay==0 then
		
		--x, y = findImageInRegionFuzzy("groupB.png", 10,1399,  304,   1446,  398,0); 
		 local groupCStatus =1
		 for _,v in ipairs(pointList["isGroupC"]) do
				if v.color ~= getColor(v.x,v.y) then
					groupCStatus =0
				end
		end 
		
		toast(groupCStatus); 
		if groupCStatus ==1 then
			local groupAStatus =1;
			local groupBStatus =1;
			 for _,v in ipairs(pointList["isGroupA"]) do
				if v.color ~= getColor(v.x,v.y) then
					groupAStatus =0
				end
			 end
		
			for _,v in ipairs(pointList["isGroupB"]) do
				if v.color ~= getColor(v.x,v.y) then
					groupBStatus =0
				end
			
			end
			
			if groupAStatus==0 and groupBStatus==0 then
				listener.func(arg)
			end
		end	
	end
		 
	listener = eventListener["clickMidEvent"]
	if listener~=nil and calcCount%listener.delay==0 then
			listener.func(arg)
	end
	
	listener = eventListener["clickRightEvent"]
	if listener~=nil and calcCount%listener.delay==0 then
			listener.func(arg)
	end
	
	
	mSleep(300);
	calcCount=calcCount+1
	if calcCount==100000 then calcCount=0 end
until(false)
	





