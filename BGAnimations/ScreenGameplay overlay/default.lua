local t = Def.ActorFrame{};

local op = GAMESTATE:GetSongOptionsString();
local opstr = string.lower(op);
local maxlives,maxlivesstr;
maxlives,maxlivesstr = string.find(opstr,"%d+lives");
local fn;

for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	t[#t+1] = LoadActor("fullcombo", pn);
	
	if not maxlives then
		t[#t+1] = LoadActor("dangerline")..{
			InitCommand=cmd(zoom,0.6;y,SCREEN_TOP+34;diffusealpha,0;);
			BeginCommand=function(self)
				if pn == PLAYER_1 then
					self:horizalign(left);
					self:x(SCREEN_CENTER_X-200);
				else
					self:horizalign(right);
					self:addx(SCREEN_CENTER_X+200);
				end;
			end;
			HealthStateChangedMessageCommand=function(self,params)
				if params.PlayerNumber == pn then
					if params.HealthState == 'HealthState_Danger' then
						self:playcommand("Show");
					else
						self:playcommand("Hide");
					end;
				end;
			end;
			ShowCommand=cmd(diffusealpha,1;diffuseshift;effectcolor1,color("0.6,0.6,0.6,1");effectcolor2,color("1,0,0,1");effectperiod,0.5;);
			HideCommand=cmd(stopeffect;stoptweening;linear,0.25;diffusealpha,0;);
		};
	end;

	local num = 1;
	if pn == PLAYER_1 then num = 1;
	else num = 2;
	end;
	if GetAdhocPref("CustomSpeed") == "CS6" then
		fn = THEME:GetCurrentThemeDirectory().."/Other/SpeedMods.txt";
	else
		if PROFILEMAN:GetProfileDir('ProfileSlot_Player'..num) then
			fn = ""..PROFILEMAN:GetProfileDir('ProfileSlot_Player'..num).."SpeedMods.txt";
		else
			fn = ""..PROFILEMAN:GetProfileDir('ProfileSlot_Machine').."SpeedMods.txt";
		end;
	end;
end;

local speed_cs = {"",""};
local speed_ce = {"",""};
local speed_cnt = {0,0};
local scroll = {false,false};
local scroll_per = {0,0};
local scroll_cnt = {0,0};

local l = "";
if FILEMAN:DoesFileExist(fn) then
	local f = RageFileUtil.CreateRageFile();
	f:Open(fn,1);
	l = f:GetLine();
	f:Close();
	f:destroy();
end;
local speeds="";
if l == nil or l == "" then
	speeds = "1x";
else
	speeds = split(",",l);
end;
local now_speed_t = {1,1};
local now_speed_s = {"nil","nil"};
local bpm_h = {1,1};

for pn in ivalues(PlayerNumber) do
	t[#t+1] = Def.Quad{
		InitCommand=function(self)
			self:visible(false);
			local p = ( (pn == "PlayerNumber_P1") and 1 or 2 );
			for i = 1,#speeds do
				local modstr = GAMESTATE:GetPlayerState(pn):GetPlayerOptionsString("ModsLevel_Preferred");
				if string.find(modstr,speeds[i],0,true) then
					now_speed_t[p] = i;
					now_speed_s[p] = speeds[i];
					break;
				end;
			end;
			if now_speed_s[p] == "nil" then
				for i = 1,#speeds do
					if speeds[i] == "1x" then
						now_speed_t[p] = i;
						now_speed_s[p] = speeds[i];
					end;
				end;
			end;
			local _st = GAMESTATE:GetCurrentSteps(pn);
			local _td = _st:GetTimingData();
			local bpms = _td:GetBPMs();
			bpm_h[p] = bpms[1];
			for i = 1,#bpms do
				if bpms[i] > bpm_h[p] then bpm_h[p] = bpms[i]; end;
			end;
		end;
	};
end;

speedscroll = Def.ActorFrame{
	Def.Quad{
		InitCommand=cmd(visible,false);
		CodeMessageCommand=function(self,params)
			local pn = params.PlayerNumber;
			local p = ( (pn == "PlayerNumber_P1") and 1 or 2 );
			local ps = GAMESTATE:GetPlayerState(pn);
			local po = ps:GetPlayerOptions("ModsLevel_Preferred");
			local modstr = "default, " .. ps:GetPlayerOptionsString("ModsLevel_Preferred");
			if string.find(modstr,"^.*Reverse.*") and (not scroll[p]) then
				scroll[p] = true;
				scroll_per[p] = 100;
			end;
			if params.Name == "ScrollNomal" then
				scroll_cnt[p] = 25;
				scroll[p] = false;
			elseif params.Name == "ScrollReverse" then
				scroll_cnt[p] = 25;
				scroll[p] = true;
			elseif params.Name == "HiSpeedUp" then
				speed_cnt[p] = 25;
				now_speed_t[p] = now_speed_t[p] + 1;
				if now_speed_t[p] > #speeds then now_speed_t[p] = 1; end;
				local ctmp = split("C",speeds[now_speed_t[p]]);
				if #ctmp == 2 then
					modstr = "default, " .. ps:GetPlayerOptionsString("ModsLevel_Preferred")..", C1";
					ps:SetPlayerOptions("ModsLevel_Preferred", modstr);
				end;
				local mtmp = split("m",speeds[now_speed_t[p]]);
				if #mtmp == 2 then
					modstr = modstr .. ", " .. tonumber(mtmp[2])/bpm_h[1].."x, m"..mtmp[2];
				else
					modstr = modstr .. ", " .. speeds[now_speed_t[p]];
				end;
				ps:SetPlayerOptions("ModsLevel_Preferred", modstr);
			elseif params.Name == "HiSpeedDown" then
				speed_cnt[p] = 25;
				now_speed_t[p] = now_speed_t[p]-1;
				if now_speed_t[p] < 1 then now_speed_t[p] = #speeds; end;
				local ctmp = split("C",speeds[now_speed_t[p]]);
				if #ctmp == 2 then
					modstr = "default, " .. ps:GetPlayerOptionsString("ModsLevel_Preferred")..", C1";
					ps:SetPlayerOptions("ModsLevel_Preferred", modstr);
				end;
				local mtmp = split("m",speeds[now_speed_t[p]]);
				if #mtmp == 2 then
					modstr = modstr .. ", " .. tonumber(mtmp[2]) / bpm_h[1].."x, m"..mtmp[2];
				else
					modstr = modstr .. ", " .. speeds[now_speed_t[p]];
				end;
				ps:SetPlayerOptions("ModsLevel_Preferred", modstr);
			end;
		end;
	};
};
local function spsc_update(self)
	for p = 1,2 do
		local pn = "PlayerNumber_P"..p;
		if GAMESTATE:IsPlayerEnabled(pn) then
			local ps = GAMESTATE:GetPlayerState(pn);
			local modstr = "default, " .. ps:GetPlayerOptionsString("ModsLevel_Preferred");
			if scroll_cnt[p] > 0 then
				if scroll[p] == true then
					scroll_per[p] = scroll_per[p] + (100-scroll_per[p]) / scroll_cnt[p];
				else
					scroll_per[p] = scroll_per[p] - scroll_per[p] / scroll_cnt[p];
				end;
				modstr = modstr .. ", " .. scroll_per[p] .. "% reverse";
				ps:SetPlayerOptions("ModsLevel_Preferred", modstr);
				scroll_cnt[p] = scroll_cnt[p]-1;
			end;
		end;
	end;
end;

speedscroll.InitCommand=cmd(SetUpdateFunction,spsc_update;);
t[#t+1] = speedscroll;

-- [ja] 倍速表示 
for pn in ivalues(PlayerNumber) do
	if GAMESTATE:IsPlayerEnabled(pn) then
		t[#t+1] = LoadFont("OptionIcon text")..{
			InitCommand=function(self)
				if pn == PLAYER_1 then
					self:x(SCREEN_LEFT+16);
					self:horizalign(left);
					self:diffuse(PlayerColor(PLAYER_1));
				else
					self:x(SCREEN_RIGHT-16);
					self:horizalign(right);
					self:diffuse(PlayerColor(PLAYER_2));
				end;
				(cmd(y,SCREEN_BOTTOM-17;maxwidth,SCREEN_WIDTH/2-95;zoom,0.9;addx,-SCREEN_WIDTH;zoomy,0.2;
				sleep,0.6;decelerate,0.4;addx,SCREEN_WIDTH;linear,0.1;zoomy,0.9))(self)
				self:playcommand("Set");
			end;
			SetCommand=function(self)
				local op = string.lower(GAMESTATE:GetPlayerState(pn):GetPlayerOptionsString('ModsLevel_Stage'));
				self:finishtweening();
				self:settext(op);
			end;
			CodeMessageCommand=function(self,params)
				if params.PlayerNumber == pn then
					self:playcommand("Set");
				end;
			end;
		};
	end;
end;

return t;