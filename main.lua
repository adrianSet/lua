require("TSLib")
local sz = require("sz")--写 showUI 前必须插入这一句
local socket = require ("szocket")
local json = sz.json--写 showUI 前必须插入这一句
--适配定义
local w,h = getScreenSize()
local sdw,sdh= 1536,2048
local pointFile 
if w==750 and h ==1334 then
	pointFile= require("6-6s-7-8")
	
elseif w==1536 and h ==2048 then
	pointFile= require("ipad")
else
	dialog("未适配的机型"..w..","..h)
	return
end


math.randomseed(tostring(os.time()):reverse():sub(1, 6))

local messagePath = "/var/mobile/Media/TouchSprite/res/messageStrs.txt"
local initMessage = "斗鱼互换斗鱼,一拳魂10 一轮结束 来老板,太鼓斗鱼换勾协助"
if not isFileExist(messagePath) then
	writeFileString(messagePath,initMessage,"w")

end

-----------------------------读取massageTables-------------------------------
local messageStrs = readFileString(messagePath)




function string.split(str, delimiter)
	if str==nil or str=='' or delimiter==nil then
		return nil
	end

	local result = {}
	for match in (str..delimiter):gmatch("(.-)"..delimiter) do
		table.insert(result, match)
	end
	return result
end



function coverRegin(s)
	local tab = string.split(s,",")
	local reginstr= ""
	for _,v in pairs(tab) do
		local pointTab = string.split(v,"|")
		local pstr = ""
		for k,j in pairs(pointTab) do
			if k==1 then
				pstr= pstr .. math.ceil(j*rx)

			elseif k==2 then
				pstr= pstr .. "|" .. math.ceil(j*ry) .. "|"

			elseif k==3 then
				pstr=pstr .. j
			end

		end
		if reginstr ~= "" then
			reginstr= reginstr .. "," .. pstr
		else
			reginstr= pstr
		end

	end
	return reginstr
end

function converTab(tab)
	local t = {}
	if #tab == 7 and type(tab[2]) == "string" and type(tab[1]) == "number" then 
		for k,v in pairs(tab) do
			if k==1 or k==3 then
				table.insert(t,v)
			elseif k==2 then
				table.insert(t,coverRegin(v)) 

			elseif k==4 or k==6 then
				table.insert(t,math.ceil(v*rx))
			elseif k==5 or k==7 then
				table.insert(t,math.ceil(v*ry))
			end
		end

		return t

	end


	for k,v in pairs(tab) do
		local _type = type(v) 
		if  _type~= "table"  then
			if (k == 1) and _type == "number" then
				if v<3000 then
					t[k]=math.ceil(v*rx)
				else
					t[k]=v
				end

			elseif (k == 2) and _type == "number" then
				if v<3000 then
					t[k]=math.ceil(v*ry)
				else
					t[k]=v
				end


			else
				t[k]=v
			end
		end

		if _type== "table" then
			t[k]=converTab(v)
		end

	end

	return t

end

local randomList={"qdf","w34","eese","rff","tgg","y","u","idb","o","p","a","s","d","f","g","h","j","k","lnn","z","ty","bn","v6","bn","n5","vb","1","2","hjk","4","hg","6","7","85","9","0"}


local pointList=pointFile.pointList
local activityList=pointFile.activityList
local stepStream=pointFile.stepStream



local eventListener={

}

local enum = {
	["activyStatus_bonus"]="bonus",
	["activyStatus_fight"]="fight",
	["activyStatus_standby"]="standby",
	["activyStatus_fuben"]="fuben",
	["activyStatus_tupo"]="tupo",
	["activyStatus_map"]="map",
	["activyStatus_index"]="index",
	["activyStatus_prepareOfGroup"]="prepareOfGroup",
	["activyStatus_inviteWin"]="inviteWin",
	["activyStatus_yulingWin"]="yulingWin",
	["activyStatus_chiWin"]="chiWin",

	["runTask_gouliang"]="gouliang",
	["runTask_yuhun"]="yuhun",
	["runTask_buy"]="buy",
}

