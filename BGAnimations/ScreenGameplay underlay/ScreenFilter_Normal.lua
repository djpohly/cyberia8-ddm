
local t;

local filter1;
local filter2;
if GetAdhocPref("ScreenFilterP1") ~= nil then
	filter1 = GetAdhocPref("ScreenFilterP1");
else
	filter1 = 'Off';
end;
if GetAdhocPref("ScreenFilterP2") ~= nil then
	filter2 = GetAdhocPref("ScreenFilterP2");
else
	filter2 = 'Off';
end;

local function GetFilterPosX(pn)
	local r = SCREEN_CENTER_X;
	local p;
	local st = GAMESTATE:GetCurrentStyle():GetStyleType();
	if GAMESTATE:GetNumPlayersEnabled() == 1 and Center1Player() then
		r = SCREEN_CENTER_X;
	else
		if pn == PLAYER_1 then p = "1";
		else p = "2";
		end;
		r = THEME:GetMetric("ScreenGameplay","PlayerP"..p..ToEnumShortString(st).."X");
	end;
	return r;
end;

local function GetFilterSizeX(pn)
	local r = 0;
	local one = THEME:GetMetric("ArrowEffects","ArrowSpacing");
	local stt = GAMESTATE:GetCurrentSteps(pn):GetStepsType();
	if stt == 'StepsType_Dance_Single' then r = one*4;
	elseif stt == 'StepsType_Dance_Double' then r = one*8;
	elseif stt == 'StepsType_Dance_Couple' then r = one*4;
	elseif stt == 'StepsType_Dance_Solo' then r = one*6;
	elseif stt == 'StepsType_Dance_Threepanel' then r = one*3;
	else r = SCREEN_WIDTH;
	end;
	return r;
end;

t = Def.ActorFrame{
	Def.Quad{
		Name="FilterP1";
		InitCommand=cmd(y,SCREEN_CENTER_Y;diffuse,Color("Black"););
		OnCommand=function(self)
			self:x(GetFilterPosX(PLAYER_1));
			self:zoomto(GetFilterSizeX(PLAYER_1)+40,SCREEN_HEIGHT);
			self:fadeleft(1/32);
			self:faderight(1/32);
			if filter1 == 'Off' then self:diffusealpha(0);
			elseif filter1 ~= 'Off' then self:diffusealpha(filter1);
			else self:diffusealpha(1);
			end;
		end;
	};
	Def.Quad{
		Name="FilterP2";
		InitCommand=cmd(y,SCREEN_CENTER_Y;diffuse,Color("Black"););
		OnCommand=function(self)
			self:x(GetFilterPosX(PLAYER_2));
			self:zoomto(GetFilterSizeX(PLAYER_2)+40,SCREEN_HEIGHT);
			self:fadeleft(1/32);
			self:faderight(1/32);
			if filter2 == 'Off' then self:diffusealpha(0);
			elseif filter2 ~= 'Off' then self:diffusealpha(filter2);
			else self:diffusealpha(1);
			end;
		end;
	};
};

local function FilterUpdate(self)
	local fil1 = self:GetChild("FilterP1");
	local fil2 = self:GetChild("FilterP2");

	local song = GAMESTATE:GetCurrentSong();
	local start = song:GetFirstBeat();
	local last = song:GetLastBeat();
	local now = 0.0;
	now = GAMESTATE:GetSongBeat();
	if not GAMESTATE:IsDemonstration() then
		if (now >= start-8.0) and (now <= last) then
			if GAMESTATE:IsPlayerEnabled(PLAYER_1) then
				fil1:visible(true);
			else
				fil1:visible(false);
			end;
			if GAMESTATE:IsPlayerEnabled(PLAYER_2) then
				fil2:visible(true);
			else
				fil2:visible(false);
			end;
		else
			fil1:visible(false);
			fil2:visible(false);
		end;
	else
		fil1:visible(false);
		fil2:visible(false);
	end;
end;

t.InitCommand=cmd(SetUpdateFunction,FilterUpdate);

return t;
