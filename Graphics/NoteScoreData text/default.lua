
--[[ NoteScoreData text ]]

local pn = ...
assert(pn,"Must pass in a player, dingus");

local SongOrCourse;
local StepsOrTrail;
local SorCTime;
local bIsCourseMode = GAMESTATE:IsCourseMode();

local t = Def.ActorFrame{
	Name="NoteScoreData"..pn;
	BeginCommand=function(self)
		self:visible(GAMESTATE:IsHumanPlayer(pn));
	end;
	PlayerJoinedMessageCommand=function(self,param)
		if param.Player == pn then
			self:visible(true);
		end;
	end;
	PlayerUnjoinedMessageCommand=function(self,param)
		if param.Player == pn then
			self:visible(false);
		end;
	end;
};

local statsCategoryValues = {
	{ Category = "HoldNoteScore_Held" , Color = Colors.Judgment["JudgmentLine_Held"]},
	{ Category = "TapNoteScore_Miss" , Color = Colors.Judgment["JudgmentLine_Miss"]},
	{ Category = "TapNoteScore_W5" , Color = Colors.Judgment["JudgmentLine_W5"]},
	{ Category = "TapNoteScore_W4" , Color = Colors.Judgment["JudgmentLine_W4"]},
	{ Category = "TapNoteScore_W3" , Color = Colors.Judgment["JudgmentLine_W3"]},
	{ Category = "TapNoteScore_W2" , Color = Colors.Judgment["JudgmentLine_W2"]},
	{ Category = "TapNoteScore_W1" , Color = Colors.Judgment["JudgmentLine_W1"]},
};

local hs = {
	"Grade",
	"PercentScore",
	"TotalSteps",
	"RadarCategory_Holds",
	"RadarCategory_Rolls",
	"Date",
	"TapNoteScore_W1",
	"TapNoteScore_W2",
	"TapNoteScore_W3",
	"TapNoteScore_W4",
	"TapNoteScore_W5",
	"TapNoteScore_Miss",
	"TapNoteScore_HitMine",
	"TapNoteScore_CheckpointMiss",
	"HoldNoteScore_Held",
	"HoldNoteScore_LetGo";
	"MaxCombo";
	"SurvivalSeconds";
};

local nGrade = {
	Grade_Tier01 = nil;
	Grade_Tier02 = "Grade_Tier01";
	Grade_Tier03 = "Grade_Tier02";
	Grade_Tier04 = "Grade_Tier03";
	Grade_Tier05 = "Grade_Tier04";
	Grade_Tier06 = "Grade_Tier05";
	Grade_Tier07 = "Grade_Tier06";
	Grade_Failed = nil;
	Grade_None = nil;
};

local Tier = {
	"Grade_Tier01",
	"Grade_Tier02",
	"Grade_Tier03",
	"Grade_Tier04",
	"Grade_Tier05",
	"Grade_Tier06";
};

local wp =  {
	TapNoteScore_W1			= PREFSMAN:GetPreference("PercentScoreWeightW1"),
	TapNoteScore_W2			= PREFSMAN:GetPreference("PercentScoreWeightW2"),
	TapNoteScore_W3			= PREFSMAN:GetPreference("PercentScoreWeightW3"),
	TapNoteScore_W4			= PREFSMAN:GetPreference("PercentScoreWeightW4"),
	TapNoteScore_W5			= PREFSMAN:GetPreference("PercentScoreWeightW5"),
	TapNoteScore_Miss			= PREFSMAN:GetPreference("PercentScoreWeightMiss"),
	HoldNoteScore_Held			= PREFSMAN:GetPreference("PercentScoreWeightHeld"),
	TapNoteScore_HitMine		= PREFSMAN:GetPreference("PercentScoreWeightHitMine"),
	HoldNoteScore_LetGo			= PREFSMAN:GetPreference("PercentScoreWeightLetGo"),
	TapNoteScore_AvoidMine		= 0,
	TapNoteScore_CheckpointHit	= PREFSMAN:GetPreference("PercentScoreWeightCheckpointHit"),
	TapNoteScore_CheckpointMiss 	= PREFSMAN:GetPreference("PercentScoreWeightCheckpointMiss"),
};

