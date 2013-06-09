--[[ ScreenNetSelectMusic decorations ]]

local t = LoadFallbackB();

t[#t+1] = StandardDecorationFromFileOptional( "BannerFrame","BannerFrame" );
t[#t+1] = StandardDecorationFromFileOptional( "SortDisplay", "SortDisplay" );
t[#t+1] = StandardDecorationFromFile( "BPMDisplay", "BPMDisplay" );
t[#t+1] = StandardDecorationFromFile( "SongLength", "SongLength" );
t[#t+1] = StandardDecorationFromFileOptional( "DifficultyList", "DifficultyList" );
t[#t+1] = StandardDecorationFromFileOptional( "Balloon", "Balloon" );
t[#t+1] = StandardDecorationFromFileOptional( "PaneDisplayTextP1","PaneDisplayTextP1" );
t[#t+1] = StandardDecorationFromFileOptional( "PaneDisplayTextP2","PaneDisplayTextP2" );
t[#t+1] = StandardDecorationFromFileOptional( "NoteScoreDataP1","NoteScoreDataP1" );
t[#t+1] = StandardDecorationFromFileOptional( "NoteScoreDataP2","NoteScoreDataP2" );

--[[
for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	local diffIcon = LoadActor( THEME:GetPathG( Var "LoadingScreen", "DifficultyIcon" ), pn );
	t[#t+1] = StandardDecorationFromTable( "DifficultyIcon" .. ToEnumShortString(pn), diffIcon );
end


local function HighScore(pn)
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
				if SongOrCourse and StepsOrTrail then
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
	if ShowStandardDecoration("HighScore"..ToEnumShortString(pn)) then
		t[#t+1] = StandardDecorationFromTable("HighScore"..ToEnumShortString(pn), HighScore(pn));
	end;
end
]]

return t;