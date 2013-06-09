--[[ custom ]]
-- based on scripts by aj kelly; ad-hoc userprefs by asg

local prefBasePath = "Data/UserPrefs/CyberiaStyle8/";

envTable = GAMESTATE:Env()
-- env
function setenv(name,value) envTable[name] = value end
function getenv(name) return envTable[name] end

-- sodasweets2
-- file (assume stepmania 4 alpha 5)
function WriteFile(path,buf)
	local f = RageFileUtil.CreateRageFile()
	if f:Open(path, 2) then
		f:Write( tostring(buf) )
		f:destroy()
		return true
	else
		Trace( "[FileUtils] Error writing to ".. path ..": ".. f:GetError() )
		f:ClearError()
		f:destroy()
		return false
	end
end

function ReadFile(path)
	local f = RageFileUtil.CreateRageFile()
	local ret = ""
	if f:Open(path, 1) then
		ret = tostring( f:Read() )
		f:destroy()
		return ret
	else
		Trace( "[FileUtils] Error reading from ".. path ..": ".. f:GetError() )
		f:ClearError()
		f:destroy()
		return nil
	end
end

-- ad-hoc userprefs implementation
function SetAdhocPref(pref,val)
	WriteFile(prefBasePath..pref,val)
	setenv(pref,val)
end

function GetAdhocPref(pref)
	if getenv(pref) ~= nil then
		return getenv(pref)
	else
		local res = ReadFile(prefBasePath..pref)
		return res
	end
end

function InitPrefCSTitle()
	local prefs = {
		Enable3DModels = 'Off',
	}
	for k,v in pairs(prefs) do
		if GetAdhocPref(k) == nil then
			SetAdhocPref(k,v);
		end;
	end;
end;

function InitPrefsCS()
	--[[on,off,off,cs6,default,1point,off,off]]
	local prefs = {
		ShowJackets = 'On',
		IngameStatsP1 = 'Off',
		IngameStatsP2 = 'Off',
		CustomSpeed = 'CS6',
		UserMeterType = 'Default',
		HoldArrowJudge = '1Point',
		ScreenFilterP1 = 'Off',
		ScreenFilterP2 = 'Off',
		ScoreGraphP1 = 'Off',
		ScoreGraphP2 = 'Off',
		BGScale = 'Fit',
		CSCreditFlag = '0',
		CSFrameFlag = '0',
		FrameSet = 'Default',
		CSSetApp = '15135419',
	}
	for k,v in pairs(prefs) do
		if GetAdhocPref(k) == nil then
			SetAdhocPref(k,v)
		end
	end
	local cap_path = "CSDataSave/0001_cc CSApp"
	if File.Read( cap_path ) then SetAdhocPref("CSSetApp","00000001")
	end
end

InitPrefsCS();
InitPrefCSTitle();

function OptionRow3DModels()
	local t = {
		Name = "Enable3DModels";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = false;
		Choices = { 'Off','On' },
		LoadSelections = function(self, list, pn)
			if GetAdhocPref("Enable3DModels") ~= nil then
				local curSet = GetAdhocPref("Enable3DModels")
				if curSet == 'Off' then
					list[1] = true
				elseif curSet == 'On' then
					list[2] = true
				else
					list[1] = true
				end;
			else
				list[1] = true
			end
		end;
		SaveSelections = function(self, list, pn)
			local tChoices = { 'Off','On' }
			local val
			if list[1] then
				val = tChoices[1]
			elseif list[2] then
				val = tChoices[2]
			else
				val = tChoices[1]
			end
			SetAdhocPref("Enable3DModels",val)
			MESSAGEMAN:Broadcast("PreferenceSet", { Message == "Set Preference" })
			THEME:ReloadMetrics()
		end;
	};
	setmetatable( t, t )
	return t;
end;

