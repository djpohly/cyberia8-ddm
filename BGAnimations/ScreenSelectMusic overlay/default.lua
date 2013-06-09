
local t = Def.ActorFrame{};

if getenv("cStage") == "Stage_Final" and GAMESTATE:IsExtraStage() then
	PREFSMAN:SetPreference("AllowExtraStage",getenv("envAllowExtraStage"));
end;
setenv("exflag","");
local limit = getenv("Timer");
local pm = GAMESTATE:GetPlayMode();
local eset = false;
local sctext = getenv("SortCh");
local st = GAMESTATE:GetCurrentStyle():GetStepsType();
local mt = GetAdhocPref("UserMeterType");

if sctext == "BeginnerMeter" or sctext == "EasyMeter" or sctext == "MediumMeter" or
sctext == "HardMeter" or sctext == "ChallengeMeter" then
	GAMESTATE:SetCurrentSong( newsong );
	GAMESTATE:ApplyGameCommand("sort,Preferred");
	setenv("psflag",sctext);
	SONGMAN:SetPreferredSongs(""..ToEnumShortString(st).."_"..mt.."_"..sctext.."_New.txt");
elseif sctext == "TopGrades" then
	GAMESTATE:SetCurrentSong( newsong );
	GAMESTATE:ApplyGameCommand("sort,Preferred");
	setenv("psflag",sctext);
	local mplayer = GAMESTATE:GetMasterPlayerNumber();
	local gt = GAMESTATE:GetCurrentSteps(mplayer):GetDifficulty();
	if gt == 'Difficulty_Edit' then
		gt = 'Difficulty_Beginner'
		GAMESTATE:ApplyGameCommand("difficulty,beginner");
	else
		GAMESTATE:ApplyGameCommand("difficulty,"..string.lower(ToEnumShortString(gt)));
	end;
	SONGMAN:SetPreferredSongs(""..ToEnumShortString(st).."_Grade_"..ToEnumShortString(gt).."Meter_New.txt");
else
	setenv("psflag","");
end;


if pm == "PlayMode_Battle" or pm == "PlayMode_Rave" then
	local so = GAMESTATE:GetDefaultSongOptions();
	GAMESTATE:SetSongOptions( "ModsLevel_Stage", so );
	MESSAGEMAN:Broadcast( "SongOptionsChanged" );
