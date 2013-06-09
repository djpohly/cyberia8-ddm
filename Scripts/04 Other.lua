function Actor:scale_or_crop_background()
	local gw = self:GetWidth()
	local gh = self:GetHeight()

	local graphicAspect = gw/gh
	local displayAspect = DISPLAY:GetDisplayWidth()/DISPLAY:GetDisplayHeight()

	local BGScale = GetAdhocPref("BGScale");
	if BGScale == 'Cover' then
		self:scaletocover( 0,0,SCREEN_WIDTH,SCREEN_HEIGHT )
	elseif BGScale == 'Fit' then
		self:scaletofit( 0,0,SCREEN_WIDTH,SCREEN_HEIGHT )
	elseif BGScale == 'WindowFull' then
		self:FullScreen()
	else
		self:FullScreen()
	end
--[[
	if graphicAspect == displayAspect then
		-- bga matches the current aspect, we can stretch it.
		self:stretchto( 0,0,SCREEN_WIDTH,SCREEN_HEIGHT )
	else
		-- temp
		self:scaletocover( 0,0,SCREEN_WIDTH,SCREEN_HEIGHT )

		-- bga doesn't match the aspect.
		if displayAspect > graphicAspect then
			-- the graphic is smaller than the display aspect ratio
		else
			-- the graphic is bigger than the display aspect ratio; crop me
		end

	end
]]
end

function beta_vcheck()
	local PVersionS = split(" ",ProductVersion());
	if tonumber(string.sub(PVersionS[3],1,1)) >= 2 then 
		return true
	end;
	return false
end;

function FCCheck()
	local cc_path = "CSDataSave/0001_cc CSCountExt";
	local cap_path = "CSDataSave/0001_cc CSApp";
	local ccptext = "#Status:Sco,0,0:Non,0,0:Cha,0,0:End,0,0:Rav,0,0:Ecco,0,0:Esco,0,0:Ccco,0,0:Csco,0,0;\r\n";
	if not File.Read( cc_path ) then
		if File.Read( cap_path ) then
			ccptext = "#Status:Sco,0,1:Non,0,1:Cha,0,1:End,0,1:Rav,0,1:Ecco,0,0:Esco,0,0:Ccco,0,0:Csco,0,0;\r\n";
			File.Write( cc_path , ccptext );
		else
			if GetAdhocPref("CSSetApp") then
				if GetAdhocPref("CSSetApp") == "00000001" then
					ccptext = "#Status:Sco,0,1:Non,0,1:Cha,0,1:End,0,1:Rav,0,1:Ecco,0,0:Esco,0,0:Ccco,0,0:Csco,0,0;\r\n";
					File.Write( cap_path , "00000001" );
				end;
			end;
			File.Write( cc_path , ccptext );
		end;
	end;
end;

function CoinOptionChoice()
	if beta_vcheck() == true then
		return "1,2,4,5"
	else
		return "1,2,3,4,5"
	end
end

function TitleMenuChoice()
	if tonumber(GetAdhocPref("CSCreditFlag")) >= 1 then
		return "1,4,5,6,7,10"
	elseif getenv("CSCreditFlag") then
		if tonumber(getenv("CSCreditFlag")) >= 1 then
			return "1,4,5,6,7,10"
		else
			return "1,4,5,6,10"
		end
	else
		return "1,4,5,6,10"
	end
end

