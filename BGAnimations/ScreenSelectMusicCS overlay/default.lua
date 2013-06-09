
local t = Def.ActorFrame{};

local key_count = 0;
local key_open = 0;

local pm = GAMESTATE:GetPlayMode();

local maxStages = PREFSMAN:GetPreference("SongsPerPlay");
local ssStats = STATSMAN:GetPlayedStageStats(1);
local group = ssStats:GetPlayedSongs()[1]:GetGroupName();

t[#t+1] = Def.ActorFrame {
	CodeCommand=function(self,params)
		if params.Name == "Start" or params.Name == "Start2" then
			if key_open == 1 then
				if key_count == 2 then
					self:playcommand("Stop");
				else
					self:playcommand("Start");
				end;
			end;
		elseif params.Name=="Up" or params.Name=="Up2" then
			if key_open == 1 then
				self:playcommand("Up");
			end;
		elseif params.Name=="Down" or params.Name=="Down2" then
			if key_open == 1 then
				self:playcommand("Down");
			end;
		end;
	end;
	LoadActor(THEME:GetPathS("Common","start")) .. {
		StartCommand=function(self)
			self:stop();
			self:play();
		end;
		StopCommand=function(self)
			self:play();
			self:stop();
		end;
	};
	LoadActor(THEME:GetPathS("ScreenSelectMusic","difficulty easier")) .. {
		UpCommand=function(self)
			self:stop();
			self:play();
		end;
	};
	LoadActor(THEME:GetPathS("ScreenSelectMusic","difficulty harder")) .. {
		DownCommand=function(self)
			self:stop();
			self:play();
		end;
	};
	
	LoadActor(THEME:GetPathS("ScreenSelectMusic","difficulty harder")) .. {
		InitCommand=function(self)
			self:stop();
			self:play();
		end;
	};
	-- BGM 
	Def.Sound {
		InitCommand=function(self)
			local bgm = GetGroupParameter(group,"Extra1SelectBGM");
			if bgm ~= "" and FILEMAN:DoesFileExist("/Songs/"..group.."/"..bgm) then
				self:load("/Songs/"..group.."/"..bgm);
			elseif bgm ~= "" and FILEMAN:DoesFileExist("/AdditionalSongs/"..group.."/"..bgm) then
				self:load("/AdditionalSongs/"..group.."/"..bgm);
			else
				self:load(THEME:GetPathS("","_csc_type1"));
			end;
			self:stop();
			self:sleep(1);
			self:queuecommand("Play");
		end;
		PlayCommand=cmd(play);
	};
};

GAMESTATE:SetCurrentSong( newsong );

if pm == "PlayMode_Battle" or pm == "PlayMode_Rave" then
	local so = GAMESTATE:GetDefaultSongOptions();
	GAMESTATE:SetSongOptions( "ModsLevel_Stage", so );
	MESSAGEMAN:Broadcast( "SongOptionsChanged" );
elseif GAMESTATE:IsAnExtraStage() then
	--local ssStats = STATSMAN:GetPlayedStageStats(1)
	--local sssong = ssStats:GetPlayedSongs()[1]

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
	end

	local difficulty = steps:GetDifficulty()
	local Reverse = PlayerNumber:Reverse()

	for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