elseif GAMESTATE:IsAnExtraStage() then
	if GAMESTATE:GetPreferredSongGroup() == "---Group All---" then
		local psStats = STATSMAN:GetPlayedStageStats(1);
		local song = psStats:GetPlayedSongs()[1];
		GAMESTATE:ApplyGameCommand("sort,Group");
		GAMESTATE:SetPreferredSongGroup( song:GetGroupName() );
	end

	local bExtra2 = GAMESTATE:IsExtraStage2();
	local bExtra = GAMESTATE:IsExtraStage();
	local style = GAMESTATE:GetCurrentStyle();
	local song, steps = SONGMAN:GetExtraStageInfo( bExtra2, style );
	local po, so;
	if bExtra2 then
		local extracrs = OpenFile("/Songs/".. song:GetGroupName() .."/extra2.crs");
		if not extracrs then
			extracrs = OpenFile("/AdditionalSongs/".. song:GetGroupName() .."/extra2.crs");
		end;
		if extracrs then
			local opt = split(":",GetFileParameter(extracrs ,"song"))[3];
			local opt = string.lower(opt);
			local life = GetFileParameter(extracrs,"lives");
			if life == "" or life == "1" then
				life = "1 life";
			else
				life = ""..life.." lives";
			end;

			if string.find(opt,"battery",0,true) then
				so = "faildefault,battery," .. life .. "";
			elseif string.find(opt,"norecover",0,true) then
				so = "bar,failimmediate,norecover";
			elseif string.find(opt,"suddendeath",0,true) then
				so = "faildefault,battery,1 life";
			else
				so = "bar,failimmediate,normal-drain";
			end;

			opt = string.gsub(opt ,",",", ");
			CloseFile(extracrs);
			for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
				local ps = GAMESTATE:GetPlayerState(pn);
				po = "default, " .. ps:GetPlayerOptionsString("ModsLevel_Preferred") .. ", " .. opt;
				ps:SetPlayerOptions("ModsLevel_Preferred", po);
				ps:SetPlayerOptions('ModsLevel_Song', po);
			end;
			GAMESTATE:SetSongOptions( "ModsLevel_Stage", so );
			MESSAGEMAN:Broadcast( "SongOptionsChanged" );
		else
			for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
				local ps = GAMESTATE:GetPlayerState(pn);
				po = "default, " .. ps:GetPlayerOptionsString("ModsLevel_Preferred");
				ps:SetPlayerOptions("ModsLevel_Preferred", po);
				ps:SetPlayerOptions('ModsLevel_Song', po);
				MESSAGEMAN:Broadcast( "PlayerOptionsChanged", {PlayerNumber = pn} )
			end;
			so = THEME:GetMetric("SongManager","OMESStageModifiers");
		end
		GAMESTATE:SetCurrentSong( song );
		GAMESTATE:SetPreferredSong( song );
		GAMESTATE:SetPreferredSongGroup( song:GetGroupName() );
	elseif bExtra then
		local extracrs = OpenFile("/Songs/".. song:GetGroupName() .."/extra1.crs");
		if not extracrs then
			extracrs = OpenFile("/AdditionalSongs/".. song:GetGroupName() .."/extra1.crs");
		end;
		if extracrs then
			local opt = split(":",GetFileParameter(extracrs ,"song"))[3];
			local opt = string.lower(opt);
			local life = GetFileParameter(extracrs,"lives");
			if life == "" then
				life = "4 lives";
			elseif life == "1" then
				life = "1 life";
			else
				life = ""..life.." lives";
			end;

			if string.find(opt,"battery",0,true) then
				so = "faildefault,battery," .. life .. "";
			elseif string.find(opt,"norecover",0,true) then
				so = "bar,failimmediate,norecover";
			elseif string.find(opt,"suddendeath",0,true) then
				so = "bar,failimmediate,suddendeath";
			else
				so = "bar,failimmediate,normal-drain";
			end;
			
			opt = string.gsub(opt ,",",", ");
			CloseFile(extracrs);
			for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
				local ps = GAMESTATE:GetPlayerState(pn);
				po = "default, " .. ps:GetPlayerOptionsString("ModsLevel_Preferred") .. ", " .. opt;
				ps:SetPlayerOptions("ModsLevel_Preferred", po);
				ps:SetPlayerOptions('ModsLevel_Song', po);
			end;
			GAMESTATE:SetSongOptions( "ModsLevel_Stage", so );
			MESSAGEMAN:Broadcast( "SongOptionsChanged" );
		else
			for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
				local ps = GAMESTATE:GetPlayerState(pn);
				po = "default, " .. ps:GetPlayerOptionsString("ModsLevel_Preferred");
				ps:SetPlayerOptions("ModsLevel_Preferred", po);
				ps:SetPlayerOptions('ModsLevel_Song', po);
				MESSAGEMAN:Broadcast( "PlayerOptionsChanged", {PlayerNumber = pn} )
			end;
			so = THEME:GetMetric("SongManager","ExtraStageStageModifiers");
		end
		GAMESTATE:SetCurrentSong( song );
		GAMESTATE:SetPreferredSong( song );
		GAMESTATE:SetPreferredSongGroup( song:GetGroupName() );
	end

	local difficulty = steps:GetDifficulty()
	local Reverse = PlayerNumber:Reverse()

	for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
		--[ja] ↓AutoSetStyleがOFFの時、2重にStyleがセットされてしまう問題の対策
--[[
		if THEME:GetMetric("Common","AutoSetStyle") == true then
			GAMESTATE:SetCurrentSteps( pn, steps );
		end
]]
		GAMESTATE:SetCurrentSteps( pn, steps );
		GAMESTATE:SetPreferredDifficulty( pn, difficulty )
		MESSAGEMAN:Broadcast( "PlayerOptionsChanged", {PlayerNumber = pn} );
	end

	GAMESTATE:SetSongOptions( "ModsLevel_Stage", so );
	MESSAGEMAN:Broadcast( "SongOptionsChanged" );
end

