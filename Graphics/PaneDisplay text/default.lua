
--[[ PaneDisplay text ]]

local pn = ...
assert(pn,"Must pass in a player, dingus");

local yOffset = 16;

local SongOrCourse;
local StepsOrTrail;
local SorCTime = 0;
local bIsCourseMode = GAMESTATE:IsCourseMode();
local pm = GAMESTATE:GetPlayMode();

---------------------------------------------------------------------------------------------------------------------------------------
local NumStepsColors = {
	{ UpperLimit = 99, diffuse = color("0,1,1,1") },
	{ UpperLimit = 179, diffuse = color("0.2,1,0.2,1") },
	{ UpperLimit = 329, diffuse = color("1,1,0,1") },
	{ UpperLimit = 499, diffuse = color("1,0.5,0.2,1") },
	{ UpperLimit = 9999999, diffuse = color("1,0,0.2,1") },
};
local CourseNumStepsColors = {
	{ UpperLimit = 599, diffuse = color("0,1,1,1") },
	{ UpperLimit = 999, diffuse = color("0.2,1,0.2,1") },
	{ UpperLimit = 1499, diffuse = color("1,1,0,1") },
	{ UpperLimit = 1999, diffuse = color("1,0.5,0.2,1") },
	{ UpperLimit = 9999999, diffuse = color("1,0,0.2,1") },
};

local JumpsColors = {
	{ UpperLimit = 19, diffuse = color("0,1,1,1") },
	{ UpperLimit = 39, diffuse = color("0.2,1,0.2,1") },
	{ UpperLimit = 74, diffuse = color("1,1,0,1") },
	{ UpperLimit = 99, diffuse = color("1,0.5,0.2,1") },
	{ UpperLimit = 9999999, diffuse = color("1,0,0.2,1") },
};
local CourseJumpsColors = {
	{ UpperLimit = 49, diffuse = color("0,1,1,1") },
	{ UpperLimit = 99, diffuse = color("0.2,1,0.2,1") },
	{ UpperLimit = 164, diffuse = color("1,1,0,1") },
	{ UpperLimit = 249, diffuse = color("1,0.5,0.2,1") },
	{ UpperLimit = 9999999, diffuse = color("1,0,0.2,1") },
};

local HoldsColors = {
	{ UpperLimit = 14, diffuse = color("0,1,1,1") },
	{ UpperLimit = 29, diffuse = color("0.2,1,0.2,1") },
	{ UpperLimit = 49, diffuse = color("1,1,0,1") },
	{ UpperLimit = 74, diffuse = color("1,0.5,0.2,1") },
	{ UpperLimit = 9999999, diffuse = color("1,0,0.2,1") },
};
local CourseHoldsColors = {
	{ UpperLimit = 34, diffuse = color("0,1,1,1") },
	{ UpperLimit = 69, diffuse = color("0.2,1,0.2,1") },
	{ UpperLimit = 119, diffuse = color("1,1,0,1") },
	{ UpperLimit = 179, diffuse = color("1,0.5,0.2,1") },
	{ UpperLimit = 9999999, diffuse = color("1,0,0.2,1") },
};

local EtcColors = {
	{ UpperLimit = 9, diffuse = color("1,0.5,0.2,1") },
	{ UpperLimit = 9999999, diffuse = color("1,0,0.2,1") },
};
local CourseEtcColors = {
	{ UpperLimit = 49, diffuse = color("1,0.5,0.2,1") },
	{ UpperLimit = 9999999, diffuse = color("1,0,0.2,1") },
};

