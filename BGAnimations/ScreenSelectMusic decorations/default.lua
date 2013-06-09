--[[ ScreenSelectMusic decorations ]]

local t = LoadFallbackB();

t[#t+1] = StandardDecorationFromFileOptional( "BannerFrame","BannerFrame" );
t[#t+1] = StandardDecorationFromFileOptional( "StageDisplay", "StageDisplay" );
t[#t+1] = StandardDecorationFromFileOptional( "SortDisplay", "SortDisplay" );
t[#t+1] = StandardDecorationFromFileOptional( "BPMDisplay", "BPMDisplay" );
t[#t+1] = StandardDecorationFromFileOptional( "SongLength", "SongLength" );	-- plus machine rank
--t[#t+1] = StandardDecorationFromFileOptional( "AvailableDifficulties", "AvailableDifficulties" );
t[#t+1] = StandardDecorationFromFileOptional( "GrooveRadar", "GrooveRadar" );
t[#t+1] = StandardDecorationFromFileOptional( "DifficultyList", "DifficultyList" );
t[#t+1] = StandardDecorationFromFileOptional( "CourseContents", "CourseContents" );
t[#t+1] = StandardDecorationFromFileOptional( "Balloon", "Balloon" );
t[#t+1] = StandardDecorationFromFileOptional( "NumCourseSongs", "NumCourseSongs" );
t[#t+1] = StandardDecorationFromFileOptional( "CourseHasMods", "CourseHasMods" );
t[#t+1] = StandardDecorationFromFileOptional( "PaneDisplayTextP1","PaneDisplayTextP1" );
t[#t+1] = StandardDecorationFromFileOptional( "PaneDisplayTextP2","PaneDisplayTextP2" );
t[#t+1] = StandardDecorationFromFileOptional( "NoteScoreDataP1","NoteScoreDataP1" );
t[#t+1] = StandardDecorationFromFileOptional( "NoteScoreDataP2","NoteScoreDataP2" );
t[#t+1] = StandardDecorationFromFileOptional( "SegmentDisplay","SegmentDisplay" );

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

--[[
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