local globalVariable ={
	["tupoIndex"]=0,
	["task"]={
		["model"]=-1,
		["currentTaskIndex"]=1,
		["taskList"]={},
	},
	["message"]={
		["channelIndex"]=1,

	},
	["addContext"]="",
	["activyStatus"]=enum["activyStatus_index"],
	["debug"]=true,
	["continuousOfFubenStatus"]=0,
}


local messageTable = {
}

local sleep= function(max,min)
	if min==nil then
		min=50
	end
	mSleep(math.random(min,max))


end


local debugToast = function(arg)
	if globalVariable.debug then
		toast(arg)
	end
end


function animation(pos1,pos2,spend)
	local tid = math.random(50,100)
	if spend==nil then
		spend=pointList["heroChange"]["littleConfig"]["spend"]
	end
	local zx = pos2[1] - pos1[1]
	local zy = pos2[2] - pos1[2]

	local tx = 0
	if zx>0 then
		tx = spend-5
	else 
		tx = -spend+5
	end

	local ty = 0
	if zy>0 then
		ty = spend
	else 
		ty = -spend
	end

	local cx,cy = pos1[1],pos1[2]

	local xtest, ytest = false,false
	touchDown(tid,pos1[1], pos1[2]) 
	repeat

		if not xtest then
			cx = cx+tx
		end

		if not ytest then
			cy = cy+ty
		end

		sleep(15,10)
		touchMove(tid,cx+math.random(1,2),cy+math.random(1,2))

		if tx >0  and cx>=pos2[1] then
			xtest = true

		end

		if tx <0  and cx<=pos2[1]then
			xtest = true

		end

		if ty >0  and cy>=pos2[2] then
			ytest = true

		end

		if ty <0  and cy<=pos2[2] then
			ytest = true

		end


	until(xtest and ytest)   

	touchUp(tid,cx, cy) 


end