function CPaneValueToColor(category,value)
	local numValue = tonumber(value)
	local t;
	if bIsCourseMode then
		if category == 'RadarCategory_TapsAndHolds' then t = CourseNumStepsColors;
		elseif category == 'RadarCategory_Jumps' then t = CourseJumpsColors;
		elseif category == 'RadarCategory_Holds' then t = CourseHoldsColors;
		elseif category == 'RadarCategory_Mines' then t = CourseEtcColors;
		elseif category == 'RadarCategory_Hands' then t = CourseEtcColors;
		elseif category == 'RadarCategory_Rolls' then t = CourseEtcColors;
		elseif category == 'RadarCategory_Lifts' then t = CourseEtcColors;
		end;
	else
		if category == 'RadarCategory_TapsAndHolds' then t = NumStepsColors;
		elseif category == 'RadarCategory_Jumps' then t = JumpsColors;
		elseif category == 'RadarCategory_Holds' then t = HoldsColors;
		elseif category == 'RadarCategory_Mines' then t = EtcColors;
		elseif category == 'RadarCategory_Hands' then t = EtcColors;
		elseif category == 'RadarCategory_Rolls' then t = EtcColors;
		elseif category == 'RadarCategory_Lifts' then t = EtcColors;
		end;
	end;

	for i=1,#t do
		if numValue == nil or numValue == 0 then
			return color("1,1,1,0.5")
		elseif numValue <= t[i].UpperLimit then
			return t[i].diffuse
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------