function ShowJackets()
	local t = {
		Name = "ShowJackets",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = { 'Off','On' },
		LoadSelections = function(self, list, pn)
			if GetAdhocPref("ShowJackets") ~= nil then
				local curSet = GetAdhocPref("ShowJackets")
				if curSet == 'Off' then
					list[1] = true
				elseif curSet == 'On' then
					list[2] = true
				else
					list[1] = true
				end;
			else
				list[1] = true
			end
		end;
		SaveSelections = function(self, list, pn)
			local tChoices = { 'Off','On' }
			local val
			if list[1] then
				val = tChoices[1]
			elseif list[2] then
				val = tChoices[2]
			else
				val = tChoices[1]
			end
			SetAdhocPref("ShowJackets",val)
			MESSAGEMAN:Broadcast("PreferenceSet", { Message == "Set Preference" })
			THEME:ReloadMetrics()
		end;
	};
	setmetatable( t, t )
	return t
end

function UserPrefCustomSpeed()
	local t = {
		Name = "CustomSpeed",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = { 'CS6','Custom' },
		LoadSelections = function(self, list, pn)
			if GetAdhocPref("CustomSpeed") ~= nil then
				local curSet = GetAdhocPref("CustomSpeed")
				if curSet == 'CS6' then
					list[1] = true
				elseif curSet == 'Custom' then
					list[2] = true
				else
					list[1] = true
				end
			else
				SetAdhocPref("CustomSpeed",'CS6')
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			local tChoices = { 'CS6','Custom' }
			local val
			if list[1] then
				val = tChoices[1]
			elseif list[2] then
				val = tChoices[2]
			else
				val = tChoices[1]
			end
			SetAdhocPref("CustomSpeed",val)
			MESSAGEMAN:Broadcast("PreferenceSet", { Message == "Set Preference" })
			THEME:ReloadMetrics()
		end,
	}
	setmetatable( t, t )
	return t
end

function MeterType()
	local t = {
		Name = "MeterType",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = { 'Default','CSStyle' },
		LoadSelections = function(self, list, pn)
			if GetAdhocPref("UserMeterType") ~= nil then
				local curSet = GetAdhocPref("UserMeterType")
				if curSet == 'Default' then
					list[1] = true
				elseif curSet == "DDR X" then
					list[1] = true
				elseif curSet == 'CSStyle' then
					list[2] = true
				else
					list[1] = true
				end
			else
				SetAdhocPref("UserMeterType",'Default')
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			local tChoices = { 'Default','CSStyle' }
			local val
			if list[1] then
				val = tChoices[1]
			elseif list[2] then
				val = tChoices[2]
			else
				val = tChoices[1]
			end
			SetAdhocPref("UserMeterType",val)
			MESSAGEMAN:Broadcast("PreferenceSet", { Message == "Set Preference" })
			THEME:ReloadMetrics()
		end,
	}
	setmetatable( t, t )
	return t
end

function HoldArrowJudge()
	local t = {
		Name = "HoldArrowJudge",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = { '1Point','2Points' },
		LoadSelections = function(self, list, pn)
			if GetAdhocPref("HoldArrowJudge") ~= nil then
				local curSet = GetAdhocPref("HoldArrowJudge")
				if curSet == '1Point' then
					list[1] = true
				elseif curSet == '2Points' then
					list[2] = true
				else
					list[1] = true
				end
			else
				SetAdhocPref("HoldArrowJudge",'1Point')
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			local tChoices = { '1Point','2Points' }
			local val
			if list[1] then
				val = tChoices[1]
			elseif list[2] then
				val = tChoices[2]
			else
				val = tChoices[1]
			end
			SetAdhocPref("HoldArrowJudge",val)
			MESSAGEMAN:Broadcast("PreferenceSet", { Message == "Set Preference" })
			THEME:ReloadMetrics()
		end,
	}
	setmetatable( t, t )
	return t
end