MyTable = {
	["style"]        =  "default",
	["width"]        =  h,
	["height"]       =  w,
	["config"]       =  "save_01.dat",
	["rettype"]		 =  "table",
	["timer"]        =  99,
	["orient"]       =  2,
	["pagetype"]     =  "multi",
	["title"]        =  "YYS配置",
	["cancelname"]   =  "取消",
	["okname"]       =  "开始",
	pages            =
	{
		{
			{
				["type"] = "Label",
				["text"] = "全局设置",
				["size"] = 30,
				["align"] = "left",
				["color"] = "0,0,0",
			},
			{
				["type"] = "Label",
				["text"] = "模式选择",
				["size"] = 15,
				["align"] = "left",
				["color"] = "0,0,0",
			},
			{
				["type"] = "ComboBox",
				["list"] = "狗粮模式,通用战斗模式,购买达摩,结界抢坑,自动挂机突破,任务模式,活动模式",
				["select"] = "1",
				["source"] = "test",
				["id"] = "model"
			},
			{
				["type"] = "Label",
				["text"] = "自动邀请",
				["size"] = 15,
				["align"] = "left",
				["color"] = "0,0,0",
			},
			{
				["id"] = "autoInvite",
				["type"] = "CheckBoxGroup",
				["list"] = "我是队长",
				["select"] = "0",
			},
			{
				["id"] = "exitFubenOfseeBoss",
				["type"] = "CheckBoxGroup",
				["list"] = "看到超鬼王，停止/退出",
				["select"] = "0",
			},
			{
				["id"] = "selectedWood",
				["type"] = "CheckBoxGroup",
				["list"] = "选中丑女的木头人",
				["select"] = "0",
			},
			{
				["type"] = "Label",
				["text"] = "自动准备",
				["size"] = 15,
				["align"] = "left",
				["color"] = "0,0,0",
			},
			{
				["id"] = "autoPrepare",
				["type"] = "CheckBoxGroup",
				["list"] = "是否开启自动准备",
				["select"] = "0",
			},
			
			{
				["type"] = "Label",
				["text"] = "目标选择",
				["size"] = 15,
				["align"] = "left",
				["color"] = "0,0,0",
			},
			{
				["id"] = "autoTarget",
				["type"] = "CheckBoxGroup",
				["list"] = "是否开启目标选择",
				["select"] = "0",
			},
			{
				["width"] = 500,
				["id"] = "targetDelay",
				["type"] = "Edit",
				["prompt"] = "战斗目标选择频率",
				["text"] = "3",
				["kbtype"] = "number",

			},
			{
				["id"] = "selectTarget",
				["type"] = "RadioGroup",
				["list"] = "左(前排),中(前排),右(前排),左(后排),中(BOSS),右(后排),空白1,空白3(mid),御魂(右)",
				["select"] = "2",

			},

		},
		{
			{
				["type"] = "Label",
				["text"] = "聊天辅助",
				["size"] = 30,
				["align"] = "left",
				["color"] = "0,0,0",
			},
			{
				["id"] = "sendad",
				["type"] = "CheckBoxGroup",
				["list"] = "发广告",
				["select"] = "0",
			},
			{
				["type"] = "Label",
				["text"] = "内容选择",
				["size"] = 15,
				["align"] = "left",
				["color"] = "0,0,0",
			},
			{
				["type"] = "ComboBox",
				["list"] = messageStrs,
				["select"] = "1",
				["source"] = "test",
				["id"] = "adContent"
			},
			{

				["id"] = "ADrate",
				["type"] = "Edit",
				["prompt"] = "广告发布频率",
				["text"] = "3",
				["kbtype"] = "default",

			},
			{

				["id"] = "addAD",
				["type"] = "Edit",
				["prompt"] = "新增广告",
				["text"] = "3",
				["kbtype"] = "default",

			},
		},
		{
			{
				["type"] = "Label",
				["text"] = "狗粮设置",
				["size"] = 30,
				["align"] = "left",
				["color"] = "0,0,0",
			},
		},
		{
			{
				["type"] = "Label",
				["text"] = "活动活动",
				["size"] = 30,
				["align"] = "left",
				["color"] = "0,0,0",
			},
			{
				["type"] = "Label",
				["text"] = "内容选择",
				["size"] = 15,
				["align"] = "left",
				["color"] = "0,0,0",
			},
			{
				["id"] = "activityType",
				["type"] = "ComboBox",
				["list"] = "离岛-金币",
				["select"] = "0",
				["data"] = "离岛-金币",
				["source"] = "test"
			},
			{
				["width"] = 500,
				["id"] = "taskTimesOfActivity",
				["type"] = "Edit",
				["prompt"] = "循环次数",
				["text"] = "3",
				["kbtype"] = "number",

			},
		},
		{

			{
				["id"] = "autoTupo",
				["type"] = "CheckBoxGroup",
				["list"] = "是否自动挂机突破",
				["select"] = "",
				["size"] = 50,
			},

			{
				["type"] = "Label",
				["text"] = "勋章购买设置",
				["size"] = 30,
				["align"] = "left",
				["color"] = "0,0,0",
			},
			{
				["type"] = "Label",
				["text"] = "购买物品",
				["size"] = 20,
				["align"] = "left",
				["color"] = "0,0,0",
			},
			{
				["type"] = "ComboBox",
				["list"] = "草纸,经验达摩",
				["select"] = "1",
				["source"] = "test",
				["id"] = "buyGoods",
			}
		},
		{
			{
				["type"] = "Label",
				["text"] = "任务模式配置",
				["size"] = 30,
				["align"] = "left",
				["color"] = "0,0,0",
			},
			{
				["type"] = "Label",
				["text"] = "内容选择",
				["size"] = 15,
				["align"] = "left",
				["color"] = "0,0,0",
			},
			{
				["id"] = "fubenType",
				["type"] = "ComboBox",
				["list"] = "御魂,御灵,痴",
				["select"] = "0",
				["data"] = "魂10#龙,狗,黑豹,凤凰#痴",
				["source"] = "test"
			},
			{
				["id"] = "fubenId",
				["type"] = "ComboBox",
				["select"] = "0",
				["dataSource"] = "test"
			},
			{
				["width"] = 500,
				["id"] = "circleOfTask",
				["type"] = "Edit",
				["prompt"] = "循环次数",
				["text"] = "3",
				["kbtype"] = "number",

			},
		},
	}   
}