local paneCategoryValues = {
	{ Category = 'RadarCategory_TapsAndHolds'},
	{ Category = 'RadarCategory_Lifts'},
	{ Category = 'RadarCategory_Rolls'},
	{ Category = 'RadarCategory_Hands'},
	{ Category = 'RadarCategory_Mines'},
	{ Category = 'RadarCategory_Holds'},
	{ Category = 'RadarCategory_Jumps'},
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

local Tier = {
	Grade_Tier01 = THEME:GetMetric("PlayerStageStats","GradePercentTier01"),
	Grade_Tier02 = THEME:GetMetric("PlayerStageStats","GradePercentTier02"),
	Grade_Tier03 = THEME:GetMetric("PlayerStageStats","GradePercentTier03"),
	Grade_Tier04 = THEME:GetMetric("PlayerStageStats","GradePercentTier04"),
	Grade_Tier05 = THEME:GetMetric("PlayerStageStats","GradePercentTier05"),
	Grade_Tier06 = THEME:GetMetric("PlayerStageStats","GradePercentTier06"),
};

local wp =  {
	TapNoteScore_W1			= PREFSMAN:GetPreference("PercentScoreWeightW1"),
	TapNoteScore_W2			= PREFSMAN:GetPreference("PercentScoreWeightW2"),
	TapNoteScore_W3			= PREFSMAN:GetPreference("PercentScoreWeightW3"),
	TapNoteScore_W4			= PREFSMAN:GetPreference("PercentScoreWeightW4"),
	TapNoteScore_W5			= PREFSMAN:GetPreference("PercentScoreWeightW5"),
	TapNoteScore_Miss			= PREFSMAN:GetPreference("PercentScoreWeightMiss"),
	HoldNoteScore_Held			= PREFSMAN:GetPreference("PercentScoreWeightHeld"),
	TapNoteScore_HitMine			= PREFSMAN:GetPreference("PercentScoreWeightHitMine"),
	HoldNoteScore_LetGo			= PREFSMAN:GetPreference("PercentScoreWeightLetGo"),
	TapNoteScore_AvoidMine		= 0,
	TapNoteScore_CheckpointHit		= PREFSMAN:GetPreference("PercentScoreWeightCheckpointHit"),
	TapNoteScore_CheckpointMiss 	= PREFSMAN:GetPreference("PercentScoreWeightCheckpointMiss"),
};

local graphwidth = 145;
local gradegraphwidth = 0;

local PPercentScore = 0;
local MPercentScore = 0;

local t = Def.ActorFrame{
	Name="PaneDisplay"..pn;
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

---------------------------------------------------------------------------------------------------------------------------------------
t[#t+1] = LoadFont("Common normal") .. {
	SetCommand=function(self)
		if bIsCourseMode then
			SongOrCourse = GAMESTATE:GetCurrentCourse();
			StepsOrTrail = GAMESTATE:GetCurrentTrail(pn);
		else
			SongOrCourse = GAMESTATE:GetCurrentSong();
			StepsOrTrail = GAMESTATE:GetCurrentSteps(pn);
		end;
		if getenv("rnd_song") == 1 then
			hs["Grade"]							= "Grade_None";
			hs["PercentScore"]					= 0;
			hs["TotalSteps"]						= 0;
			hs["RadarCategory_Holds"]				= 0;
			hs["RadarCategory_Rolls"]				= 0;
			hs["Date"]							= "-";
			hs["TapNoteScore_W1"]				= 0;
			hs["TapNoteScore_W2"]				= 0;
			hs["TapNoteScore_W3"]				= 0;
			hs["TapNoteScore_W4"]				= 0;
			hs["TapNoteScore_W5"]				= 0;
			hs["TapNoteScore_Miss"]				= 0;
			hs["TapNoteScore_HitMine"]				= 0;
			hs["TapNoteScore_CheckpointMiss"]		= 0;
			hs["HoldNoteScore_Held"]				= 0;
			hs["HoldNoteScore_LetGo"]				= 0;
			hs["MaxCombo"]						= 0;
			hs["SurvivalSeconds"]					= 0;
			MIGS								= 0;
			MIGS_MAX							= 0;
			MIGS_02							= 0;
			gradegraphwidth						= 0;
			PPercentScore						= 0;
			MPercentScore						= 0;
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

			local pscorelist = PROFILEMAN:GetProfile(pn):GetHighScoreList(SongOrCourse,StepsOrTrail);
			assert(pscorelist);
			local pscores = pscorelist:GetHighScores();
			local ptopscore = pscores[1];
			
			local mscorelist = PROFILEMAN:GetMachineProfile():GetHighScoreList(SongOrCourse,StepsOrTrail);
			assert(mscorelist);
			local mscores = mscorelist:GetHighScores();
			local mtopscore = mscores[1];
			if ptopscore then
				PPercentScore = ptopscore:GetPercentDP();
			else
				PPercentScore = 0;
			end;
			if mtopscore then
				MPercentScore = mtopscore:GetPercentDP();
			else
				MPercentScore = 0;
			end;
			
			local scorelist = profile:GetHighScoreList(SongOrCourse,StepsOrTrail);
			assert(scorelist);
			local scores = scorelist:GetHighScores();
			local topscore = scores[1];

			if topscore then
				hs["Grade"]							= topscore:GetGrade();
				hs["PercentScore"]					= topscore:GetPercentDP();
				hs["Date"]							= string.sub( topscore:GetDate(),1,10 );
				hs["TapNoteScore_W1"]				= topscore:GetTapNoteScore("TapNoteScore_W1");
				hs["TapNoteScore_W2"]				= topscore:GetTapNoteScore("TapNoteScore_W2");
				hs["TapNoteScore_W3"]				= topscore:GetTapNoteScore("TapNoteScore_W3");
				hs["TapNoteScore_W4"]				= topscore:GetTapNoteScore("TapNoteScore_W4");
				hs["TapNoteScore_W5"]				= topscore:GetTapNoteScore("TapNoteScore_W5");
				hs["TapNoteScore_Miss"]				= topscore:GetTapNoteScore("TapNoteScore_Miss");
				hs["TapNoteScore_HitMine"]				= topscore:GetTapNoteScore("TapNoteScore_HitMine");
				hs["TapNoteScore_CheckpointMiss"]		= topscore:GetTapNoteScore("TapNoteScore_CheckpointMiss");
				hs["HoldNoteScore_Held"]				= topscore:GetHoldNoteScore("HoldNoteScore_Held");
				hs["HoldNoteScore_LetGo"]				= topscore:GetHoldNoteScore("HoldNoteScore_LetGo");
				hs["MaxCombo"]						= topscore:GetMaxCombo();
				if bIsCourseMode then
					SorCTime = SongOrCourse:GetTotalSeconds(GAMESTATE:GetCurrentStyle():GetStepsType());
					hs["SurvivalSeconds"] = SorCTime + 1;
				else
					SorCTime = SongOrCourse:GetLastSecond();
					hs["SurvivalSeconds"] = topscore:GetSurvivalSeconds();	
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
				hs["Grade"]							= "Grade_None";
				hs["PercentScore"]					= 0;
				hs["Date"]							= "-";
				hs["TapNoteScore_W1"]				= 0;
				hs["TapNoteScore_W2"]				= 0;
				hs["TapNoteScore_W3"]				= 0;
				hs["TapNoteScore_W4"]				= 0;
				hs["TapNoteScore_W5"]				= 0;
				hs["TapNoteScore_Miss"]				= 0;
				hs["TapNoteScore_HitMine"]				= 0;
				hs["TapNoteScore_CheckpointMiss"]		= 0;
				hs["HoldNoteScore_Held"]				= 0;
				hs["HoldNoteScore_LetGo"]				= 0;
				hs["MaxCombo"]						= 0;
				hs["SurvivalSeconds"]					= 0;
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
			if MIGS_MAX == 0 then MIGS_MAX = 1; end;
			gradegraphwidth = math.floor(MIGS / MIGS_MAX * graphwidth);
			if gradegraphwidth < 0 then gradegraphwidth = 0; end;
		else
			hs["Grade"]							= "Grade_None";
			hs["PercentScore"]					= 0;
			hs["TotalSteps"]						= 0;
			hs["RadarCategory_Holds"]				= 0;
			hs["RadarCategory_Rolls"]				= 0;
			hs["Date"]							= "-";
			hs["TapNoteScore_W1"]				= 0;
			hs["TapNoteScore_W2"]				= 0;
			hs["TapNoteScore_W3"]				= 0;
			hs["TapNoteScore_W4"]				= 0;
			hs["TapNoteScore_W5"]				= 0;
			hs["TapNoteScore_Miss"]				= 0;
			hs["TapNoteScore_HitMine"]				= 0;
			hs["TapNoteScore_CheckpointMiss"]		= 0;
			hs["HoldNoteScore_Held"]				= 0;
			hs["HoldNoteScore_LetGo"]				= 0;
			hs["MaxCombo"]						= 0;
			hs["SurvivalSeconds"]					= 0;
			MIGS								= 0;
			MIGS_MAX							= 0;
			MIGS_02							= 0;
			gradegraphwidth						= 0;
			PPercentScore						= 0;
			MPercentScore						= 0;
		end;
	end;
};

---------------------------------------------------------------------------------------------------------------------------------------

t[#t+1] = Def.Sprite{
	InitCommand=cmd(x,111;y,1;zoomy,1;);
	OnCommand=function(self)
		if pn == PLAYER_1 then
			self:Load(THEME:GetPathG("","PaneDisplay text/frame_p1"));
			(cmd(diffusealpha,0;addx,30;zoom,1.35;sleep,0.5;accelerate,0.4;diffusealpha,1;addx,-30;zoom,1;))(self)
		else
			self:Load(THEME:GetPathG("","PaneDisplay text/frame_p2"));
			(cmd(diffusealpha,0;addx,-30;zoom,1.35;sleep,0.5;accelerate,0.4;diffusealpha,1;addx,30;zoom,1;))(self)
		end;
	end;
	OffCommand=cmd(stoptweening;);
};

for idx, cat in pairs(paneCategoryValues) do
	local paneCategory = cat.Category;
	t[#t+1] = Def.ActorFrame{
		LoadFont("PaneDisplay text")..{
			InitCommand=cmd(horizalign,right;diffusealpha,0;sleep,0.7;zoom,0.75;sleep,idx/10;shadowlength,0;);
			SetCommand=function(self)
				self:x(0);
				self:y(0);
				if idx-1 >= 1 then
					self:y(15);
					self:x(math.abs((idx-1)*40)-4);
					self:maxwidth(35+10);
				else
					self:x(math.abs(idx-7)*40);
					self:maxwidth(43+10);
				end;

				local value = 0;
				self:diffuse(color("1,1,1,0.5"));
				if bIsCourseMode then
					SongOrCourse = GAMESTATE:GetCurrentCourse();
					StepsOrTrail = GAMESTATE:GetCurrentTrail(pn);
				else
					SongOrCourse = GAMESTATE:GetCurrentSong();
					StepsOrTrail = GAMESTATE:GetCurrentSteps(pn);
				end;
				if getenv("rnd_song") == 1 then
					value = 0;
				elseif SongOrCourse then
					-- we have a selection.
					-- Make sure there's something to grab values from.
					if StepsOrTrail then
						local rv = StepsOrTrail:GetRadarValues(pn);
						value = rv:GetValue(paneCategory);
						if value == 0 then
							self:diffusealpha(0.5);
						elseif value == "?" then
							self:diffusealpha(0.5);
						else
							self:diffusealpha(1);
						end;
					end;
				end;
				value = value < 0 and "?" or value
				self:settext( value );
				self:diffuse( CPaneValueToColor(paneCategory,value) )
			end;
		};
	};
end;

-- PercentGraph
t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(rotationy,180;x,-20.5;y,8);
	Def.Quad {
		InitCommand=cmd(zoomx,0;zoomy,6;horizalign,right;);
		SetCommand=function(self)
			(cmd(stoptweening;diffuse,color("0,1,1,0.8");diffusebottomedge,color("0,1,1,0.3");decelerate,0.1;zoomx,gradegraphwidth))(self);
			if gradegraphwidth == graphwidth then
				self:diffuse(color("1,1,0,0.8"));
				self:diffusebottomedge(color("1,1,0,0.3"));
			elseif hs["Grade"] == "Grade_Failed" then
				self:diffuse(color("1,0.15,0,0.8"));
				self:diffusebottomedge(color("1,0.15,0,0.3"));
			end;
			if not SongOrCourse then
				(cmd(stoptweening;decelerate,0.1;zoomx,0))(self);
			end;
		end;
	};
};

--PercentTierLine
for i = 2, 6 do
	local Tier = THEME:GetMetric("PlayerStageStats","GradePercentTier0"..i); 
	t[#t+1] = Def.ActorFrame {
		InitCommand=cmd(horizalign,right;x,-20.5;y,8;zoomx,1;zoomy,6);
		Def.Quad {
			InitCommand=cmd(addx,-6;sleep,0.3;linear,0.2;addx,6;);
			SetCommand=function(self)
				self:stoptweening();
				self:diffusetopedge(color("1,1,1,0.15"));
				self:diffusebottomedge(color("1,1,1,0.5"));
				if gradegraphwidth == graphwidth then
					self:visible(false);
				elseif hs["Grade"] == "Grade_Failed" then
					self:visible(false);
				else
					self:visible(true);
					self:x(math.floor(graphwidth * Tier));
				end;
			end;
		};
	};
end;

t[#t+1] = Def.ActorFrame {
	LoadActor(THEME:GetPathG("","graph_mini"))..{
		InitCommand=cmd(zoom,0.15;x,-114+120;y,-13-5;);
		OnCommand=cmd(diffusealpha,0;addx,10;sleep,0.7;decelerate,0.3;diffusealpha,1;addx,-10;);
		SetCommand=function(self)
			self:visible(false);
			if hs["SurvivalSeconds"] >= SorCTime then
				if hs["Grade"] ~= "Grade_None" and hs["Grade"] ~= "Grade_Failed" then
					if tonumber(hs["TotalSteps"]) > 0 then
						if hs["TapNoteScore_W4"] + hs["TapNoteScore_W5"] + hs["TapNoteScore_Miss"] + 
						hs["TapNoteScore_HitMine"] + hs["TapNoteScore_CheckpointMiss"] == 0 then
							self:visible(true);
							if hs["Grade"] == "Grade_Tier01" then self:x(9+6);
							elseif hs["Grade"] == "Grade_Tier02" then self:x(9+1);
							else self:x(9);
							end;
							if hs["TapNoteScore_W2"] + hs["TapNoteScore_W3"] == 0 and hs["PercentScore"] == 1 then
								self:diffuse(color("1,1,1,1"));
								self:glowshift();
							elseif hs["TapNoteScore_W3"] == 0 then
								self:diffuse(color("1,0.8,0,1"));
								self:glowshift();
							else
								self:diffuse(color("0.2,1,0.6,1"));
								self:stopeffect();
							end;
						end;
					end;
				end;
			end;
		end;
	};
};

--grade
if pm ~= "PlayMode_Oni" and pm ~= "PlayMode_Endless" then
	t[#t+1] = Def.Sprite{
		InitCommand=cmd(shadowlength,0;x,-122+120;y,-6-5;zoom,0.325;);
		OnCommand=cmd(diffusealpha,0;addx,20;sleep,0.6;decelerate,0.3;diffusealpha,1;addx,-20;);
		SetCommand=function(self)
			self:visible(false);
			if hs["Grade"] ~= "Grade_None" then
				self:visible(true);
				self:Load(THEME:GetPathG("GradeDisplayEval",ToEnumShortString( hs["Grade"] )));
			end;
		end;
	};
end;

if pm == "PlayMode_Oni" or pm == "PlayMode_Nonstop" then
	t[#t+1] = LoadFont("_shared2")..{
		InitCommand=cmd(shadowlength,0;x,-122+120;y,-2;zoom,0.5;);
		OnCommand=cmd(diffusealpha,0;addx,20;sleep,0.6;decelerate,0.3;diffusealpha,1;addx,-20;);
		SetCommand=function(self)
			self:visible(false);
			if hs["Grade"] ~= "Grade_None" and hs["Grade"] ~= "Grade_Failed" then
				self:visible(true);
				self:diffuse(color("0,1,1,1"));
				self:settext("Cleared");
			elseif hs["Grade"] ~= "Grade_None" and hs["Grade"] == "Grade_Failed" then
				self:visible(true);
				self:diffuse(color("1,0.2,0,1"));
				self:settext("Failed");		
			end;
		end;
	};
end;

t[#t+1] = Def.ActorFrame {
	--personal score
	LoadFont("PaneDisplay text")..{
		InitCommand=cmd(shadowlength,0;zoom,0.9;maxwidth,200;horizalign,right;zoomx,0.55;x,-50+120;y,-5;);
		OnCommand=cmd(zoomy,0;addx,20;sleep,0.75;decelerate,0.3;zoomy,1;addx,-20;);
		SetCommand=function(self)
			local ppercentsc = PPercentScore * 100;
			local text;
			if ppercentsc == 100 then
				text = "100%";
				self:zoomx(0.7);
				self:diffuse(color("0,1,1,1"));
			elseif ppercentsc == 0 then
				text = "0%";
				self:zoomx(0.55);
				self:diffuse(color("0,1,1,0.6"));
			elseif ppercentsc >= (Tier["Grade_Tier04"] * 100) then
				text = string.format("%.2f%%", ppercentsc);
				self:zoomx(0.55);
				self:diffuse(color("0,1,1,1"));
			elseif ppercentsc < (Tier["Grade_Tier04"] * 100) then
				text = string.format("%.2f%%", ppercentsc);
				self:zoomx(0.55);
				self:diffuse(color("0,0.775,0.775,1"));
			else
				self:zoomx(0.55);
				text = "0%";
				self:diffuse(color("0,1,1,0.6"));
			end;
			self:settext(text);
		end;
	};
	--machine score
	LoadFont("PaneDisplay text")..{
		InitCommand=cmd(shadowlength,0;zoom,0.9;maxwidth,200;horizalign,right;zoomx,0.55;x,120;y,-5;);
		OnCommand=cmd(zoomy,0;addx,10;sleep,0.65;decelerate,0.3;zoomy,1;addx,-10;);
		SetCommand=function(self)
			local mpercentsc = MPercentScore * 100;
			local text;
			if mpercentsc == 100 then
				text = "100%";
				self:zoomx(0.7);
				self:diffuse(color("1,1,1,1"));
			elseif mpercentsc == 0 then
				text = "0%";
				self:zoomx(0.55);
				self:diffuse(color("1,1,1,0.6"));
			elseif mpercentsc >= (Tier["Grade_Tier04"] * 100) then
				text = string.format("%.2f%%", mpercentsc);
				self:zoomx(0.55);
				self:diffuse(color("1,1,1,1"));
			elseif mpercentsc < (Tier["Grade_Tier04"] * 100) then
				text = string.format("%.2f%%", mpercentsc);
				self:zoomx(0.55);
				self:diffuse(color("0.775,0.775,0.775,1"));
			else
				text = "0%";
				self:zoomx(0.55);
				self:diffuse(color("1,1,1,0.6"));	
			end;
			self:settext(text);
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

t.CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
t.CurrentCourseChangedMessageCommand=cmd(playcommand,"Set");


return t;