local MIGS = 0;
local MIGS_MAX = 0;
local PPercentScore = 0;
local MPercentScore = 0;
local gradegraphwidth = 0;
---------------------------------------------------------------------------------------------------------------------------------------
t[#t+1] = LoadFont("Common normal") .. {
	SetCommand=function(self)
		Tier["Grade_Tier01"] = THEME:GetMetric("PlayerStageStats","GradePercentTier01");
		Tier["Grade_Tier02"] = THEME:GetMetric("PlayerStageStats","GradePercentTier02");
		Tier["Grade_Tier03"] = THEME:GetMetric("PlayerStageStats","GradePercentTier03");
		Tier["Grade_Tier04"] = THEME:GetMetric("PlayerStageStats","GradePercentTier04");
		Tier["Grade_Tier05"] = THEME:GetMetric("PlayerStageStats","GradePercentTier05");
		Tier["Grade_Tier06"] = THEME:GetMetric("PlayerStageStats","GradePercentTier06");

		if bIsCourseMode then
			SongOrCourse = GAMESTATE:GetCurrentCourse();
			StepsOrTrail = GAMESTATE:GetCurrentTrail(pn);
		else
			SongOrCourse = GAMESTATE:GetCurrentSong();
			StepsOrTrail = GAMESTATE:GetCurrentSteps(pn);
		end;
		if getenv("rnd_song") == 1 then
			hs["Grade"]						= "Grade_None";
			hs["PercentScore"]					= "?";
			hs["TotalSteps"]					= "?";
			hs["RadarCategory_Holds"]				= "?";
			hs["RadarCategory_Rolls"]				= "?";
			hs["Date"]							= "?";
			hs["TapNoteScore_W1"]				= "?";
			hs["TapNoteScore_W2"]				= "?";
			hs["TapNoteScore_W3"]				= "?";
			hs["TapNoteScore_W4"]				= "?";
			hs["TapNoteScore_W5"]				= "?";
			hs["TapNoteScore_Miss"]				= "?";
			hs["TapNoteScore_HitMine"]			= "?";
			hs["TapNoteScore_CheckpointMiss"]		= "?";
			hs["HoldNoteScore_Held"]				= "?";
			hs["HoldNoteScore_LetGo"]			= "?";
			hs["MaxCombo"]					= "?";
			hs["SurvivalSeconds"]				= 0;
			MIGS							= "?";
			MIGS_MAX							= "?";
			MIGS_02							= "?";
			gradegraphwidth						= "?";	
		elseif SongOrCourse and StepsOrTrail then
			hs["TotalSteps"]				= StepsOrTrail:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds');
			hs["RadarCategory_Holds"]		= StepsOrTrail:GetRadarValues(pn):GetValue('RadarCategory_Holds');
			hs["RadarCategory_Rolls"]		= StepsOrTrail:GetRadarValues(pn):GetValue('RadarCategory_Rolls');
			local profile = nil;
			if PROFILEMAN:IsPersistentProfile(pn) then
				-- player profile
				profile = PROFILEMAN:GetProfile(pn);
			else
				-- machine profile
				profile = PROFILEMAN:GetMachineProfile();
			end;

			local scorelist = profile:GetHighScoreList(SongOrCourse,StepsOrTrail);
			assert(scorelist);
			local scores = scorelist:GetHighScores();
			local topscore = scores[1];

			if topscore then
				hs["Grade"]						= topscore:GetGrade();
				hs["PercentScore"]					= topscore:GetPercentDP();
				hs["Date"]							= string.sub( topscore:GetDate(),1,10 );
				hs["TapNoteScore_W1"]				= topscore:GetTapNoteScore("TapNoteScore_W1");
				hs["TapNoteScore_W2"]				= topscore:GetTapNoteScore("TapNoteScore_W2");
				hs["TapNoteScore_W3"]				= topscore:GetTapNoteScore("TapNoteScore_W3");
				hs["TapNoteScore_W4"]				= topscore:GetTapNoteScore("TapNoteScore_W4");
				hs["TapNoteScore_W5"]				= topscore:GetTapNoteScore("TapNoteScore_W5");
				hs["TapNoteScore_Miss"]				= topscore:GetTapNoteScore("TapNoteScore_Miss");
				hs["TapNoteScore_HitMine"]			= topscore:GetTapNoteScore("TapNoteScore_HitMine");
				hs["TapNoteScore_CheckpointMiss"]		= topscore:GetTapNoteScore("TapNoteScore_CheckpointMiss");
				hs["HoldNoteScore_Held"]				= topscore:GetHoldNoteScore("HoldNoteScore_Held");
				hs["HoldNoteScore_LetGo"]			= topscore:GetHoldNoteScore("HoldNoteScore_LetGo");
				hs["MaxCombo"]					= topscore:GetMaxCombo();
				if bIsCourseMode then
					SorCTime = SongOrCourse:GetTotalSeconds(GAMESTATE:GetCurrentStyle():GetStepsType());
					hs["SurvivalSeconds"]			= SorCTime + 1;
				else
					SorCTime = SongOrCourse:GetLastSecond();
					hs["SurvivalSeconds"]			= topscore:GetSurvivalSeconds();	
				end;
				played = true;
				
				if hs["Grade"] ~= "Grade_None" and hs["Grade"] ~= "Grade_Failed" then
					if hs["SurvivalSeconds"] >= SorCTime then
						if hs["PercentScore"] >= Tier["Grade_Tier01"] then hs["Grade"] = "Grade_Tier01"
						elseif hs["PercentScore"] >= Tier["Grade_Tier02"] then hs["Grade"] = "Grade_Tier02"
						elseif hs["PercentScore"] >= Tier["Grade_Tier03"] then hs["Grade"] = "Grade_Tier03"
						elseif hs["PercentScore"] >= Tier["Grade_Tier04"] then hs["Grade"] = "Grade_Tier04"
						elseif hs["PercentScore"] >= Tier["Grade_Tier05"] then hs["Grade"] = "Grade_Tier05"
						elseif hs["PercentScore"] >= Tier["Grade_Tier06"] then hs["Grade"] = "Grade_Tier06"
						else hs["Grade"] = "Grade_Tier07"
						end;
					else
						hs["Grade"] = "Grade_Failed"
					end;
				end;
			else
				hs["Grade"]						= "Grade_None";
				hs["PercentScore"]					= 0;
				hs["Date"]							= "-";
				hs["TapNoteScore_W1"]				= 0;
				hs["TapNoteScore_W2"]				= 0;
				hs["TapNoteScore_W3"]				= 0;
				hs["TapNoteScore_W4"]				= 0;
				hs["TapNoteScore_W5"]				= 0;
				hs["TapNoteScore_Miss"]				= 0;
				hs["TapNoteScore_HitMine"]			= 0;
				hs["TapNoteScore_CheckpointMiss"]		= 0;
				hs["HoldNoteScore_Held"]				= 0;
				hs["HoldNoteScore_LetGo"]			= 0;
				hs["MaxCombo"]					= 0;
				hs["SurvivalSeconds"]				= 0;
				played = false;
			end;
			MIGS = hs["TapNoteScore_W1"] * wp["TapNoteScore_W1"]
				+ hs["TapNoteScore_W2"] * wp["TapNoteScore_W2"]
				+ hs["TapNoteScore_W3"] * wp["TapNoteScore_W3"]
				+ hs["HoldNoteScore_Held"] * wp["HoldNoteScore_Held"]
				+ hs["TapNoteScore_HitMine"] * wp["TapNoteScore_HitMine"];
			MIGS_MAX = hs["TotalSteps"] * wp["TapNoteScore_W1"]
					+ hs["RadarCategory_Holds"] * wp["HoldNoteScore_Held"]
					+ hs["RadarCategory_Rolls"] * wp["HoldNoteScore_Held"];
			MIGS_02 = hs["TapNoteScore_W3"]
					+ hs["TapNoteScore_W4"]
					+ hs["TapNoteScore_W5"]
					+ hs["TapNoteScore_Miss"]
					+ hs["HoldNoteScore_LetGo"];
			if MIGS_MAX <= 0 then MIGS_MAX = 1; end;
			gradegraphwidth = math.floor(MIGS / MIGS_MAX * 145);
			if gradegraphwidth < 0 then gradegraphwidth = 0; end;
		else
			hs["Grade"]						= "Grade_None";
			hs["PercentScore"]					= 0;
			hs["TotalSteps"]					= 0;
			hs["RadarCategory_Holds"]				= 0;
			hs["RadarCategory_Rolls"]				= 0;
			hs["Date"]							= "-";
			hs["TapNoteScore_W1"]				= 0;
			hs["TapNoteScore_W2"]				= 0;
			hs["TapNoteScore_W3"]				= 0;
			hs["TapNoteScore_W4"]				= 0;
			hs["TapNoteScore_W5"]				= 0;
			hs["TapNoteScore_Miss"]				= 0;
			hs["TapNoteScore_HitMine"]			= 0;
			hs["TapNoteScore_CheckpointMiss"]		= 0;
			hs["HoldNoteScore_Held"]				= 0;
			hs["HoldNoteScore_LetGo"]			= 0;
			hs["MaxCombo"]					= 0;
			hs["SurvivalSeconds"]				= 0;
			MIGS							= 0;
			MIGS_MAX							= 0;
			MIGS_02							= 0;
			gradegraphwidth						= 0;
		end;
	end;
	CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
	CurrentCourseChangedMessageCommand=cmd(playcommand,"Set");
};
---------------------------------------------------------------------------------------------------------------------------------------