local registor =function(event,func,delay)
	eventListener[event]={}
	eventListener[event].func = func
	if delay==nil then
		delay=-1
	end 
	eventListener[event].delay = delay
end


local touchPos=function(pos,offset)
	local pos1=nil
	if offset==nil then
		pos1 = {pos[1]+math.random(30),pos[2]+math.random(31)} 

	else
		pos1 = {pos[1]+math.random(offset),pos[2]+math.random(offset)} 
	end

	touchDown(pos1[1],pos1[2])
	touchUp(pos1[1],pos1[2])
	mSleep(10+math.random(90));
end

function isColor(x,y,c,s)   --封装函数，函数名 isColor
	local fl,abs = math.floor,math.abs
	s = fl(0xff*(100-s)*0.01)
	local r,g,b = fl(c/0x10000),fl(c%0x10000/0x100),fl(c%0x100)
	local rr,gg,bb = getColorRGB(x,y)
	if abs(r-rr)<s and abs(g-gg)<s and abs(b-bb)<s then
		return true
	end
end

local mutilColorInRegionCover = function(tab)
	local xp,yp = findMultiColorInRegionFuzzy(tab[1], tab[2], tab[3], tab[4], tab[5],tab[6], tab[7])
	if xp ==-1 and yp==-1 then
		return nil
	end
	return xp,yp
end



local searchLevel1 = function(timeout)
    local beginTime = os.time()
	local spend = pointList["heroChange"]["littleConfig"]["spend"]
	local offset = pointList["heroChange"]["littleConfig"]["offset"]

	repeat
		keepScreen(true)
		local x,y = mutilColorInRegionCover(pointList.heroChange.search.screenView)



		::found::
		keepScreen(false)	
		if x~=nil then
			return x,y
		end
		if  os.time() - beginTime > timeout then
			return -1,-1
		end
		
		animation({pointList.heroChange.search.endd[1],pointList.heroChange.search.endd[2]+math.random(-15,15)},{pointList.heroChange.search.begin[1],pointList.heroChange.search.begin[2]+math.random(-15,15)},8)
		sleep(200,100)
	until (false)


end