--[[
		[ja] ↓AutoSetStyleがOFFの時、2重にStyleがセットされてしまう問題の対策

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
		InitCommand=cmd(y,SCREEN_CENTER_Y-30;);
		-- left
		LoadActor( THEME:GetPathB("","arrow") )..{
			OnCommand=cmd(x,-120+60-16;rotationz,180;diffusealpha,0;sleep,1;queuecommand,"Repeat";);
			RepeatCommand=cmd(addx,12;diffusealpha,0.8;glow,color("1,0.5,0,1");linear,1;glow,color("0,0,0,0");addx,-12;diffusealpha,0;queuecommand,"Repeat";);
			OffCommand=cmd(stoptweening;);
		};
	
		LoadActor( THEME:GetPathB("","arrow") )..{
			OnCommand=cmd(x,-120+60;rotationz,180;diffusealpha,0;sleep,1.11;queuecommand,"Repeat";);
			RepeatCommand=cmd(addx,16;diffusealpha,0.8;glow,color("1,0.5,0,1");linear,0.8;glow,color("0,0,0,0");addx,-16;diffusealpha,0;sleep,0.2;queuecommand,"Repeat";);
			OffCommand=cmd(stoptweening;);
		};
	};
	Def.ActorFrame{
		Condition=not GAMESTATE:IsExtraStage2();
		InitCommand=cmd(y,SCREEN_CENTER_Y-30;);
		-- right
		LoadActor( THEME:GetPathB("","arrow") )..{
			OnCommand=cmd(x,120+60+16;diffusealpha,0;sleep,1;queuecommand,"Repeat";);
			RepeatCommand=cmd(addx,-12;diffusealpha,0.8;glow,color("1,0.5,0,1");linear,1;glow,color("0,0,0,0");addx,12;diffusealpha,0;queuecommand,"Repeat";);
			OffCommand=cmd(stoptweening;);
		};
	
		LoadActor( THEME:GetPathB("","arrow") )..{
			OnCommand=cmd(x,120+60;diffusealpha,0;sleep,1.11;queuecommand,"Repeat";);
			RepeatCommand=cmd(addx,-16;diffusealpha,0.8;glow,color("1,0.5,0,1");linear,0.8;glow,color("0,0,0,0");addx,16;diffusealpha,0;sleep,0.2;queuecommand,"Repeat";);
			OffCommand=cmd(stoptweening;);
		};
	};
};
--clock
t[#t+1] = LoadFont("Common normal")..{
	InitCommand=cmd(x,SCREEN_RIGHT-70;y,SCREEN_TOP+58;shadowlength,1;strokecolor,color("0,0,0,1");horizalign,right;zoom,0.45;zoomy,0;sleep,0.5;linear,0.4;zoomy,0.45;);
	BeginCommand=cmd(settext, string.format("%04i/%i/%i %i:%02i", Year(), MonthOfYear()+1,DayOfMonth(), Hour(), Minute());sleep,1;queuecommand,"Begin");
};

--[[
t[#t+1] = LoadFont("Common normal")..{
	InitCommand=cmd(x,SCREEN_RIGHT-70;y,SCREEN_TOP+68;shadowlength,1;strokecolor,color("0,0,0,1");horizalign,right;zoom,0.45;zoomy,0;sleep,0.5;linear,0.4;zoomy,0.45;);
	BeginCommand=cmd(settext, GAMESTATE:GetCurrentSong():GetDisplayMainTitle();sleep,1;queuecommand,"Begin");
};
]]