t[#t+1] = Def.Sprite{
	InitCommand=cmd(y,80;);
	OnCommand=function(self)
		if pn == PLAYER_1 then
			self:Load(THEME:GetPathG("NoteScoreData","text/1_jadgeback"));
			(cmd(stoptweening;x,4;addx,-30;diffusealpha,0;sleep,1;decelerate,0.15;addx,30;diffusealpha,1;))(self);
		elseif pn == PLAYER_2 then
			self:Load(THEME:GetPathG("NoteScoreData","text/2_jadgeback"));
			(cmd(stoptweening;x,-4;addx,30;diffusealpha,0;sleep,1;decelerate,0.15;addx,-30;diffusealpha,1;))(self);
		end;
	end;
	CurrentSongChangedMessageCommand=function(self)
		if bIsCourseMode then
			SongOrCourse = GAMESTATE:GetCurrentCourse();
		else
			SongOrCourse = GAMESTATE:GetCurrentSong();
		end;
		if SongOrCourse then
			self:visible(true);
			self:playcommand("On");
		else
			self:visible(false);
		end;
	end;
	CurrentCourseChangedMessageCommand=function(self)
		if bIsCourseMode then
			SongOrCourse = GAMESTATE:GetCurrentCourse();
		else
			SongOrCourse = GAMESTATE:GetCurrentSong();
		end;
		if SongOrCourse then
			self:visible(true);
			self:playcommand("On");
		else
			self:visible(false);
		end;
	end;
};