local executeTask = function()

	local task = globalVariable.task.taskList[1]
	toast("当前处于map,准备进入副本,任务剩余次数为" .. task.remain)
	if task.remain>0 then
		sleep(800,500)
		local pos = task.target[#task.target]
		touchPos(pos)
		task.remain=task.remain-1
		sleep(5000,4000)
	else
		log("任务已执行完毕！")
	end

end
local init = function(tab)
	eventListener={}

	local model = tab["model"]
	globalVariable.task.model=tonumber(model)
	--******************事件注册*********************************

	local autoPrepare = tab["autoPrepare"]
	local exitFubenOfseeBoss = tab["exitFubenOfseeBoss"]
	local selectedWood = tab["selectedWood"]
	
	if selectedWood == "0" then
		registor("selectedWoodEvent",function(arg) 

				if multiColor(pointList.woodPeople.woodExists) then
					if not multiColor(pointList.woodPeople.selectedFlag) then
						touchPos({pointList.woodPeople.woodExists[1][1]+200,pointList.woodPeople.woodExists[1][2]})
						
					end
					
				end

			end,3)

	end
	
	

	if autoPrepare == "0" then
		registor("standardEvent",function(arg) 

				if not multiColor(pointList["preparedStatus"]) then
					touchPos(pointList["standard"]);
					globalVariable.activyStatus = enum.activyStatus_fight
				end

			end)

	end
	
	if tab["autoInvite"] == "0" then
		registor("captainEvent",function() 
					local flag=false
					repeat
						sleep(500,100)
						if exitFubenOfseeBoss == "0" then
							
							if multiColor(pointList["discoverBoss"]) then
								local serialList ={
									{ 1150, 1689, 0x100f0d},
									{  883,  836, 0xf3b25e},
								}
								sleep(500,100)
								touchPos(serialList[1])
								sleep(1000,500)
								touchPos(serialList[2])
								return
								
							end
							
							
							
							
						end
						local serialList =pointList.doEntryOfcouple
						if multiColor(serialList) then
							touchPos(serialList[1])
							flag=true
							globalVariable.activyStatus = enum.activyStatus_fight
						end
					until (flag)
			end,2);


	else
		registor("captainEvent",function() 
				if multiColor(pointList["pointerOfcaptainExit"]) then
					local serialList =pointList.doExitOfcouple
					touchPos(serialList[1])
					sleep(1000,500)
					touchPos(serialList[2])
				end
			end,10);


	end





	registor("taskIdentifyEvent",function() 
			touchPos(pointList["taskIdentify"][2]);
		end);

	

	registor("acceptGroupEvent",function(arg) 
			touchPos(pointList["acceptGroup"][4])
		end,3);



	if tab["addAD"] ~= nil then
		local _match = string.find(messageStrs,tab["addAD"])
		if _match == nil then
			messageStrs=messageStrs .. "," .. tab["addAD"]
			writeFileString(messagePath,messageStrs,"w")
			luaExit()
		end

	end
------------------发广告开关--------------------------
	if tab["sendad"] == "0" then
		local adContent = tab["adContent"]
		local adrate = tonumber(tab["ADrate"])


		messageTable = string.split(messageStrs,",")

		globalVariable["adContext"] = messageTable[tonumber(adContent)+1]

		registor("sendAdEvent",function(arg) 


			end,adrate);
	end


	--狗粮模式
	if model == "0" then
		--******************司机退出 退出副本*********************************	
		registor("isGroupEvent",function(arg) 
				touchPos(pointList["break"]["great"]);
				mSleep(600);
				touchPos(pointList.confirm.y);
			end,5);

		registor("everyLoopExecute",function(arg)

				if globalVariable.activyStatus==enum.activyStatus_fuben then
					globalVariable.continuousOfFubenStatus=globalVariable.continuousOfFubenStatus+1
				else
					globalVariable.continuousOfFubenStatus=0
				end
				if globalVariable.continuousOfFubenStatus==15 then
					touchPos(pointList["break"]["great"]);
					mSleep(600);
					touchPos(pointList.confirm.y);
					globalVariable.continuousOfFubenStatus=0
				end

			end,-1);


		registor("autoChangeExpGoodsEvent",function(arg) 

			end);


	end

	if tab["autoTarget"] == "0" then
		local targetIndex = tonumber(tab["selectTarget"])+1
		local delay = tonumber(tab["targetDelay"])
		registor("autoTargetEvent",function(arg)
				if "table" == type(pointList["target"][targetIndex][1])  then
					local plist = pointList["target"][targetIndex]
					touchPos(plist[math.random(1,#plist)])


				else
					touchPos(pointList["target"][targetIndex])
				end

			end,delay);

	end







	--御魂模式
	if model =="1" then



	end


--	--购买模式模式
--	if model =="2" then
--		local buyGoods = tab["buyGoods"]
--		local pos =nil
--		if buyGoods == "0" then
--			pos = pointList["buyExp"][1]
--		else
--			pos = pointList["buyExp"][2]
--		end


--		registor("buyExpEvent",function(arg) 
--				touchPos(pos)
--				mSleep(300)
--				touchPos(pointList["buyExp"][3])
--				mSleep(300)
--				touchPos(pointList["buyExp"][4])
--			end,2);

--	end

	--抢坑模式
	if model =="3" then
		waitBase =10
		local index =  tonumber(tab["feedIndex"])
		local _pos = pointList["feeded"]["heroListIndexPoint"][1]
		local offset = pointList["feeded"]["heroListIndexPoint"]["offset"]
		local pos = {_pos[1],_pos[2]-index*offset}

		registor("feedStatusEvent",function(arg)
				while(true) do
					if multiColor(pointList["feeded"]["status"]) then
						touchPos(pointList["feeded"]["status"][3])
						mSleep(550)
						touchPos(pos)
						mSleep(400)
						touchPos(pointList["feeded"]["y"])
					end
				end
			end);

	end


	--结界挂机模式
	if model =="4" then
		local is_status = tab["autoTupo"] 
		if is_status == "0" then
			local _pos = pointList["tupoDetail"][1]
			local offsetx = pointList["tupoDetail"]["offsetx"]
			local offsety = pointList["tupoDetail"]["offsety"]
			local attackOffset = pointList["tupoDetail"]["attackOffset"]


			registor("autoTupoEvent",function(arg)
					local index = arg[1]

					local pos = nil
					if index ==0 then
						pos = {_pos[1],_pos[2],_pos[3]}
					elseif index==1 then 
						pos = {_pos[1],_pos[2]-offsety,_pos[3]}
					elseif index==2 then 
						pos = {_pos[1],_pos[2]-2*offsety,_pos[3]}
					elseif index==3 then 
						pos = {_pos[1]+offsetx,_pos[2],_pos[3]}
					elseif index==4 then 
						pos = {_pos[1]+offsetx,_pos[2]-offsety,_pos[3]}
					elseif index==5 then 
						pos = {_pos[1]+offsetx,_pos[2]-2*offsety,_pos[3]}
					elseif index==6 then 
						pos = {_pos[1]+2*offsetx,_pos[2],_pos[3]}
					elseif index==7 then 
						pos = {_pos[1]+2*offsetx,_pos[2]-offsety,_pos[3]}
					elseif index==8 then 

						pos = {_pos[1]+2*offsetx,_pos[2]-2*offsety,_pos[3]}
					end
					if isColor(pos[1],pos[2],pos[3],90) then
						touchPos(pos)
						mSleep(500)	
						nLog(pos[1]+attackOffset[1] .. ":" .. pos[2]-attackOffset[2])
						touchPos({pos[1]+attackOffset[1],pos[2]-attackOffset[2]})
					end


				end);

		end



	end


	--任务模式
	if model =="5" then
		eventListener["acceptGroupEvent"]=nil


		local fubenType = tonumber(tab["fubenType"])
		local fubenId = tonumber(tab["fubenId"] )
		local circleOfTask = tonumber(tab["circleOfTask"])


		-------御魂副本
		if fubenType == 0 then

		end

		-------御灵副本
		if fubenType == 1 then
			local target = stepStream["yuling"][fubenId+1]
			local task = {["target"]=target,["remain"]=circleOfTask}
			table.insert(globalVariable.task.taskList,task)

			log("*****************任务模式已开启********************")
			registor("taskModelEvent",function(arg)


				end);


		end

		-------痴副本
		if fubenType == 2 then
			local target = stepStream["chi"]
			local task = {["target"]=target,["remain"]=circleOfTask}
			table.insert(globalVariable.task.taskList,task)

			log("*****************任务模式已开启********************")
			registor("taskModelEvent",function(arg)


				end);


		end



	end

	--活动模式
	if model =="6" then
		eventListener["acceptGroupEvent"]=nil


		local activityType = tonumber(tab["activityType"])
		local activityId = tonumber(tab["activityId"] )
		local taskTimesOfActivity = tonumber(tab["taskTimesOfActivity"])

		local scene = activityList[activityType+1]["scene"]
		pointList["activityModel"]=scene
		local target = activityList[activityType+1]["entrance"]
		local task = {["target"]=target,["remain"]=taskTimesOfActivity}
		table.insert(globalVariable.task.taskList,task)

		log("*****************任务模式已开启********************")


	end




end

local MyJsonString = json.encode(MyTable)
retTable = {showUI(MyJsonString)};

if retTable[1] then
	init(retTable[2])
end



local winStatus = 0
local calcCount = 0 
waitBase = 500

repeat
	local beginTime = socket.gettime()
	local x, y;
	local arg={}
	--******************状态检测*********************************


	if multiColor(pointList["fight"]) then
		globalVariable.activyStatus = enum.activyStatus_fight
	elseif multiColor(pointList["map"]) then
		globalVariable.activyStatus = enum.activyStatus_map
	elseif multiColor(pointList["index"]) then
		globalVariable.activyStatus = enum.activyStatus_index
	elseif multiColor(pointList["prepareOfGroup"]) then
		globalVariable.activyStatus = enum.activyStatus_prepareOfGroup
	elseif multiColor(pointList["inviteWin"]) then
		
		globalVariable.activyStatus = enum.activyStatus_inviteWin
	elseif multiColor(pointList["gotBonus2"]) then
		globalVariable.activyStatus = enum.activyStatus_bonus
	elseif multiColor(pointList["standby"]) then
		globalVariable.activyStatus = enum.activyStatus_standby
	elseif multiColor(pointList["fuben"]) then
		globalVariable.activyStatus = enum.activyStatus_fuben
	elseif multiColor(pointList["tupo"]) then
		globalVariable.activyStatus = enum.activyStatus_tupo
	elseif multiColor(pointList["yulingWin"]) then
		globalVariable.activyStatus = enum.activyStatus_yulingWin
	elseif multiColor(pointList["chiWin"]) then
		globalVariable.activyStatus = enum.activyStatus_chiWin
	elseif #pointList["activityModel"]~=0 and multiColor(pointList["activityModel"]) then
		globalVariable.activyStatus = enum.activyStatus_activityModel
	end



	--******************************************************************************************************
	if globalVariable.debug and calcCount%3==0  then 
		toast(globalVariable.activyStatus)
	end
	local listener;

	listener = eventListener.everyLoopExecute
	if listener~=nil  then
		listener.func(arg)	

	end
	if globalVariable.activyStatus == enum.activyStatus_standby then
		mSleep(500)

		listener = eventListener["autoChangeExpGoodsEvent"]

		--*************************************主狗粮切换****************************************************************

		if listener~=nil  then
			local rx,ry
			local targetExp={}

			rx = mutilColorInRegionCover(pointList.heroChange.mainChange.short1)

			if rx~=nil then
				table.insert(targetExp,1)
			end

			rx = mutilColorInRegionCover(pointList.heroChange.mainChange.short3)

			if rx~=nil then
				table.insert(targetExp,3)
			end
			if #targetExp~=0 then
				local selectedN =false
				local sceneOfUpToN=false
				repeat
					touchPos(pointList.heroChange.mainChange[1])
					sleep(100,50)
					touchPos(pointList.heroChange.mainChange[2])
					sleep(3200,3000)
					if multiColor(pointList.heroChange.sceneOfUpToN) then
						sceneOfUpToN=true
					end
				until (sceneOfUpToN)

				sleep(1200,1000)

				repeat
					if not multiColor(pointList.heroChange.ncard) then
						touchPos(pointList.heroChange.ncard[1])
						sleep(600,400)
						touchPos(pointList.heroChange.selectedn)
					end
					sleep(800,500)
					if multiColor(pointList.heroChange.ncard) then
						selectedN=true
					end

				until (selectedN)
				sleep(300,200)
				local begin =pointList.heroChange.search.preSelectedOfscreenBar.begin
				local endd =pointList.heroChange.search.preSelectedOfscreenBar.endd
				animation({ begin[1], begin[2]+math.random(-15,15)},{ endd[1], endd[2]+math.random(-15,15)},13)
				
				local x,y
				for i = 1,#targetExp do
					sleep(2000,1300)
					if i==1 then
						x,y = searchLevel1(15)
						if x==-1 then
							return
						end
					else
					
						y=y+100
					end
					
					local v= targetExp[i]
					local point = pointList.heroChange["sort"..v][1]
					--忘记   local expExpress = pointList.heroChange["sort"..v][2]
					animation({x,y},{point[1]+math.random(-30,30),point[2]+math.random(-30,30)})
					sleep(2000,1300)  
					
				end
				if x ~=-1 then
					touchPos(pointList["break"]["normal"])
				end
				

			end

		end
		local listener = eventListener["standardEvent"]
		if listener~=nil then
			listener.func(arg)
			mSleep(200)
		end

    elseif globalVariable.activyStatus == enum.activyStatus_fight then
        listener = eventListener["selectedWoodEvent"]
			if listener~=nil and calcCount%listener.delay==0 then
				listener.func(arg)
			end

		if not multiColor(pointList["fight"]) then
			local plist = pointList["target"][8]
			local cpoint = plist[math.random(1,#plist)]
			sleep(1500,1200)
			for i= 1,2 do
				touchPos(cpoint)
				sleep(50)
			end
		end


    elseif globalVariable.activyStatus==enum.activyStatus_prepareOfGroup  then
		listener = eventListener["captainEvent"]
		if listener~=nil and calcCount%listener.delay==0 then
			listener.func(arg)
		end
    elseif globalVariable.activyStatus==enum.activyStatus_inviteWin  then
		--sleep(1000,500)
		touchPos(pointList["inviteWin"][3])
		sleep(1000,500)
		touchPos(pointList["inviteWin"][2])
		globalVariable.activyStatus = enum.activyStatus_map


    elseif globalVariable.activyStatus==enum.activyStatus_bonus  then
		globalVariable.activyStatus = enum.activyStatus_map
		local plist = pointList["target"][8]
		local a =plist[math.random(1,#plist)]
		touchPos(a)
		sleep(50)
		touchPos(a)
		sleep(50)
		
	elseif globalVariable.activyStatus==enum.activyStatus_fuben  then
		--******************--是否在组队状态*********************************

		listener = eventListener["isGroupEvent"]
		if listener~=nil and calcCount%listener.delay==0 then

			if not multiColor(pointList["groupStatus"]) then
				sleep(500)
				if multiColor(pointList["fuben"]) then
					listener.func(arg)
				end

			end
		end
	elseif globalVariable.activyStatus==enum.activyStatus_tupo then

		listener = eventListener["autoTupoEvent"]
		if listener~=nil  then

			--local index = calcCount%9
			listener.func({globalVariable.tupoIndex})
			globalVariable.tupoIndex=globalVariable.tupoIndex+1
			if globalVariable.tupoIndex ==9 then 
				globalVariable.tupoIndex=0
			end
		end
	elseif globalVariable.activyStatus==enum.activyStatus_yulingWin then
		executeTask()
	elseif globalVariable.activyStatus==enum.activyStatus_chiWin then
		executeTask()

	elseif globalVariable.activyStatus==enum.activyStatus_activityModel then
		local task = globalVariable.task.taskList[1]
		toast("当前处于map,准备进入副本,任务剩余次数为" .. task.remain)
		if task.remain>0 then
			sleep(800,500)
			local pos = task.target
			touchPos(pos)
			task.remain=task.remain-1
			sleep(5000,4000)
		else
			log("任务已执行完毕！")
		end


	end

	listener = eventListener["acceptGroupEvent"]

	if listener~=nil and calcCount%listener.delay==0  then



		if  multiColor(pointList["acceptGroup"]) then
			if multiColor(pointList["acceptAutoGroup"]) then
				touchPos(pointList["acceptAutoGroup"][1])
			else
				listener.func() 
			end 

		end

	end

	

	listener = eventListener["feedStatusEvent"]
	if listener~=nil  then
		listener.func()
	end

	listener = eventListener["buyExpEvent"]
	if listener~=nil and calcCount%listener.delay==0 then

		listener.func()
	end

	listener = eventListener["taskIdentifyEvent"]
	if listener~=nil and multiColor(pointList["taskIdentify"])   then
		listener.func()
	end


	
	local endTime = socket.gettime()
	local executeTime = (endTime-beginTime)*1000

	if executeTime<waitBase then
		mSleep(waitBase-executeTime)
	end

	calcCount=calcCount+1
	if calcCount==100000 then calcCount=0 end



until(false)