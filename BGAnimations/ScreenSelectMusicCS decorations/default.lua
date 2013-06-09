--[[ ScreenSelectMusicCS decorations ]]
local t = LoadFallbackB();

setenv("exflag","csc");
setenv("keycount",0);

t[#t+1] = StandardDecorationFromFileOptional( "BannerFrame","BannerFrame" );
t[#t+1] = StandardDecorationFromFileOptional( "StageDisplay", "StageDisplay" );
t[#t+1] = StandardDecorationFromFileOptional( "SortDisplay", "SortDisplay" );
t[#t+1] = StandardDecorationFromFileOptional( "BPMDisplay", "BPMDisplay" );
t[#t+1] = StandardDecorationFromFileOptional( "SongLength", "SongLength" );	-- plus machine rank
t[#t+1] = StandardDecorationFromFileOptional( "PointDisplay", "PointDisplay" );
--t[#t+1] = StandardDecorationFromFileOptional( "AvailableDifficulties", "AvailableDifficulties" );
t[#t+1] = StandardDecorationFromFileOptional( "GrooveRadar", "GrooveRadar" );
t[#t+1] = StandardDecorationFromFileOptional( "DifficultyList", "DifficultyList" );
t[#t+1] = StandardDecorationFromFileOptional( "CourseContents", "CourseContents" );
--t[#t+1] = StandardDecorationFromFileOptional( "Balloon", "Balloon" );
t[#t+1] = StandardDecorationFromFileOptional( "NumCourseSongs", "NumCourseSongs" );
t[#t+1] = StandardDecorationFromFileOptional( "CourseHasMods", "CourseHasMods" );
t[#t+1] = StandardDecorationFromFileOptional( "PaneDisplayTextP1","PaneDisplayTextP1" );
t[#t+1] = StandardDecorationFromFileOptional( "PaneDisplayTextP2","PaneDisplayTextP2" );
t[#t+1] = StandardDecorationFromFileOptional( "NoteScoreDataP1","NoteScoreDataP1" );
t[#t+1] = StandardDecorationFromFileOptional( "NoteScoreDataP2","NoteScoreDataP2" );
--t[#t+1] = StandardDecorationFromFileOptional( "SegmentDisplay","SegmentDisplay" );

if GAMESTATE:IsCourseMode() then
	for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
		local diffIcon = LoadActor( THEME:GetPathG( Var "LoadingScreen", "DifficultyIcon" ), pn );
		t[#t+1] = StandardDecorationFromTable( "DifficultyIcon" .. ToEnumShortString(pn), diffIcon );
	end
end;

if ShowStandardDecoration("SongOptions") then
	t[#t+1] = StandardDecorationFromFileOptional("SongOptions","SongOptions") .. {
		ShowPressStartForOptionsCommand=THEME:GetMetric(Var "LoadingScreen","SongOptionsShowCommand");
		ShowEnteringOptionsCommand=THEME:GetMetric(Var "LoadingScreen","SongOptionsEnterCommand");
		HidePressStartForOptionsCommand=THEME:GetMetric(Var "LoadingScreen","SongOptionsHideCommand");
	};
end;

t[#t+1] = Def.ActorFrame{
	Name="OptionIcons";
	InitCommand=function(self)
		-- xxx: encapsulate this into a function
		self:y(SCREEN_CENTER_Y+210);
		self:draworder(96);
	end;

	LoadActor("OptionIconsSel", PLAYER_1)..{
		InitCommand=cmd(player,PLAYER_1;x,(SCREEN_CENTER_X*0.575)-70.5;);
		OnCommand=cmd(zoom,0.78;zoomy,0;sleep,0.5;linear,0.3;zoomy,0.78);
	};

	LoadActor("OptionIconsSel", PLAYER_2)..{
		InitCommand=cmd(player,PLAYER_2;x,(SCREEN_CENTER_X*1.425)-16;);
		OnCommand=cmd(zoom,0.78;zoomy,0;sleep,0.5;linear,0.3;zoomy,0.78);
	};
};

for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	t[#t+1] = LoadActor("diffcursor"..ToEnumShortString(pn))..{
		InitCommand=function(self)
			self:zoom(0.8);
			if pn == PLAYER_1 then
				self:x(SCREEN_CENTER_X-88-74);
				self:y(SCREEN_CENTER_Y+106);
			else
				self:x(SCREEN_CENTER_X-86-74);
				self:y(SCREEN_CENTER_Y+101);
			end;
		end;
		OnCommand=cmd(addx,-20;decelerate,0.5;addx,20;);
	};
end;


t[#t+1] = LoadActor("difflist")..{
	InitCommand=cmd(x,SCREEN_CENTER_X-88-74;y,SCREEN_CENTER_Y+90;draworder,90;);
	OnCommand=cmd(rotationz,-90;zoom,0.8;addx,-20;decelerate,0.5;addx,20;);
};

local function Score(pn)
	local t = Def.ActorFrame {
		--score
		LoadFont("_numbers3")..{
			BeginCommand=cmd(playcommand,"Set");
			SetCommand=function(self)
				local text = "        0";
				local SongOrCourse, StepsOrTrail;
				if GAMESTATE:IsCourseMode() then
					SongOrCourse = GAMESTATE:GetCurrentCourse();
					StepsOrTrail = GAMESTATE:GetCurrentTrail(pn);
				else
					SongOrCourse = GAMESTATE:GetCurrentSong();
					StepsOrTrail = GAMESTATE:GetCurrentSteps(pn);
				end;
				if getenv("rnd_song") == 1 then
					text = "         ";
				elseif SongOrCourse and StepsOrTrail then
					local profile = PROFILEMAN:GetProfile(pn);
					local scorelist = profile:GetHighScoreList(SongOrCourse,StepsOrTrail);
					assert(scorelist)
					local scores = scorelist:GetHighScores();
					local topscore = scores[1];
					if topscore then
						local hscore = topscore:GetScore();
						if hscore >= 0 and hscore <= 9 then
							text = string.format("        ".."%i",hscore);
						elseif hscore >= 10 and hscore <= 99 then
							text = string.format("       ".."%02i",hscore);
						elseif hscore >= 100 and hscore <= 999 then
							text = string.format("      ".."%03i",hscore);
						elseif hscore >= 1000 and hscore <= 9999 then
							text = string.format("     ".."%04i",hscore);
						elseif hscore >= 10000 and hscore <= 99999 then
							text = string.format("    ".."%05i",hscore);
						elseif hscore >= 100000 and hscore <= 999999 then
							text = string.format("   ".."%06i",hscore);
						elseif hscore >= 1000000 and hscore <= 9999999 then
							text = string.format("  ".."%07i",hscore);
						elseif hscore >= 10000000 and hscore <= 99999999 then
							text = string.format(" ".."%08i",hscore);
						else
							text = string.format("%09i",hscore);
						end;
					else
						text = "        0";
					end;
				else
					text = "        0";
				end;
				self:settext(text);
			end;
			CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
			CurrentCourseChangedMessageCommand=cmd(playcommand,"Set");
		};
	};

	if pn == PLAYER_1 then
		t.CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Set");
		t.CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"Set");
	else
		t.CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"Set");
		t.CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"Set");
	end

	return t;
end

for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	t[#t+1] = StandardDecorationFromTable("Score"..ToEnumShortString(pn), Score(pn));
end

--banner
--[[
t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(x,SCREEN_CENTER_X-180;y,SCREEN_CENTER_Y-80;);
	Def.Quad{
		InitCommand=cmd(y,100;diffuse,color("0,0,0,0.5");diffusetopedge,color("0,0,0,0.5");
					diffusebottomedge,color("0,0,0,0");zoomtowidth,160;zoomtoheight,160/4;);
	};
	
	Def.Quad{
		InitCommand=cmd(diffuse,color("0,0,0,0.3");diffusetopedge,color("0,0,0,0.3");
					diffusebottomedge,color("0,0,0,0.8");zoomtowidth,160;zoomtoheight,160;);
	};

	Def.Banner {
		InitCommand=cmd(y,100;rotationy,180;rotationz,180;diffusetopedge,color("0,0,0,0");diffusebottomedge,color("1,1,1,0.5"));
		OnCommand=function(self)
			local song = getenv("cs_song");
			local load_jackets = getenv("load_jackets");
			local load_folders = getenv("load_folders");
			if song then
				-- this is where we do all song-specific stuff
				if load_jackets[""..load_folders] ~= nil then
					self:Load(load_jackets[""..load_folders]);
				else
					self:Load(song:GetJacketPath());
				end;
			else
				-- call fallback
				self:Load( THEME:GetPathG("Common","fallback jacket") );
			end;
			self:zoomtowidth(160);
			self:zoomtoheight(160/4);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"On");
	};

	Def.Banner {
		OnCommand=function(self)
			local song = getenv("cs_song");
			local load_jackets = getenv("load_jackets");
			local load_folders = getenv("load_folders");
			if song then
				-- this is where we do all song-specific stuff
				if load_jackets[""..load_folders] ~= nil then
					self:Load(load_jackets[""..load_folders]);
				else
					self:Load(song:GetJacketPath());
				end;
			else
				-- call fallback
				self:Load( THEME:GetPathG("Common","fallback jacket") );
			end;
			self:zoomtowidth(160);
			self:zoomtoheight(160);
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"On");
	};
};
]]

--[[
t[#t+1] = Def.ActorFrame{
--3dmodel
	Def.ActorFrame{
		InitCommand=cmd(x,SCREEN_CENTER_X+30;y,SCREEN_CENTER_Y+40;fov,100;);
		OnCommand=cmd(addx,300;rotationz,0;rotationy,0;decelerate,1;addx,-300;zoom,1.2;rotationz,10;rotationy,-100;);
		LoadActor( THEME:GetPathB("_shared","models/_04_nline") )..{
			InitCommand=cmd(diffuse,color("0,0.8,0.8,1");blend,'BlendMode_Add';queuecommand,"Repeat";);
			RepeatCommand=cmd(spin;effectmagnitude,1,-40,0;);
		};
	};
};

t[#t+1] = Def.Actor{
	Name="TheQuickerHackerUper"; -- BOUNTY
	SetCommand=function(self)
		local SongOrCourse = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong();
		if not SongOrCourse then
			-- hack time
			for pn in ivalues(PlayerNumber) do
				-- ScoreDisplay doesn't get set to 0 in code
				local score = SCREENMAN:GetTopScreen():GetChild("Score"..ToEnumShortString(pn));
				if score then
					score:settext("        0");
				end;
			end;
		end;
	end;
	CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
	CurrentCourseChangedMessageCommand=cmd(playcommand,"Set");
};


t[#t+1] = Def.ActorFrame {
	LoadActor(THEME:GetPathS("MusicWheel","expand")) .. {
		CodeMessageCommand=function(self, params)
			if params.Name=="CloseCurrentFolder" then
				self:stop();
				self:play();
			end;
		end;
	};
};
]]
return t;