--notescore
for idx, cat in pairs(statsCategoryValues) do
	local statsCategory = cat.Category;
	local statsColor = cat.Color;

	t[#t+1] = Def.ActorFrame{
		LoadFont("PaneDisplay text")..{
			InitCommand=cmd(zoom,0.75;sleep,idx/10;shadowlength,0;);
			OnCommand=cmd(visible,true;stoptweening;diffusealpha,0;sleep,1.05;linear,0.1;diffusealpha,1;playcommand,"Set";);
			SetCommand=function(self)
				if pn == PLAYER_1 then
					(cmd(player,PLAYER_1;horizalign,left;rotationz,-45;))(self);
				elseif pn == PLAYER_2 then
					(cmd(player,PLAYER_2;horizalign,right;rotationz,45;))(self);
				end;
				self:maxwidth(60);
				self:y(48+(math.abs(idx-7)*26));
				local value = 0;
				self:diffuse(statsColor);
				if bIsCourseMode then
					SongOrCourse = GAMESTATE:GetCurrentCourse();
					StepsOrTrail = GAMESTATE:GetCurrentTrail(pn);
				else
					SongOrCourse = GAMESTATE:GetCurrentSong();
					StepsOrTrail = GAMESTATE:GetCurrentSteps(pn);
				end;
				if PROFILEMAN:IsPersistentProfile(pn) then
					-- player profile
					profile = PROFILEMAN:GetProfile(pn);
				else
					-- machine profile
					profile = PROFILEMAN:GetMachineProfile();
				end;
				if getenv("rnd_song") == 1 then
					value = "?";
				elseif SongOrCourse and StepsOrTrail then
					local scorelist = profile:GetHighScoreList(SongOrCourse,StepsOrTrail);
					assert(scorelist);
					local scores = scorelist:GetHighScores();
					local topscore = scores[1];
					if topscore then
						if not StepsOrTrail then
							self:diffusealpha(0.5);
							value = "0";
						elseif not SongOrCourse then
							self:diffusealpha(0.5);
							value = "0";
						else
							self:diffusealpha(1);
							if statsCategory ~= "HoldNoteScore_Held" then
								value = topscore:GetTapNoteScore(statsCategory);
							else
								value = topscore:GetHoldNoteScore(statsCategory);
							end;
						end;
					else
						self:diffusealpha(0.5);
						value = "0";
					end;
				else
					self:diffusealpha(0.5);
					value = "0";
				end;
				self:settext( value );
			end;
			CurrentSongChangedMessageCommand=function(self)
				if bIsCourseMode then
					SongOrCourse = GAMESTATE:GetCurrentCourse();
				else
					SongOrCourse = GAMESTATE:GetCurrentSong();
				end;
				if SongOrCourse then
					(cmd(visible,true;stoptweening;diffusealpha,0;sleep,1.05;linear,0.1;diffusealpha,1;playcommand,"Set";))(self);
				else
					self:visible(false);
				end;
			end;
			CurrentCourseChangedMessageCommand=function(self)
				if bIsCourseMode then
					SongOrCourse = GAMESTATE:GetCurrentCourse();
				else
					SongOrCourse = GAMESTATE:GetCurrentSong();
				end;
				if SongOrCourse then
					(cmd(visible,true;stoptweening;diffusealpha,0;sleep,1.05;linear,0.1;diffusealpha,1;playcommand,"Set";))(self);
				else
					self:visible(false);
				end;
			end;
		};
	};