t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(stoptweening;linear,1.25;queuecommand,"Key");
	KeyCommand=function(self)
		key_open = 1;
	end;
	CodeMessageCommand=function(self, params)
		if params.Name == "Start" or params.Name == "Start2" then
			if key_open == 1 then
				if key_count == 0 then
					self:queuecommand("SelectO");
					key_count = 1;
				elseif key_count == 1 then
					key_count = 2;
				elseif key_count == 2 then
					self:queuecommand("Stop");
				end;
			elseif key_open == 0 then
				key_count = 0;
			end;
		end;
	end;

	Def.ActorFrame{
		SelectOCommand=cmd(stoptweening;linear,0.8;queuecommand,"NextScreen");
		SelectO2Command=cmd(stoptweening;linear,1.8;queuecommand,"NextScreen");
		NextScreenCommand=function(self)
			if key_count == 2 then
				SCREENMAN:SetNewScreen("ScreenPlayerOptions");
			elseif key_count == 1 then
				SCREENMAN:SetNewScreen("ScreenStageInformation");
			end;
		end;
	};
	
	Def.Quad{
		InitCommand=cmd(diffuse,color("0,0,0,0"););
		SelectOCommand=cmd(stoptweening;Center;diffuse,color("0,1,1,0.4");zoomtowidth,SCREEN_WIDTH;zoomtoheight,0;fadetop,0.2;fadebottom,0.2;
				decelerate,0.2;fadetop,0;fadebottom,0;zoomtoheight,SCREEN_HEIGHT;linear,0.2;diffuse,color("0,0,0,0"););
		SelectO2Command=cmd(stoptweening;Center;diffuse,color("0,1,1,0.4");zoomtowidth,SCREEN_WIDTH;zoomtoheight,0;fadetop,0.2;fadebottom,0.2;
				sleep,1;decelerate,0.2;fadetop,0;fadebottom,0;zoomtoheight,SCREEN_HEIGHT;linear,0.2;diffuse,color("0,0,0,0"););
	};

	Def.Quad{
		InitCommand=cmd(diffuse,color("0,0,0,0"););
		SelectOCommand=cmd(stoptweening;diffuse,color("0,0,0,0");x,SCREEN_CENTER_X;y,SCREEN_TOP;vertalign,top;zoomtowidth,SCREEN_WIDTH;zoomtoheight,0;
				accelerate,0.2;diffuse,color("0,0,0,1");zoomtowidth,SCREEN_WIDTH;zoomtoheight,SCREEN_HEIGHT/2+10);
		SelectO2Command=cmd(stoptweening;diffuse,color("0,0,0,0");x,SCREEN_CENTER_X;y,SCREEN_TOP;vertalign,top;zoomtowidth,SCREEN_WIDTH;zoomtoheight,0;
				sleep,1;accelerate,0.2;diffuse,color("0,0,0,1");zoomtowidth,SCREEN_WIDTH;zoomtoheight,SCREEN_HEIGHT/2+10);
	};

	Def.Quad{
		InitCommand=cmd(diffuse,color("0,0,0,0"););
		SelectOCommand=cmd(stoptweening;diffuse,color("0,0,0,0");x,SCREEN_CENTER_X;y,SCREEN_BOTTOM;vertalign,bottom;zoomtowidth,SCREEN_WIDTH;zoomtoheight,0;
				accelerate,0.2;diffuse,color("0,0,0,1");zoomtowidth,SCREEN_WIDTH;zoomtoheight,SCREEN_HEIGHT/2+10);
		SelectO2Command=cmd(stoptweening;diffuse,color("0,0,0,0");x,SCREEN_CENTER_X;y,SCREEN_BOTTOM;vertalign,bottom;zoomtowidth,SCREEN_WIDTH;zoomtoheight,0;
				sleep,1;accelerate,0.2;diffuse,color("0,0,0,1");zoomtowidth,SCREEN_WIDTH;zoomtoheight,SCREEN_HEIGHT/2+10);
	};
};

local function update(self)
	local limit = getenv("Timer");
	if PREFSMAN:GetPreference("MenuTimer") then
		if key_count == 0 then
			if limit == 0 then
				self:playcommand("SelectO2");
				key_count = 1;
			end;
		end;
	end;
end;

t.InitCommand=cmd(SetUpdateFunction,update;);

--[[
t[#t+1] = LoadFont("Common normal")..{
	InitCommand=cmd(x,SCREEN_RIGHT-70;y,SCREEN_TOP+68;shadowlength,1;strokecolor,color("0,0,0,1");horizalign,right;zoom,0.45;zoomy,0;sleep,0.5;linear,0.4;zoomy,0.45;);
	SelectOCommand=function(self)
		(cmd(settext,key_count))(self)
	end;
};


local function update(self)
	self:playcommand("Count");
end;

t.InitCommand=cmd(SetUpdateFunction,update;);


t[#t+1] = LoadFont("Common normal")..{
	InitCommand=cmd(x,SCREEN_RIGHT-70;y,SCREEN_TOP+68;shadowlength,1;strokecolor,color("0,0,0,1");horizalign,right;zoom,0.45;zoomy,0;sleep,0.5;linear,0.4;zoomy,0.45;);
	RefreshCommand=function(self)
		local musicwheel = SCREENMAN:GetTopScreen():GetMusicWheel();
		local curIndex = musicwheel:GetWheelItem( math.floor(WheelItems()/2+0.5) );
		local groupname = GAMESTATE:GetPreferredSongGroup();
		self:settext(groupname);
	end;
	CurrentSongChangedMessageCommand=cmd(playcommand,"Refresh");
};
]]

return t;