--BGMode
function BGMode()
	local t = {
		Name = "BGScale",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = { 'Fit','Cover','WindowFull' },
		LoadSelections = function(self, list, pn)
			if GetAdhocPref("BGScale") ~= nil then
				local bShow = GetAdhocPref("BGScale")
				if bShow == 'Fit' then
					list[1] = true
				elseif bShow == 'Cover' then
					list[2] = true
				elseif bShow == 'WindowFull' then
					list[3] = true
				else
					list[1] = true
				end;
			else
				SetAdhocPref("BGScale",'Fit')
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			local bSave;
			if list[1] then
				bSave='Fit';
			elseif list[2] then
				bSave='Cover';
			elseif list[3] then
				bSave='WindowFull';
			end;
			SetAdhocPref("BGScale", bSave)
		end,
	}
	setmetatable(t, t)
	return t
end

function ScreenFilter()
	local t = {
		Name = "ScreenFilter",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = { 'Off','25%','50%','75%','100%' },
		LoadSelections = function(self, list, pn)
			if GetAdhocPref("ScreenFilter" .. ToEnumShortString(pn)) ~= nil then
				local bShow=GetAdhocPref("ScreenFilter" .. ToEnumShortString(pn))
				--[ja] バグ対策
				if bShow == 'nil' then
					list[1] = true
				elseif bShow == 'Off' then
					list[1] = true
				elseif bShow == '0.25' then
					list[2] = true
				elseif bShow == '0.5' then
					list[3] = true
				elseif bShow == '0.75' then
					list[4] = true
				elseif bShow == '1' then
					list[5] = true
				end;
			else
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			local bSave;
			if list[1] then
				bSave='Off';
			elseif list[2] then
				bSave='0.25';
			elseif list[3] then
				bSave='0.5';
			elseif list[4] then
				bSave='0.75';
			elseif list[5] then
				bSave='1';
			end;
			SetAdhocPref("ScreenFilter" .. ToEnumShortString(pn), bSave);
		end,
	}
	setmetatable(t, t)
	return t
end

-- score graph
function ScoreGraph()
	local t = {
		Name = "ScoreGraph",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = { 'Off','AAA','AA','A+','A-','90%','80%' },
		LoadSelections = function(self, list, pn)
			if GetAdhocPref("ScoreGraph" .. ToEnumShortString(pn)) ~= nil then
				local bShow=GetAdhocPref("ScoreGraph" .. ToEnumShortString(pn))
				if bShow == 'nil' then
					list[1] = true
				elseif bShow == 'Off' then
					list[1] = true
				elseif bShow == 'Tier01' then
					list[2] = true
				elseif bShow == 'Tier02' then
					list[3] = true
				elseif bShow == 'Tier03' then
					list[4] = true
				elseif bShow == 'Tier04' then
					list[5] = true
				elseif bShow == '0.9' then
					list[6] = true
				elseif bShow == '0.8' then
					list[7] = true
				end;
			else
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			local bSave;
			if list[1] then
				bSave='Off';
			elseif list[2] then
				bSave='Tier01';
			elseif list[3] then
				bSave='Tier02';
			elseif list[4] then
				bSave='Tier03';
			elseif list[5] then
				bSave='Tier04';
			elseif list[6] then
				bSave='0.9';
			elseif list[7] then
				bSave='0.8';
			end;
			SetAdhocPref("ScoreGraph" .. ToEnumShortString(pn), bSave);
		end,
	}
	setmetatable(t, t)
	return t
end

-- stats display
function OptionShowStats()
	local t = {
		Name = "IngameStats",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = { 'Off','On' },
		LoadSelections = function(self, list, pn)
			if GetAdhocPref("IngameStats" .. ToEnumShortString(pn)) ~= nil then
				local bShow = GetAdhocPref("IngameStats" .. ToEnumShortString(pn))
				if bShow == 'false' then
					list[1] = true
				elseif bShow == 'nil' then
					list[1] = true
				elseif bShow == 'Off' then
					list[1] = true
				elseif bShow == 'On' then
					list[2] = true
				end;
			else
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			local bSave;
			if list[1] then
				bSave='Off';
			elseif list[2] then
				bSave='On';
			end;
			SetAdhocPref("IngameStats" .. ToEnumShortString(pn), bSave)
		end,
	}
	setmetatable(t, t)
	return t
end