end;

--data
t[#t+1] = Def.ActorFrame{
	LoadFont("PaneDisplay text")..{
		InitCommand=cmd(zoom,0.75;y,-12;);
		OnCommand=cmd(visible,true;stoptweening;diffusealpha,0;sleep,1.05;linear,0.1;diffusealpha,1;playcommand,"Set";);
		SetCommand=function(self)
			if pn == PLAYER_1 then
				(cmd(player,PLAYER_1;horizalign,left;rotationz,-45;x,-22;))(self);
				self:settext("  "..MIGS.."\n :"..MIGS_MAX);
			elseif pn == PLAYER_2 then
				(cmd(player,PLAYER_2;horizalign,right;rotationz,45;x,22;))(self);
				self:settext(MIGS.."  \n:"..MIGS_MAX.." ");
			end;
		end;
		CurrentSongChangedMessageCommand=function(self)
			if bIsCourseMode then
				SongOrCourse = GAMESTATE:GetCurrentCourse();
			else
				SongOrCourse = GAMESTATE:GetCurrentSong();
			end;
			if SongOrCourse then
				(cmd(visible,true;stoptweening;diffusealpha,0;sleep,1.05;linear,0.1;diffusealpha,1;playcommand,"Set";))(self);
			else
				self:visible(false);
			end;
		end;
		CurrentCourseChangedMessageCommand=function(self)
			if bIsCourseMode then
				SongOrCourse = GAMESTATE:GetCurrentCourse();
			else
				SongOrCourse = GAMESTATE:GetCurrentSong();
			end;
			if SongOrCourse then
				(cmd(visible,true;stoptweening;diffusealpha,0;sleep,1.05;linear,0.1;diffusealpha,1;playcommand,"Set";))(self);
			else
				self:visible(false);
			end;
		end;
	};

	LoadFont("PaneDisplay text")..{
		InitCommand=cmd(horizalign,left;zoom,0.75;);
		OnCommand=cmd(visible,true;stoptweening;diffusealpha,0;sleep,1.05;linear,0.1;diffusealpha,1;playcommand,"Set";);
		SetCommand=function(self)
			self:visible(false);
			if pn == PLAYER_1 then
				(cmd(player,PLAYER_1;horizalign,left;rotationz,-45;x,-24;y,28))(self);
			else
				(cmd(player,PLAYER_2;horizalign,right;rotationz,45;x,14;y,18;))(self);
			end;
			local grade = hs["Grade"];
			local nextGrade = nGrade[grade];
			if getenv("rnd_song") == 1 or hs["Grade"] == "Grade_Failed" then
				self:visible(false);
			elseif nextGrade ~= nil then
				self:visible(true);
				local nextGtext = THEME:GetString("Grade",ToEnumShortString(nextGrade));
				local upTier = THEME:GetMetric("PlayerStageStats","GradePercent"..ToEnumShortString(nextGrade));
				local nextp = math.ceil(MIGS_MAX * upTier);
				local nextTScore = MIGS - nextp;
				if pn == PLAYER_1 then
					self:settext("  :"..nextGtext.."\n "..nextTScore);
				else
					self:settext(":"..nextGtext.." \n"..nextTScore);
				end;
			elseif MIGS == MIGS_MAX then
				self:visible(true);
				if pn == PLAYER_1 then
					self:settext("  MAX");
				else
					self:settext("MAX  ");
				end;
			else
				self:visible(false);
			end;
		end;
		CurrentSongChangedMessageCommand=function(self)
			if bIsCourseMode then
				SongOrCourse = GAMESTATE:GetCurrentCourse();
			else
				SongOrCourse = GAMESTATE:GetCurrentSong();
			end;
			if SongOrCourse then
				(cmd(visible,true;stoptweening;diffusealpha,0;sleep,1.05;linear,0.1;diffusealpha,1;playcommand,"Set";))(self);
			else
				self:visible(false);
			end;
		end;
		CurrentCourseChangedMessageCommand=function(self)
			if bIsCourseMode then
				SongOrCourse = GAMESTATE:GetCurrentCourse();
			else
				SongOrCourse = GAMESTATE:GetCurrentSong();
			end;
			if SongOrCourse then
				(cmd(visible,true;stoptweening;diffusealpha,0;sleep,1.05;linear,0.1;diffusealpha,1;playcommand,"Set";))(self);
			else
				self:visible(false);
			end;
		end;
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