t[#t+1] = Def.ActorFrame{
	InitCommand=function(self)
		if GAMESTATE:IsCourseMode() then self:x(SCREEN_CENTER_X-100);
		else self:x(SCREEN_CENTER_X);
		end;
	end;
	Def.ActorFrame{
		Condition=not GAMESTATE:IsExtraStage2();
		InitCommand=cmd(y,SCREEN_CENTER_Y-6;);
		-- left
		LoadActor( THEME:GetPathB("","arrow") )..{
			OnCommand=cmd(x,-120-16;rotationz,180;diffusealpha,0;sleep,1;queuecommand,"Repeat";);
			RepeatCommand=cmd(addx,12;diffusealpha,0.8;glow,color("1,0.5,0,1");linear,1;glow,color("0,0,0,0");addx,-12;diffusealpha,0;queuecommand,"Repeat";);
			OffCommand=cmd(stoptweening;);
		};
	
		LoadActor( THEME:GetPathB("","arrow") )..{
			OnCommand=cmd(x,-120;rotationz,180;diffusealpha,0;sleep,1.11;queuecommand,"Repeat";);
			RepeatCommand=cmd(addx,16;diffusealpha,0.8;glow,color("1,0.5,0,1");linear,0.8;glow,color("0,0,0,0");addx,-16;diffusealpha,0;sleep,0.2;queuecommand,"Repeat";);
			OffCommand=cmd(stoptweening;);
		};
	};
	Def.ActorFrame{
		Condition=not GAMESTATE:IsExtraStage2();
		InitCommand=cmd(y,SCREEN_CENTER_Y-6;);
		-- right
		LoadActor( THEME:GetPathB("","arrow") )..{
			OnCommand=cmd(x,120+16;diffusealpha,0;sleep,1;queuecommand,"Repeat";);
			RepeatCommand=cmd(addx,-12;diffusealpha,0.8;glow,color("1,0.5,0,1");linear,1;glow,color("0,0,0,0");addx,12;diffusealpha,0;queuecommand,"Repeat";);
			OffCommand=cmd(stoptweening;);
		};
	
		LoadActor( THEME:GetPathB("","arrow") )..{
			OnCommand=cmd(x,120;diffusealpha,0;sleep,1.11;queuecommand,"Repeat";);
			RepeatCommand=cmd(addx,-16;diffusealpha,0.8;glow,color("1,0.5,0,1");linear,0.8;glow,color("0,0,0,0");addx,16;diffusealpha,0;sleep,0.2;queuecommand,"Repeat";);
			OffCommand=cmd(stoptweening;);
		};
	};
};
--clock
t[#t+1] = LoadFont("Common normal")..{
	InitCommand=cmd(x,SCREEN_RIGHT-70;y,SCREEN_TOP+58;shadowlength,1;strokecolor,color("0,0,0,1");horizalign,right;zoom,0.45;zoomy,0;sleep,0.5;linear,0.4;zoomy,0.45;);
	BeginCommand=function(self)
		(cmd(settext, string.format("%04i/%i/%i %i:%02i", Year(), MonthOfYear()+1,DayOfMonth(), Hour(), Minute());sleep,1;queuecommand,"Begin"))(self)
	end;
};

--[[
t[#t+1] = LoadFont("Common normal")..{
	InitCommand=cmd(x,SCREEN_RIGHT-70;y,SCREEN_TOP+68;shadowlength,1;strokecolor,color("0,0,0,1");horizalign,right;zoom,0.45;zoomy,0;sleep,0.5;linear,0.4;zoomy,0.45;);
	BeginCommand=function(self)
		(cmd(settext,getenv("songstr")))(self)
	end;
};

t[#t+1] = LoadFont("Common normal")..{
	InitCommand=cmd(x,SCREEN_RIGHT-70;y,SCREEN_TOP+68;shadowlength,1;strokecolor,color("0,0,0,1");horizalign,right;zoom,0.45;zoomy,0;sleep,0.5;linear,0.4;zoomy,0.45;);
	BeginCommand=function(self)
		(cmd(settext, getenv("exdcount")))(self)
	end;
};
]]

t[#t+1] = Def.ActorFrame{
	EnvSetCommand=function(self)
		SCREENMAN:SetNewScreen("ScreenCSOpen");
	end;
};

--[[
t[#t+1] = LoadFont("Common normal")..{
	InitCommand=cmd(x,SCREEN_RIGHT-70;y,SCREEN_TOP+68;shadowlength,1;strokecolor,color("0,0,0,1");horizalign,right;zoom,0.45;zoomy,0;sleep,0.5;linear,0.4;zoomy,0.45;);
	RefreshCommand=function(self)
		local musicwheel = SCREENMAN:GetTopScreen():GetMusicWheel();
		local curIndex = musicwheel:GetWheelItem( math.floor(WheelItems()/2+0.5) );
		local groupname = curIndex:GetText();
		local groupc = curIndex:GetColor();
		self:settext(groupname);
		self:diffuse(groupc);
	end;
	CurrentSongChangedMessageCommand=cmd(playcommand,"Refresh");
};


t[#t+1] = LoadFont("Common normal")..{
	InitCommand=cmd(x,SCREEN_RIGHT-70;y,SCREEN_TOP+68;shadowlength,1;strokecolor,color("0,0,0,1");horizalign,right;zoom,0.45;zoomy,0;sleep,0.5;linear,0.4;zoomy,0.45;);
	RefreshCommand=function(self)
		self:settext(getenv("SSort"));
	end;
	CurrentSongChangedMessageCommand=cmd(playcommand,"Refresh");
};
]]

--selsort
if not GAMESTATE:IsCourseMode() and not IsNetConnected() then
	t[#t+1] = Def.ActorFrame{
		CodeMessageCommand=function(self,params)
			if limit > 10 then
				if params.Name == "ModeSort1" or params.Name == "ModeSort2" then
					SCREENMAN:SetNewScreen("ScreenSort");
					--SCREENMAN:AddNewScreenToTop("ScreenSort");
				end;
			end;
		end;
	};
end;

local function update(self)
	if getenv("csflag") == 2 then
		--SCREENMAN:SetNewScreen("ScreenCSOpen");
		self:queuecommand("EnvSet");
	end;
end;

t.InitCommand=cmd(SetUpdateFunction,update;);

return t;