function SelectFrameSet()
	local cc_path = "CSDataSave/0001_cc CSCountExt";
	local cap_path = "CSDataSave/0001_cc CSApp";
	local cf_flag = split(":",GetCCParameter("Status"));
	local ccset = {};
	local cf_point;
	if File.Read( cc_path ) then
		local m = 0;
		for k = 1, 13 do
			if k == 1 or k == 2 or k == 3 or k == 4 or k == 5 then m = 1;
			else m = k - 4;
			end;
			cf_point = split(",",cf_flag[m]);

			if tonumber(cf_point[2]) then
				if k <= 5 then
					if cf_point[1] == "Sco" then
						if k == 1 then
							if GetAdhocPref("CSSetApp") == "00000001" or File.Read( cap_path ) then ccset[#ccset+1] = {k};
							elseif tonumber(cf_point[2]) >= 1 then ccset[#ccset+1] = {k}
							end;
						end;
						if k == 2 and tonumber(cf_point[2]) >= 20 then ccset[#ccset+1] = {k};
						end;
						if k == 3 and tonumber(cf_point[2]) >= 50 then ccset[#ccset+1] = {k};
						end;
						if k == 4 and tonumber(cf_point[2]) >= 100 then ccset[#ccset+1] = {k};
						end;
						if k == 5 and tonumber(cf_point[2]) >= 200 then ccset[#ccset+1] = {k};
						end;
					end;
				end;
				if k == 6 and cf_point[1] == "Non" then
					if GetAdhocPref("CSSetApp") == "00000001" or File.Read( cap_path ) then ccset[#ccset+1] = {k};
					elseif tonumber(cf_point[2]) >= 3 then ccset[#ccset+1] = {k};
					end;
				elseif k == 7 and cf_point[1] == "Cha" then
					if GetAdhocPref("CSSetApp") == "00000001" or File.Read( cap_path ) then ccset[#ccset+1] = {k};
					elseif tonumber(cf_point[2]) >= 3 then ccset[#ccset+1] = {k};
					end;
				elseif k == 8 and cf_point[1] == "End" then
					if GetAdhocPref("CSSetApp") == "00000001" or File.Read( cap_path ) then ccset[#ccset+1] = {k};
					elseif tonumber(cf_point[2]) >= 1 then ccset[#ccset+1] = {k};
					end;
				elseif k == 9 and cf_point[1] == "Rav" then
					if GetAdhocPref("CSSetApp") == "00000001" or File.Read( cap_path ) then ccset[#ccset+1] = {k};
					elseif tonumber(cf_point[2]) >= 10 then ccset[#ccset+1] = {k};
					end;
				elseif k == 10 and cf_point[1] == "Ecco" then
					if tonumber(cf_point[2]) >= 5 then ccset[#ccset+1] = {k};
					end;
				elseif k == 11 and cf_point[1] == "Esco" then
					if tonumber(cf_point[2]) >= 5 then ccset[#ccset+1] = {k};
					end;
				elseif k == 12 and cf_point[1] == "Ccco" then
					if tonumber(cf_point[2]) >= 5 then ccset[#ccset+1] = {k};
					end;
				elseif k == 13 and cf_point[1] == "Csco" then
					if tonumber(cf_point[2]) >= 5 then ccset[#ccset+1] = {k};
					end;
				end;
			end;
		end;
	else
		ccset[#ccset+1] = {""};
	end;

	local cfptext = "";

	for i=1, 13 do
		if ccset[i] then
			cfptext = cfptext..""..table.concat(ccset[i])..",";
		else
			cfptext = cfptext;
		end;
	end;
	cfptext = string.sub(cfptext,1,-2);
	return cfptext
end

function SelectFrameDefault()
	return "Default,"..SelectFrameSet()
end

function FrameSelectDraw()
	local cf = split(",",SelectFrameDefault());
	local itemdraw = 0;
	for i = 1, #cf do
		itemdraw = itemdraw + 1;
	end;
	if itemdraw >= 9 then itemdraw = 9;
	elseif itemdraw == 0 then itemdraw = 1;
	end;
	return itemdraw;
end

function OptionsNavigation()
	if PREFSMAN:GetPreference("ArcadeOptionsNavigation") == 1 then
		return Screen.String("HelpTextPlayerOptionsArcade");
	else
		return Screen.String("HelpTextPlayerOptionsSM");
	end
end

function GraphDisplayWidth()
	local pm = GAMESTATE:GetPlayMode()
	if pm == 'PlayMode_Battle' or pm == "PlayMode_Rave" then 
		return 572;
	else
		return 280;
	end
end

function GraphDisplayHeight()
	local pm = GAMESTATE:GetPlayMode()
	if pm == 'PlayMode_Battle' or pm == "PlayMode_Rave" then
		return 72;
	else
		return 52;
	end
end

function NameEntryTimer()
	if PREFSMAN:GetPreference("MenuTimer") then
		return 30;
	else
		return -1;
	end
end

function SortOrderTimer()
	if GAMESTATE:GetSortOrder() == 'SortOrder_Roulette' then
		return 1;
	else
		return 90;
	end
end

function SortMenuTimer()
	--local timelimit = getenv("Timer") + 1
	local timelimit = getenv("Timer")
	if not PREFSMAN:GetPreference("MenuTimer") then timelimit = 99
	end
	return timelimit
end

function GetGameFrame()
	local frame
	local gamem = GAMESTATE:GetPlayMode()
	local gamemode = ToEnumShortString(gamem)
	local stage = STATSMAN:GetCurStageStats():GetStage()
	local pref = GetAdhocPref("FrameSet")
	if pref == "Default" or pref == nil then
		if gamem == "PlayMode_Regular" then
			if GAMESTATE:IsExtraStage2() then
				if getenv("omsflag") == 1 then frame = "Csc_Special"
				elseif getenv("omsflag") == 0 then frame = "Special"
				end
			elseif GAMESTATE:IsExtraStage() then
				if getenv("exflag") == "csc" then frame = "Csc"
				elseif getenv("exflag") ~= "csc" then frame = "Extra"
				end
			else frame = gamemode
			end
		elseif gamem then frame = gamemode
		end
	else
		if pref == "Challenge" then frame = "Oni"
		elseif pref == "Cyan" then frame = "Csc"
		elseif pref == "Cyan_Special" then frame = "Csc_Special"
		else frame = pref
		end
	end;
	return frame
end

function SelectMusicTimeStart()
	if getenv("sortflag") ~= 1 then
		return 90
	else 
		if tonumber(getenv("Timer")) >= 90 then
			return 90
		end;
		return getenv("Timer")
	end
end

function GetPOScreenType()
	if IsNetConnected() then return 1
	else return 0
	end
end

function NetPOTimer()
	if IsNetConnected() then return -1
	else return 60
	end
end

function ExCustom()
	local maxStages = PREFSMAN:GetPreference("SongsPerPlay")
	if IsNetConnected() then
		return ""
	elseif GAMESTATE:IsExtraStage2() then
		return ""
	elseif tonumber(getenv("exdcount")) > 1 then
		if maxStages >= 3 then
			if GAMESTATE:GetNumPlayersEnabled() > 1 then
				return ""
			else
				return "CSC"
			end
		else
			return ""
		end
	else
		return ""
	end
end

function ChatBoxX()
	if GAMESTATE:IsPlayerEnabled(PLAYER_1) and GAMESTATE:IsHumanPlayer(PLAYER_1) and 
	not GAMESTATE:IsPlayerEnabled(PLAYER_2) and not GAMESTATE:IsHumanPlayer(PLAYER_2) then
		return SCREEN_CENTER_X*1.5+4
	elseif GAMESTATE:IsPlayerEnabled(PLAYER_2) and GAMESTATE:IsHumanPlayer(PLAYER_2) and 
	not GAMESTATE:IsPlayerEnabled(PLAYER_1) and not GAMESTATE:IsHumanPlayer(PLAYER_1) then
		return SCREEN_CENTER_X*0.5+4
	else
		return SCREEN_CENTER_X*1.5+4
	end
end

function ChatInOutX()
	if GAMESTATE:IsPlayerEnabled(PLAYER_1) and GAMESTATE:IsHumanPlayer(PLAYER_1) and 
	not GAMESTATE:IsPlayerEnabled(PLAYER_2) and not GAMESTATE:IsHumanPlayer(PLAYER_2) then
		return (SCREEN_CENTER_X*1.5)*0.75+4
	elseif GAMESTATE:IsPlayerEnabled(PLAYER_2) and GAMESTATE:IsHumanPlayer(PLAYER_2) and 
	not GAMESTATE:IsPlayerEnabled(PLAYER_1) and not GAMESTATE:IsHumanPlayer(PLAYER_1) then
		return (SCREEN_CENTER_X*0.5)*0.25+4
	else
		return (SCREEN_CENTER_X*1.5)*0.75+4
	end
end

function DifficultyListNetMode()
	if IsNetConnected() then return 4
	else return 5
	end
end

function DifficultyListX()
	if GAMESTATE:IsPlayerEnabled(PLAYER_1) and GAMESTATE:IsHumanPlayer(PLAYER_1) and 
	not GAMESTATE:IsPlayerEnabled(PLAYER_2) and not GAMESTATE:IsHumanPlayer(PLAYER_2) then
		return SCREEN_CENTER_X*0.25
	elseif GAMESTATE:IsPlayerEnabled(PLAYER_2) and GAMESTATE:IsHumanPlayer(PLAYER_2) and 
	not GAMESTATE:IsPlayerEnabled(PLAYER_1) and not GAMESTATE:IsHumanPlayer(PLAYER_1) then
		return SCREEN_CENTER_X*1.05
	else
		return SCREEN_CENTER_X*0.25
	end
end

function RoomInfoX()
	if GAMESTATE:IsPlayerEnabled(PLAYER_1) and GAMESTATE:IsHumanPlayer(PLAYER_1) and 
	not GAMESTATE:IsPlayerEnabled(PLAYER_2) and not GAMESTATE:IsHumanPlayer(PLAYER_2) then
		return SCREEN_CENTER_X-290
	elseif GAMESTATE:IsPlayerEnabled(PLAYER_2) and GAMESTATE:IsHumanPlayer(PLAYER_2) and 
	not GAMESTATE:IsPlayerEnabled(PLAYER_1) and not GAMESTATE:IsHumanPlayer(PLAYER_1) then
		return SCREEN_CENTER_X-10
	else
		return SCREEN_CENTER_X-290
	end
end

function UsersX()
	if GAMESTATE:IsPlayerEnabled(PLAYER_1) and GAMESTATE:IsHumanPlayer(PLAYER_1) and 
	not GAMESTATE:IsPlayerEnabled(PLAYER_2) and not GAMESTATE:IsHumanPlayer(PLAYER_2) then
		return SCREEN_CENTER_X*0.2
	elseif GAMESTATE:IsPlayerEnabled(PLAYER_2) and GAMESTATE:IsHumanPlayer(PLAYER_2) and 
	not GAMESTATE:IsPlayerEnabled(PLAYER_1) and not GAMESTATE:IsHumanPlayer(PLAYER_1) then
		return SCREEN_CENTER_X*1.05
	else
		return SCREEN_CENTER_X*0.2
	end
end


function OpenFile(filePath)
	if not FILEMAN:DoesFileExist(filePath) then
		return nil;
	end;
	local f=RageFileUtil.CreateRageFile();
	f:Open(filePath,1);
	return f;
end;

function CloseFile(f)
	if f then
		f:Close();
		f:destroy();
		return true;
	else
		return false;
	end;
end;

function GetFileParameter(f,prm)
	return GetSMParameter_f(f,prm);
end;
function GetSMParameter_f(f,prm)
	if not f then
		return "";
	end;
	f:Seek(0);
	local gl="";
	local pl=string.lower(prm);
	local l;
	while true do
		l=f:GetLine();
		local ll=string.lower(l);
		if string.find(ll,"#notes:.*") or f:AtEOF() then
			break;
		elseif (string.find(ll,"^.*#"..pl..":.*") and (not string.find(ll,"^%/%/.*"))) or gl~="" then
			gl=gl..""..split("//",l)[1];
			if string.find(ll,".*;") then
				break;
			end;
		end;
	end;
	local tmp={};
	if gl=="" then
		tmp={""};
	else
		tmp=split(":",gl);
		if tmp[2]==";" then
			tmp[1]="";
		else
			if #tmp>2 then
				tmp[1]=tmp[2];
				for i=3,#tmp do
					tmp[1]=tmp[1]..":"..split(";",tmp[i])[1];
				end;
			else
				tmp[1]=split(";",tmp[2])[1];
			end;
		end;
	end;
	return tmp[1];
end;

--[ja] フォルダ名からSong型を返す 
function GetFolder2Song(group,folder)
	local gsongs=SONGMAN:GetSongsInGroup(group);
	for i=1,#gsongs do
		if string.find(string.lower(gsongs[i]:GetSongDir()),"/"..string.lower(folder).."",0,true) then
			return gsongs[i];
		end;
	end;
	return false;
end;