local pn = ...
assert(pn,"Must pass in a player, dingus");

local pm = GAMESTATE:GetPlayMode();
local ssStats = STATSMAN:GetCurStageStats();
local pnstats = ssStats:GetPlayerStageStats(pn);
local failed = pnstats:GetFailed();
local totalsteps = 0;
local holdsteps = 0;
local rollsteps = 0;
local judgewidth = 280;
local adgraph = GetAdhocPref("ScoreGraph"..ToEnumShortString(pn));
local adhoc = 0;
local cmigsadhoc = 0;
local bsp1fullcombo = 0;
local bsp2fullcombo = 0;
local hsp1fullcombo = 0;
local hsp2fullcombo = 0;
local bsMIGS = 0;
local hsMIGS = 0;
local MIGS_MAX = 0;
local psStats = STATSMAN:GetPlayedStageStats(1);
local failcount = 0;

--local start = psStats:GetPlayedSongs()[1]:GetFirstSecond();
local stepseconds = 0;
local aliveseconds = 0;

if GAMESTATE:IsCourseMode() then
	local ccourse = GAMESTATE:GetCurrentCourse();
	local co_stage = ccourse:GetEstimatedNumStages();
	local stindex = getenv("coursestindex");
	if stindex >= co_stage then
		stepseconds = stindex;
	else
		stepseconds = stindex + 10;
	end;
	aliveseconds = pnstats:GetSongsPassed();
else
	stepseconds = psStats:GetPlayedSongs()[1]:GetLastSecond();
	aliveseconds = getenv("aseconds");
end;



if adgraph ~= "Off" and adgraph ~= "nil" then
	if string.find(adgraph,"Tier") then
		adhoc = THEME:GetMetric("PlayerStageStats","GradePercent"..adgraph);
		elseif string.find(adgraph,"0.") then
		adhoc = adgraph;
	else adhoc = 0;
	end;
end;

local hs = {
	"Grade",
	"PercentScore",
	"TapNoteScore_W1",
	"TapNoteScore_W2",
	"TapNoteScore_W3",
	"TapNoteScore_W4",
	"TapNoteScore_W5",
	"TapNoteScore_Miss",
	"HoldNoteScore_Held",
	"HoldNoteScore_LetGo",
	"TapNoteScore_HitMine",
	"TapNoteScore_CheckpointMiss",
	"MaxCombo";
};
local bs = {
	"Grade",
	"PercentScore",
	"TapNoteScore_W1",
	"TapNoteScore_W2",
	"TapNoteScore_W3",
	"TapNoteScore_W4",
	"TapNoteScore_W5",
	"TapNoteScore_Miss",
	"HoldNoteScore_Held",
	"HoldNoteScore_LetGo",
	"TapNoteScore_HitMine",
	"TapNoteScore_CheckpointMiss",
	"MaxCombo";
	"SurvivalSeconds";
};

local statsCategoryValues = {
	{ Category = "TapNoteScore_W1" },
	{ Category = "TapNoteScore_W2" },
	{ Category = "TapNoteScore_W3" },
	{ Category = "HoldNoteScore_Held" },
	{ Category = "TapNoteScore_W4" },
	{ Category = "TapNoteScore_W5" },
	{ Category = "TapNoteScore_Miss" },
	{ Category = "MaxCombo" },
};

local restatsCategoryValues = {
	{ Category = "TapNoteScore_W1" , Color = Colors.Judgment["JudgmentLine_W1"] },
	{ Category = "TapNoteScore_W2" , Color = Colors.Judgment["JudgmentLine_W2"] },
	{ Category = "TapNoteScore_W3" , Color = Colors.Judgment["JudgmentLine_W3"] },
	{ Category = "TapNoteScore_W4" , Color = Colors.Judgment["JudgmentLine_W4"] },
	{ Category = "TapNoteScore_W5" , Color = Colors.Judgment["JudgmentLine_W5"] },
	{ Category = "TapNoteScore_Miss" , Color = Colors.Judgment["JudgmentLine_Miss"] },
	{ Category = "None" , Color = color("0.5,0.5,0.5,0.5") },
};
local restatsHoldCategoryValues = {
	{ Category = "HoldNoteScore_Held" , Color = Colors.Judgment["JudgmentLine_Held"] },
	{ Category = "HoldNoteScore_LetGo" , Color = Colors.Judgment["JudgmentLine_LetGo"] },
	{ Category = "None" , Color = color("0.5,0.5,0.5,0.5") },
};

local gpTier = {
	Tier01		= THEME:GetMetric("PlayerStageStats", "GradePercentTier01"),
	Tier02		= THEME:GetMetric("PlayerStageStats", "GradePercentTier02"),
	Tier03		= THEME:GetMetric("PlayerStageStats", "GradePercentTier03"),
	Tier04		= THEME:GetMetric("PlayerStageStats", "GradePercentTier04"),
	Tier05		= THEME:GetMetric("PlayerStageStats", "GradePercentTier05"),
	Tier06		= THEME:GetMetric("PlayerStageStats", "GradePercentTier06"),
	Tier07		= THEME:GetMetric("PlayerStageStats", "GradePercentTier07"),
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

local function GetGraphPosX(pn)
	local r = 0;
	if pn == PLAYER_1 then
		r = SCREEN_CENTER_X * 0.55;
	else
		r = SCREEN_CENTER_X * 1.55;
	end;
	return r;
end;

local t = Def.ActorFrame{
	Name="EvaluationUpset"..pn;
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

-- [ja] 今回のスコア
hs["Grade"]						= pnstats:GetGrade();
hs["PercentScore"]				= pnstats:GetPercentDancePoints();
hs["TapNoteScore_W1"]			= pnstats:GetTapNoteScores('TapNoteScore_W1');
hs["TapNoteScore_W2"]			= pnstats:GetTapNoteScores('TapNoteScore_W2');
hs["TapNoteScore_W3"]			= pnstats:GetTapNoteScores('TapNoteScore_W3');
hs["TapNoteScore_W4"]			= pnstats:GetTapNoteScores('TapNoteScore_W4');
hs["TapNoteScore_W5"]			= pnstats:GetTapNoteScores('TapNoteScore_W5');
hs["TapNoteScore_Miss"]			= pnstats:GetTapNoteScores('TapNoteScore_Miss');
hs["HoldNoteScore_Held"]			= pnstats:GetHoldNoteScores('HoldNoteScore_Held');
hs["HoldNoteScore_LetGo"]			= pnstats:GetHoldNoteScores('HoldNoteScore_LetGo');
hs["TapNoteScore_HitMine"]			= pnstats:GetTapNoteScores('TapNoteScore_HitMine');
hs["TapNoteScore_CheckpointMiss"]	= pnstats:GetTapNoteScores('TapNoteScore_CheckpointMiss');
hs["MaxCombo"]					= pnstats:MaxCombo();

if failed then hs["Grade"] = "Grade_Failed"
end;

if hs["Grade"] ~= "Grade_None" and hs["Grade"] ~= "Grade_Failed" then
	if aliveseconds >= stepseconds then
		if hs["PercentScore"] >= gpTier["Tier01"] then hs["Grade"] = "Grade_Tier01";
		elseif hs["PercentScore"] >= gpTier["Tier02"] then hs["Grade"] = "Grade_Tier02";
		elseif hs["PercentScore"] >= gpTier["Tier03"] then hs["Grade"] = "Grade_Tier03";
		elseif hs["PercentScore"] >= gpTier["Tier04"] then hs["Grade"] = "Grade_Tier04";
		elseif hs["PercentScore"] >= gpTier["Tier05"] then hs["Grade"] = "Grade_Tier05";
		elseif hs["PercentScore"] >= gpTier["Tier06"] then hs["Grade"] = "Grade_Tier06";
		else hs["Grade"] = "Grade_Tier07";
		end;
	else
		hs["Grade"] = "Grade_Failed";
	end;
end;

if hs["Grade"] == "Grade_Failed" then failcount = failcount + 1;
end;

hsMIGS = hs["TapNoteScore_W1"] * wp["TapNoteScore_W1"]
	+ hs["TapNoteScore_W2"] * wp["TapNoteScore_W2"]
	+ hs["TapNoteScore_W3"] * wp["TapNoteScore_W3"]
	+ hs["HoldNoteScore_Held"] * wp["HoldNoteScore_Held"]
	+ hs["TapNoteScore_HitMine"] * wp["TapNoteScore_HitMine"];
	
--setenv("evaPercent",hsMIGS);

totalsteps = pnstats:GetRadarPossible():GetValue('RadarCategory_TapsAndHolds');
holdsteps = pnstats:GetRadarPossible():GetValue('RadarCategory_Holds');
rollsteps = pnstats:GetRadarPossible():GetValue('RadarCategory_Rolls');
MIGS_MAX = totalsteps * wp["TapNoteScore_W1"]
		+ holdsteps * wp["HoldNoteScore_Held"]
		+ rollsteps * wp["HoldNoteScore_Held"];

cmigsadhoc = math.ceil(MIGS_MAX * adhoc);
--hscombo
if hs["Grade"] ~= "Grade_Failed" then
	if hs["TapNoteScore_W4"] + hs["TapNoteScore_W5"] + hs["TapNoteScore_Miss"] +
	hs["TapNoteScore_HitMine"] + hs["TapNoteScore_CheckpointMiss"] == 0 then
		if hs["TapNoteScore_W1"] + hs["TapNoteScore_W2"] + hs["TapNoteScore_W3"] > 0 then
			if hs["TapNoteScore_W2"] + hs["TapNoteScore_W3"] == 0 and hs["PercentScore"] == 1 then
				if pn == PLAYER_1 then hsp1fullcombo = 1;
				else hsp2fullcombo = 1;
				end;
			elseif hs["TapNoteScore_W3"] == 0 then
				if pn == PLAYER_1 then hsp1fullcombo = 2;
				else hsp2fullcombo = 2;
				end;
			else
				if pn == PLAYER_1 then hsp1fullcombo = 3;
				else hsp2fullcombo = 3;
				end;
			end;
		end;
	end;
end;

--[ja] トップスコア
local SongOrCourse, StepsOrTrail;
if GAMESTATE:IsCourseMode() then
	SongOrCourse = GAMESTATE:GetCurrentCourse();
	StepsOrTrail = GAMESTATE:GetCurrentTrail(pn);
else
	SongOrCourse = GAMESTATE:GetCurrentSong();
	StepsOrTrail = GAMESTATE:GetCurrentSteps(pn);
end;
if SongOrCourse and StepsOrTrail then
	local profile;
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

	if topscore and #scores > 1 then
		if topscore:GetScore() == pnstats:GetScore() then
			topscore = scores[2];
		end;
		bs["Grade"]						= topscore:GetGrade();
		bs["PercentScore"]				= topscore:GetPercentDP();
		bs["TapNoteScore_W1"]			= topscore:GetTapNoteScore('TapNoteScore_W1');
		bs["TapNoteScore_W2"]			= topscore:GetTapNoteScore('TapNoteScore_W2');
		bs["TapNoteScore_W3"]			= topscore:GetTapNoteScore('TapNoteScore_W3');
		bs["TapNoteScore_W4"]			= topscore:GetTapNoteScore('TapNoteScore_W4');
		bs["TapNoteScore_W5"]			= topscore:GetTapNoteScore('TapNoteScore_W5');
		bs["TapNoteScore_Miss"]			= topscore:GetTapNoteScore('TapNoteScore_Miss');
		bs["HoldNoteScore_Held"]			= topscore:GetHoldNoteScore('HoldNoteScore_Held');
		bs["HoldNoteScore_LetGo"]			= topscore:GetHoldNoteScore('HoldNoteScore_LetGo');
		bs["TapNoteScore_HitMine"]			= topscore:GetTapNoteScore('TapNoteScore_HitMine');
		bs["TapNoteScore_CheckpointMiss"]	= topscore:GetTapNoteScore('TapNoteScore_CheckpointMiss');
		bs["MaxCombo"]					= topscore:GetMaxCombo();
		bs["SurvivalSeconds"]				= topscore:GetSurvivalSeconds()
	else
		bs["Grade"]						= "Grade_None";
		bs["PercentScore"]				= 0;
		bs["TapNoteScore_W1"]			= 0;
		bs["TapNoteScore_W2"]			= 0;
		bs["TapNoteScore_W3"]			= 0;
		bs["TapNoteScore_W4"]			= 0;
		bs["TapNoteScore_W5"]			= 0;
		bs["TapNoteScore_Miss"]			= 0;
		bs["HoldNoteScore_Held"]			= 0;
		bs["HoldNoteScore_LetGo"]			= 0;
		bs["TapNoteScore_HitMine"]			= 0;
		bs["TapNoteScore_CheckpointMiss"]	= 0;
		bs["MaxCombo"]					= 0;
		bs["SurvivalSeconds"]				= 0;
	end;
end;

if bs["Grade"] ~= "Grade_None" and bs["Grade"] ~= "Grade_Failed" then
	if bs["SurvivalSeconds"] + 1 >= stepseconds then
		if bs["PercentScore"] >= gpTier["Tier01"] then bs["Grade"] = "Grade_Tier01";
		elseif bs["PercentScore"] >= gpTier["Tier02"] then bs["Grade"] = "Grade_Tier02";
		elseif bs["PercentScore"] >= gpTier["Tier03"] then bs["Grade"] = "Grade_Tier03";
		elseif bs["PercentScore"] >= gpTier["Tier04"] then bs["Grade"] = "Grade_Tier04";
		elseif bs["PercentScore"] >= gpTier["Tier05"] then bs["Grade"] = "Grade_Tier05";
		elseif bs["PercentScore"] >= gpTier["Tier06"] then bs["Grade"] = "Grade_Tier06";
		else bs["Grade"] = "Grade_Tier07";
		end;
	else
		bs["Grade"] = "Grade_Failed";
	end;
end;

--[ja] 意図的にFailedさせた時の対策
setenv("onpurposefailgrade","");
local IsAStage = not THEME:GetMetric( Var "LoadingScreen","Summary" ) and not GAMESTATE:IsCourseMode();
if IsAStage then
	local bLastStage = GAMESTATE:GetSmallestNumStagesLeftForAnyHumanPlayer();
	if bLastStage <= 0 then
		if psStats:GetStage() == "Stage_Extra1" or psStats:GetStage() == "Stage_Extra2" then
			if hs["Grade"] == "Grade_Failed" then
				setenv("onpurposefailgrade","Grade_Failed");
			end;
		end;
	end;
end;

bsMIGS = bs["TapNoteScore_W1"] * wp["TapNoteScore_W1"]
	+ bs["TapNoteScore_W2"] * wp["TapNoteScore_W2"]
	+ bs["TapNoteScore_W3"] * wp["TapNoteScore_W3"]
	+ bs["HoldNoteScore_Held"] * wp["HoldNoteScore_Held"]
	+ bs["TapNoteScore_HitMine"] * wp["TapNoteScore_HitMine"];
--bscombo
if bs["Grade"] ~= "" and bs["Grade"] ~= "Grade_Failed" then
	if bs["TapNoteScore_W4"] + bs["TapNoteScore_W5"] + bs["TapNoteScore_Miss"] +
	bs["TapNoteScore_HitMine"] + bs["TapNoteScore_CheckpointMiss"] == 0 then
		if bs["TapNoteScore_W1"] + bs["TapNoteScore_W2"] + bs["TapNoteScore_W3"] > 0 then
			if bs["TapNoteScore_W2"] + bs["TapNoteScore_W3"] == 0 and bs["PercentScore"] == 1 then
				if pn == PLAYER_1 then bsp1fullcombo = 1;
				else bsp2fullcombo = 1;
				end;
			elseif bs["TapNoteScore_W3"] == 0 then
				if pn == PLAYER_1 then bsp1fullcombo = 2;
				else bsp2fullcombo = 2;
				end;
			else
				if pn == PLAYER_1 then bsp1fullcombo = 3;
				else bsp2fullcombo = 3;
				end;
			end;
		end;
	end;
end;

if pm ~= 'PlayMode_Battle' and pm ~= 'PlayMode_Rave' then
	for idx, cat in pairs(restatsHoldCategoryValues) do
		local restatsholdCategory = cat.Category;
		local restatsholdColor = cat.Color;
		t[#t+1] = Def.ActorFrame{
			InitCommand=function(self)
				(cmd(x,GetGraphPosX(pn)-156.5;y,SCREEN_CENTER_Y-50+12;))(self);
			end;
			LoadActor("judgegraph")..{
				InitCommand=function(self)
					(cmd(horizalign,left;zoomtowidth,0;zoomtoheight,8;))(self);
				end;
				OnCommand=function(self)
					local value = 0;
					local cwx = 0;
					local stepscore = holdsteps + rollsteps;
					if restatsholdCategory == 'HoldNoteScore_Held' then
						value = hs["HoldNoteScore_Held"];
						cwx = 0;
					elseif restatsholdCategory == 'HoldNoteScore_LetGo' then
						value = hs["HoldNoteScore_LetGo"];
						cwx = hs["HoldNoteScore_Held"];
					else value = stepscore - hs["HoldNoteScore_Held"] - hs["HoldNoteScore_LetGo"];
						cwx = hs["HoldNoteScore_Held"] + hs["HoldNoteScore_LetGo"];
					end;
					self:x( judgewidth * (cwx / stepscore) );
					self:zoomtowidth( judgewidth * (value / stepscore) );
					self:diffuse(restatsholdColor);
					self:diffusealpha(0.75);
					(cmd(cropright,1;sleep,(idx*0.3);linear,0.3;cropright,0;))(self);
				end;
			};
		};
	end;

	for idx, cat in pairs(restatsCategoryValues) do
		local restatsCategory = cat.Category;
		local restatsColor = cat.Color;
		t[#t+1] = Def.ActorFrame{
			InitCommand=function(self)
				(cmd(x,GetGraphPosX(pn)-156.5;y,SCREEN_CENTER_Y-60+12;))(self);
			end;
			LoadActor("judgegraph")..{
				InitCommand=function(self)
					(cmd(horizalign,left;zoomtowidth,0;zoomtoheight,11;))(self);
				end;
				OnCommand=function(self)
					local value = 0;
					local cwx = 0;
					if restatsCategory == 'TapNoteScore_W1' then
						value = hs["TapNoteScore_W1"];
						cwx = 0;
					elseif restatsCategory == 'TapNoteScore_W2' then
						value = hs["TapNoteScore_W2"];
						cwx = hs["TapNoteScore_W1"];
					elseif restatsCategory == 'TapNoteScore_W3' then
						value = hs["TapNoteScore_W3"];
						cwx = hs["TapNoteScore_W1"] + hs["TapNoteScore_W2"];
					elseif restatsCategory == 'TapNoteScore_W4' then
						value = hs["TapNoteScore_W4"];
						cwx = hs["TapNoteScore_W1"] + hs["TapNoteScore_W2"] + hs["TapNoteScore_W3"];
					elseif restatsCategory == 'TapNoteScore_W5' then
						value = hs["TapNoteScore_W5"];
						cwx = hs["TapNoteScore_W1"] + hs["TapNoteScore_W2"] +
							hs["TapNoteScore_W3"] + hs["TapNoteScore_W4"];
					elseif restatsCategory == 'TapNoteScore_Miss' then
						value = hs["TapNoteScore_Miss"];
						cwx = hs["TapNoteScore_W1"] + hs["TapNoteScore_W2"] +
							hs["TapNoteScore_W3"] + hs["TapNoteScore_W4"] + hs["TapNoteScore_W5"];
					else value = totalsteps - hs["TapNoteScore_W1"] - hs["TapNoteScore_W2"] - hs["TapNoteScore_W3"] -
							hs["TapNoteScore_W4"] - hs["TapNoteScore_W5"] - hs["TapNoteScore_Miss"];
						cwx = hs["TapNoteScore_W1"] + hs["TapNoteScore_W2"] + hs["TapNoteScore_W3"] + 
							hs["TapNoteScore_W4"] + hs["TapNoteScore_W5"] + hs["TapNoteScore_Miss"];
					end;
					self:x( judgewidth * (cwx / totalsteps) );
					self:zoomtowidth( judgewidth * (value / totalsteps) );
					self:diffuse(restatsColor);
					self:diffusealpha(0.75);
					(cmd(cropright,1;sleep,(idx*0.1);linear,0.1;cropright,0;))(self);
				end;
			};
		};
	end;
	
	t[#t+1] = Def.ActorFrame{
		InitCommand=cmd(x,GetGraphPosX(pn);y,SCREEN_CENTER_Y;);
		--grade
		Def.ActorFrame{
			InitCommand=function(self)
				if not GAMESTATE:IsCourseMode() then
					self:visible(true);
				else self:visible(false);
				end;
				(cmd(y,10-6;))(self)
			end;
			LoadActor(THEME:GetPathG("","graph_mini"))..{
				InitCommand=cmd(x,-29-10;y,-6;);
				OnCommand=function(self)
					self:visible(true);
					if bs["Grade"] == "Grade_Tier01" then self:addx(6);
					elseif bs["Grade"] == "Grade_Tier02" then self:addx(1);
					else self:addx(0);
					end;
					(cmd(diffusealpha,0;zoom,0.5;addx,-20;sleep,0.05;accelerate,0.4;diffusealpha,1;zoom,0.15;addx,20;))(self)
					if pn == PLAYER_1 then
						if bsp1fullcombo ~= 0 then
							if bsp1fullcombo == 1 then (cmd(diffuse,color("1,1,1,1");glowshift))(self)
							elseif bsp1fullcombo == 2 then (cmd(diffuse,color("1,0.8,0,1");glowshift))(self)
							elseif bsp1fullcombo == 3 then (cmd(diffuse,color("0.2,1,0.6,1");stopeffect))(self)
							end;
						else self:diffuse(color("0,0,0,0"));
						end;
					else
						if bsp2fullcombo ~= 0 then
							if bsp2fullcombo == 1 then (cmd(diffuse,color("1,1,1,1");glowshift))(self)
							elseif bsp2fullcombo == 2 then (cmd(diffuse,color("1,0.8,0,1");glowshift))(self)
							elseif bsp2fullcombo == 3 then (cmd(diffuse,color("0.2,1,0.6,1");stopeffect))(self)
							end;
						else self:diffuse(color("0,0,0,0"));
						end;
					end;
				end;
			};

			Def.Sprite{
				InitCommand=cmd(x,-40-10;);
				OnCommand=function(self)
					self:visible(false);
					if pm == 'PlayMode_Regular' or pm == 'PlayMode_Nonstop' then
						if bs["Grade"] ~= "Grade_None" then
							self:visible(true);
							self:Load(THEME:GetPathG("GradeDisplayEval",ToEnumShortString( bs["Grade"] )));
						end;
						(cmd(diffusealpha,0;zoom,1.5;addx,-20;sleep,0.1;accelerate,0.4;diffusealpha,1;zoom,0.325;addx,20;))(self)
					end;
				end;
			};
		
			LoadActor("mark")..{
				InitCommand=cmd(x,-6;);
				OnCommand=function(self)
					(cmd(diffusealpha,0;zoom,1.5;addx,-20;sleep,0.15;accelerate,0.4;diffusealpha,1;zoom,1;addx,20;))(self)
				end;
			};

			LoadActor(THEME:GetPathG("","graph_mini"))..{
				InitCommand=cmd(x,55-4;y,-6;);
				OnCommand=function(self)
					self:visible(true);
					if hs["Grade"] == "Grade_Tier01" then self:addx(6);
					elseif hs["Grade"] == "Grade_Tier02" then self:addx(1);
					else self:addx(0);
					end;
					(cmd(diffusealpha,0;zoom,0.5;addx,-20;sleep,0.2;accelerate,0.4;diffusealpha,1;zoom,0.15;addx,20;))(self)
					if pn == PLAYER_1 then
						if hsp1fullcombo ~= 0 then
							if hsp1fullcombo == 1 then (cmd(diffuse,color("1,1,1,1");glowshift))(self)
							elseif hsp1fullcombo == 2 then (cmd(diffuse,color("1,0.8,0,1");glowshift))(self)
							elseif hsp1fullcombo == 3 then (cmd(diffuse,color("0.2,1,0.6,1");stopeffect))(self)
							end;
						else self:diffuse(color("0,0,0,0"));
						end;
					else
						if hsp2fullcombo ~= 0 then
							if hsp2fullcombo == 1 then (cmd(diffuse,color("1,1,1,1");glowshift))(self)
							elseif hsp2fullcombo == 2 then (cmd(diffuse,color("1,0.8,0,1");glowshift))(self)
							elseif hsp2fullcombo == 3 then (cmd(diffuse,color("0.2,1,0.6,1");stopeffect))(self)
							end;
						else self:diffuse(color("0,0,0,0"));
						end;
					end;
				end;
			};

			Def.Sprite{
				InitCommand=cmd(x,44-4;);
				OnCommand=function(self)
					self:visible(false);
					if pm == 'PlayMode_Regular' or pm == 'PlayMode_Nonstop' then
						if hs["Grade"] ~= "Grade_None" then
							self:visible(true);
							self:Load(THEME:GetPathG("GradeDisplayEval",ToEnumShortString( hs["Grade"] )));
						end;
						(cmd(diffusealpha,0;zoom,1.5;addx,-20;sleep,0.25;accelerate,0.4;diffusealpha,1;zoom,0.325;addx,20;))(self)
					end;
				end;
			};
		};
		--exscore
		Def.ActorFrame{
			InitCommand=cmd(y,40-4;);
			LoadFont("PaneDisplay text")..{
				InitCommand=cmd(x,-40+18;horizalign,right;maxwidth,60;);
				OnCommand=function(self)
					self:settext( bsMIGS );
					(cmd(diffusealpha,0;zoom,1.5;addx,-20;sleep,0.05;accelerate,0.4;diffusealpha,1;zoom,1;addx,20;))(self)
				end;
			};
		
			LoadActor("mark")..{
				InitCommand=cmd(x,-10;y,3);
				OnCommand=function(self)
					(cmd(diffusealpha,0;zoom,1.5;addx,-20;sleep,0.1;accelerate,0.4;diffusealpha,1;zoom,1;addx,20;))(self)
				end;
			};
		
			LoadFont("PaneDisplay text")..{
				InitCommand=cmd(x,44+18;horizalign,right;maxwidth,60;);
				OnCommand=function(self)
					self:settext( hsMIGS );
					(cmd(diffusealpha,0;zoom,1.5;addx,-20;sleep,0.15;accelerate,0.4;diffusealpha,1;zoom,1;addx,20;))(self)
				end;
			};

			LoadFont("PaneDisplay text")..{
				InitCommand=cmd(x,70;horizalign,left;);
				OnCommand=function(self)
					if hsMIGS - bsMIGS > 0 then self:settext( string.format( "+".."%i",hsMIGS - bsMIGS ) );
					else self:settext( string.format( "%i",hsMIGS - bsMIGS ) );
					end;
					if hsMIGS - bsMIGS == 0 then self:diffuse(color("1,1,1,1"));
					elseif hsMIGS - bsMIGS > 0 then self:diffuse(Colors.Count["Plus"]);
					elseif hsMIGS - bsMIGS < 0 then self:diffuse(Colors.Count["Minus"]);
					else self:diffuse(color("1,1,1,1"));
					end;
					(cmd(diffusealpha,0;zoom,1.5;addx,-20;sleep,0.2;accelerate,0.4;diffusealpha,1;zoom,0.7;addx,20;))(self)
				end;
			};
		};
		--target
		Def.ActorFrame{
			InitCommand=cmd(y,64-4;);
			LoadFont("PaneDisplay text")..{
				InitCommand=cmd(x,-40+18;horizalign,right;maxwidth,60;);
				OnCommand=function(self)
					self:settext( cmigsadhoc );
					(cmd(diffusealpha,0;zoom,1.5;addx,-20;sleep,0.05;accelerate,0.4;diffusealpha,1;zoom,1;addx,20;))(self)
				end;
			};
		
			LoadActor("mark")..{
				InitCommand=cmd(x,-10;y,3);
				OnCommand=function(self)
					(cmd(diffusealpha,0;zoom,1.5;addx,-20;sleep,0.1;accelerate,0.4;diffusealpha,1;zoom,1;addx,20;))(self)
				end;
			};
		
			LoadFont("PaneDisplay text")..{
				InitCommand=cmd(x,44+18;horizalign,right;maxwidth,60;);
				OnCommand=function(self)
					self:settext( hsMIGS );
					(cmd(diffusealpha,0;zoom,1.5;addx,-20;sleep,0.15;accelerate,0.4;diffusealpha,1;zoom,1;addx,20;))(self)
				end;
			};
			
			LoadFont("PaneDisplay text")..{
				InitCommand=cmd(x,70;horizalign,left;);
				OnCommand=function(self)
					if hsMIGS - cmigsadhoc > 0 then self:settext( string.format( "+".."%i",hsMIGS - cmigsadhoc ) );
					else self:settext( string.format( "%i",hsMIGS - cmigsadhoc ) );
					end;
					if hsMIGS - cmigsadhoc == 0 then self:diffuse(color("1,1,1,1"));
					elseif hsMIGS - cmigsadhoc > 0 then self:diffuse(Colors.Count["Plus"]);
					elseif hsMIGS - cmigsadhoc < 0 then self:diffuse(Colors.Count["Minus"]);
					else self:diffuse(color("1,1,1,1"));
					end;
					(cmd(diffusealpha,0;zoom,1.5;addx,-20;sleep,0.2;accelerate,0.4;diffusealpha,1;zoom,0.7;addx,20;))(self)
				end;
			};
		};
	};
end;

for idx, cat in pairs(statsCategoryValues) do
	local statsCategory = cat.Category;
	t[#t+1] = Def.ActorFrame{
		InitCommand=cmd(x,GetGraphPosX(pn));
		Def.ActorFrame{
			InitCommand=function(self)
				if idx >= 5 then
					self:y(SCREEN_CENTER_Y+104+38);
					if idx == 8 then self:x(90);
					else self:x(-206+(math.abs((idx-4)*72)));
					end;
				else
					if idx == 4 then self:x(90);
					else self:x(-206+(math.abs(idx*72)));
					end;
					self:y(SCREEN_CENTER_Y+104);
				end;
			end;
			LoadActor("_judge_labels")..{
				InitCommand=cmd(animate,false;);
				OnCommand=function(self)
					self:setstate(idx-1);
					(cmd(diffusealpha,0;zoom,1.5;addx,-20;sleep,idx*0.05;accelerate,0.4;diffusealpha,1;zoom,1;addx,20;))(self)
				end;
			};
			LoadFont("_numbers3")..{
				InitCommand=function(self)
					(cmd(horizalign,left;vertalign,bottom;x,-26;y,8;zoom,0.7))(self);
					if pn == PLAYER_1 then self:diffuse(PlayerColor(PLAYER_1));
					else self:diffuse(PlayerColor(PLAYER_2));
					end;
				end;
				OnCommand=function(self, param)
					(cmd(diffusealpha,0;addx,20;sleep,(idx*0.05)+0.1;linear,0.4;diffusealpha,1;addx,-20;))(self)
					local value = 0;
					if statsCategory == 'TapNoteScore_W1' then value = hs["TapNoteScore_W1"];
					elseif statsCategory == 'TapNoteScore_W2' then value = hs["TapNoteScore_W2"];
					elseif statsCategory == 'TapNoteScore_W3' then value = hs["TapNoteScore_W3"];
					elseif statsCategory == 'HoldNoteScore_Held' then value = hs["HoldNoteScore_Held"];
					elseif statsCategory == 'TapNoteScore_W4' then value = hs["TapNoteScore_W4"];
					elseif statsCategory == 'TapNoteScore_W5' then value = hs["TapNoteScore_W5"];
					elseif statsCategory == 'TapNoteScore_Miss' then value = hs["TapNoteScore_Miss"];
					elseif statsCategory == 'MaxCombo' then value = hs["MaxCombo"];
					end;
					self:maxwidth(60);
					--self:settext("555555");
					if value >= 0 and value <= 9 then
						self:settext( string.format("   ".."%i",value) );
					elseif value >= 10 and value <= 99 then
						self:settext( string.format("  ".."%02i",value) );
					elseif value >= 100 and value <= 999 then
						self:settext( string.format(" ".."%03i",value) );
					else
						self:settext( string.format("%04i",value) );
					end;
				end;
			};

			LoadFont("PaneDisplay text")..{
				InitCommand=function(self)
					if pm ~= 'PlayMode_Battle' and pm ~= 'PlayMode_Rave' then
						self:visible(true);
					else self:visible(false);
					end;
					(cmd(horizalign,right;x,34;y,15;zoom,0.7))(self);
				end;
				OnCommand=function(self)
					(cmd(diffusealpha,0;addx,20;sleep,(idx*0.05)+0.1;linear,0.4;diffusealpha,1;addx,-20;))(self)
					local bhvalue = 0;
					if statsCategory == 'TapNoteScore_W1' then bhvalue = hs["TapNoteScore_W1"] - bs["TapNoteScore_W1"];
					elseif statsCategory == 'TapNoteScore_W2' then bhvalue = hs["TapNoteScore_W2"] - bs["TapNoteScore_W2"];
					elseif statsCategory == 'TapNoteScore_W3' then bhvalue = hs["TapNoteScore_W3"] - bs["TapNoteScore_W3"];
					elseif statsCategory == 'HoldNoteScore_Held' then bhvalue = hs["HoldNoteScore_Held"] - bs["HoldNoteScore_Held"];
					elseif statsCategory == 'TapNoteScore_W4' then bhvalue = hs["TapNoteScore_W4"] - bs["TapNoteScore_W4"];
					elseif statsCategory == 'TapNoteScore_W5' then bhvalue = hs["TapNoteScore_W5"] - bs["TapNoteScore_W5"];
					elseif statsCategory == 'TapNoteScore_Miss' then bhvalue = hs["TapNoteScore_Miss"] - bs["TapNoteScore_Miss"];
					elseif statsCategory == 'MaxCombo' then bhvalue = hs["MaxCombo"] - bs["MaxCombo"];
					end;
					self:maxwidth(60);
					if bhvalue > 0 then self:settext( string.format( "+".."%i",bhvalue ) );
					else self:settext( string.format( "%i",bhvalue ) );
					end;
					if statsCategory == 'TapNoteScore_W1' or statsCategory == 'TapNoteScore_W2' or 
					statsCategory == 'TapNoteScore_W3' or statsCategory == 'HoldNoteScore_Held' or statsCategory == 'MaxCombo' then
						if bhvalue == 0 then self:diffuse(color("1,1,1,1"));
						elseif bhvalue > 0 then self:diffuse(Colors.Count["Plus"]);
						elseif bhvalue < 0 then self:diffuse(Colors.Count["Minus"]);
						else self:diffuse(color("1,1,1,1"));
						end;
					else
						if bhvalue == 0 then self:diffuse(color("1,1,1,1"));
						elseif bhvalue < 0 then self:diffuse(Colors.Count["Plus"]);
						elseif bhvalue > 0 then self:diffuse(Colors.Count["Minus"]);
						else self:diffuse(color("1,1,1,1"));
						end;
					end;
					--self:settext("555555");
				end;
			};
		};
	};
end;

if pm == 'PlayMode_Regular' or pm == 'PlayMode_Nonstop' then
	--grade
	t[#t+1] = Def.Sprite{
		InitCommand=cmd(horizalign,right;vertalign,bottom;x,GetGraphPosX(pn)-26;y,SCREEN_CENTER_Y-66);
		OnCommand=function(self)
			self:visible(false);
			local grade = hs["Grade"];
			if grade ~= "" then
				self:visible(true);
				self:Load(THEME:GetPathG("GradeDisplayEval",ToEnumShortString( grade )));
			end;
			(cmd(zoom,0;sleep,2;zoomx,0.95;zoomy,5;accelerate,0.15;zoomy,0.95;))(self)
		end;
	};
end;

---------------------------------------------------------------------------------------------------------------------------------------
--expoints
if getenv("exflag") == "csc" and psStats:GetStage() ~= "Stage_Extra2" then
	if GAMESTATE:GetNumPlayersEnabled() == 1 then
		local ccstpoint = getenv("ccstpoint");	--[ja] 今までの総合ポイント
		local oldpoint = getenv("oldpoint");	--[ja] 今までのポイント
		local newpoint = getenv("newpoint");	--[ja] 今回のポイント

		local cpoint = 0;
		local co = 0;
		
		t[#t+1] = LoadActor("eva_fpointframe")..{
			InitCommand=cmd(x,GetGraphPosX(pn)+52;y,SCREEN_CENTER_Y-100;shadowlength,2;addx,-20;
						diffusealpha,0;maxwidth,80;shadowlength,0;diffuse,color("0,1,1,1"););
			OnCommand=cmd(sleep,2;decelerate,0.3;addx,20;diffusealpha,1;);
		};
		
		t[#t+1] = LoadFont("PaneDisplay","text") .. {
			InitCommand=cmd(horizalign,left;x,GetGraphPosX(pn)-20;y,SCREEN_CENTER_Y-90;
						shadowlength,2;zoomy,0;skewx,-0.125;maxwidth,50;diffuse,color("0,1,1,1"););
			OnCommand=cmd(sleep,2;decelerate,0.3;zoomy,1;playcommand,"Count";);
			CountCommand=function(self)
				local tpoint;
				if ccstpoint >= ccstpoint + (newpoint - oldpoint) then
					tpoint = ccstpoint.. " + 0";
				else
					tpoint = ccstpoint.." + "..newpoint - oldpoint;
				end;
				self:settext(tpoint);
			end;
		};

		t[#t+1] = LoadFont("CourseEntryDisplay","number") .. {
			InitCommand=cmd(horizalign,right;x,GetGraphPosX(pn)+122;y,SCREEN_CENTER_Y-90;
						shadowlength,2;addx,20;diffuse,color("0,1,1,0");skewx,-0.125;maxwidth,80;);
			OnCommand=cmd(sleep,2.2;decelerate,0.3;addx,-20;diffuse,color("0,1,1,1");playcommand,"Count";);
			CountCommand=function(self)
				--self:finishtweening();
				self:sleep(0.025);
				if ccstpoint >= ccstpoint + (newpoint - oldpoint) then
					cpoint = ccstpoint;
				else
					cpoint = ccstpoint + (newpoint - oldpoint);
				end;
				self:settext(co);
				co = co + 1;
				if co <= cpoint then
					self:queuecommand("Count");
				end;
				if getenv("omsflag") == 1 and psStats:GetStage() ~= "Stage_Extra2" then
					setenv("cpoint",cpoint);
				end;
			end;
		};
	end;
end;

---------------------------------------------------------------------------------------------------------------------------------------
--coflag
local cf_flag = split(":",GetCCParameter("Status"));
local cc_path = "CSDataSave/0001_cc CSCountExt";
local maxStages = PREFSMAN:GetPreference("SongsPerPlay");

if getenv("evacountupflag") == 1 then
	function GetCCCount()
		local ccpoint = {};
		local cf_point;
		local ppoint = 1;
		if GAMESTATE:GetNumPlayersEnabled() > 1 then ppoint = ppoint / 2;
		end;
		for k=1, 9 do
			if File.Read( cc_path ) then
				cf_point = split(",",cf_flag[k]);
				if #cf_point >= 3 then
					if tonumber(cf_point[2]) <= 100001 then
						if failcount == 0 then
							if pm == 'PlayMode_Regular' then
								if maxStages >= 3 then
									if getenv("exflag") ~= "csc" and psStats:GetStage() == "Stage_Extra1" then
										if cf_point[1] == "Ecco" then
											cf_point[2] = tonumber(cf_point[2]) + ppoint;
										end;
									elseif getenv("exflag") ~= "csc" and getenv("omsflag") == 0 and psStats:GetStage() == "Stage_Extra2" then
										if cf_point[1] == "Esco" then
											cf_point[2] = tonumber(cf_point[2]) + ppoint;
										end;
									elseif getenv("exflag") == "csc" and psStats:GetStage() == "Stage_Extra1" then
										if cf_point[1] == "Ccco" then
											cf_point[2] = tonumber(cf_point[2]) + ppoint;
										end;
									elseif getenv("exflag") == "csc" and getenv("omsflag") == 1 and psStats:GetStage() == "Stage_Extra2" then
										if cf_point[1] == "Csco" then
											cf_point[2] = tonumber(cf_point[2]) + ppoint;
										end;
									end;
								end;
								if cf_point[1] == "Sco" then 
									cf_point[2] = tonumber(cf_point[2]) + ppoint;
								end;
							elseif pm == 'PlayMode_Nonstop' then
								if cf_point[1] == "Non" then 
									cf_point[2] = tonumber(cf_point[2]) + ppoint;
								end;
							elseif pm == 'PlayMode_Oni' then
								if cf_point[1] == "Cha" then 
									cf_point[2] = tonumber(cf_point[2]) + ppoint;
								end;
							elseif pm == 'PlayMode_Endless' then
								if cf_point[1] == "End" then 
									cf_point[2] = cf_point[2];
								end;
							elseif pm == 'PlayMode_Rave' then
								if cf_point[1] == "Rav" then 
									cf_point[2] = tonumber(cf_point[2]) + ppoint;
								end;
							end;
						end;
						if failcount >= 1 then
							if cf_point[1] == "End" then
								cf_point[2] = cf_point[2] + ppoint;
							end;
						end;
						if not cf_point[3] then
							cf_point[3] = 0;
						end;
						ccpoint[#ccpoint+1] = { ""..cf_point[1]..","..tonumber(cf_point[2])..","..cf_point[3]..":" };
					end;
				else
					if failcount == 0 then
						if pm == 'PlayMode_Regular' then
							if k == 6 then
								if maxStages >= 3 then
									if getenv("exflag") ~= "csc" and psStats:GetStage() == "Stage_Extra1" then
										ccpoint[#ccpoint+1] = { "Ecco,"..ppoint..",0:" };
									else ccpoint[#ccpoint+1] = { "Ecco,0,0:" }; 
									end;
								else ccpoint[#ccpoint+1] = { "Ecco,0,0:" }; 
								end;
							elseif k == 7 then
								if maxStages >= 3 then
									if getenv("exflag") ~= "csc" and getenv("omsflag") == 0 and psStats:GetStage() == "Stage_Extra2" then
										ccpoint[#ccpoint+1] = { "Esco,"..ppoint..",0:" };
									else ccpoint[#ccpoint+1] = { "Esco,0,0:" }; 
								end;
								else ccpoint[#ccpoint+1] = { "Esco,0,0:" };
								end;
							elseif k == 8 then
								if maxStages >= 3 then
									if getenv("exflag") == "csc" and psStats:GetStage() == "Stage_Extra1" then
										ccpoint[#ccpoint+1] = { "Ccco,"..ppoint..",0:" };
									else ccpoint[#ccpoint+1] = { "Csco,0,0:" }; 
									end;
								else ccpoint[#ccpoint+1] = { "Ccco,0,0:" };
								end;
							elseif k == 9 then
								if maxStages >= 3 then
									if getenv("exflag") == "csc" and getenv("omsflag") == 1 and psStats:GetStage() == "Stage_Extra2" then
										ccpoint[#ccpoint+1] = { "Csco,"..ppoint..",0:" };
									else ccpoint[#ccpoint+1] = { "Csco,0,0:" };
									end;
								else ccpoint[#ccpoint+1] = { "Csco,0,0:" };
								end;
							end;
							if k == 1 then
								ccpoint[#ccpoint+1] = { "Sco,"..ppoint..",0:" };
							end;
						end;
						if k == 2 then
							if pm == 'PlayMode_Nonstop' then ccpoint[#ccpoint+1] = { "Non,"..ppoint..",0:" };
							else ccpoint[#ccpoint+1] = { "Non,0,0:" };
							end;
						elseif k == 3 then
							if pm == 'PlayMode_Oni' then ccpoint[#ccpoint+1] = { "Cha,"..ppoint..",0:" };
							else ccpoint[#ccpoint+1] = { "Cha,0,0:" };
							end;
						elseif k == 5 then
							if pm == 'PlayMode_Rave' then ccpoint[#ccpoint+1] = { "Rav,"..ppoint..",0:" };
							else ccpoint[#ccpoint+1] = { "Rav,0,0:" };
							end;
						end;
					elseif failcount >= 1 then
						if k == 1 then ccpoint[#ccpoint+1] = { "Sco,0,0:" };
						elseif k == 2 then ccpoint[#ccpoint+1] = { "Non,0,0:" };
						elseif k == 3 then ccpoint[#ccpoint+1] = { "Cha,0,0:" };
						elseif k == 4 then ccpoint[#ccpoint+1] = { "End,"..ppoint..",0:" };
						elseif k == 5 then ccpoint[#ccpoint+1] = { "Rav,0,0:" };
						elseif k == 6 then ccpoint[#ccpoint+1] = { "Ecco,0,0:" };
						elseif k == 7 then ccpoint[#ccpoint+1] = { "Esco,0,0:" };
						elseif k == 8 then ccpoint[#ccpoint+1] = { "Ccco,0,0:" };
						elseif k == 9 then ccpoint[#ccpoint+1] = { "Csco,0,0:" };
						end;
					end;
				end;
			else
				if failcount == 0 then
					if pm == 'PlayMode_Regular' then
						if k == 6 then
							if maxStages >= 3 then
								if getenv("exflag") ~= "csc" and psStats:GetStage() == "Stage_Extra1" then
									ccpoint[#ccpoint+1] = { "Ecco,"..ppoint..",0:" };
								else ccpoint[#ccpoint+1] = { "Ecco,0,0:" }; 
								end;
							else ccpoint[#ccpoint+1] = { "Ecco,0,0:" }; 
							end;
						elseif k == 7 then
							if maxStages >= 3 then
								if getenv("exflag") ~= "csc" and getenv("omsflag") == 0 and psStats:GetStage() == "Stage_Extra2" then
									ccpoint[#ccpoint+1] = { "Esco,"..ppoint..",0:" };
								else ccpoint[#ccpoint+1] = { "Esco,0,0:" }; 
							end;
							else ccpoint[#ccpoint+1] = { "Esco,0,0:" };
							end;
						elseif k == 8 then
							if maxStages >= 3 then
								if getenv("exflag") == "csc" and psStats:GetStage() == "Stage_Extra1" then
									ccpoint[#ccpoint+1] = { "Ccco,"..ppoint..",0:" };
								else ccpoint[#ccpoint+1] = { "Csco,0,0:" }; 
								end;
							else ccpoint[#ccpoint+1] = { "Ccco,0,0:" };
							end;
						elseif k == 9 then
							if maxStages >= 3 then
								if getenv("exflag") == "csc" and getenv("omsflag") == 1 and psStats:GetStage() == "Stage_Extra2" then
									ccpoint[#ccpoint+1] = { "Csco,"..ppoint..",0:" };
								else ccpoint[#ccpoint+1] = { "Csco,0,0:" };
								end;
							else ccpoint[#ccpoint+1] = { "Csco,0,0:" };
							end;
						end;
						if k == 1 then ccpoint[#ccpoint+1] = { "Sco,"..ppoint..",0:" };
						end;
					end;
					if k == 2 then
						if pm == 'PlayMode_Nonstop' then ccpoint[#ccpoint+1] = { "Non,"..ppoint..",0:" };
						else ccpoint[#ccpoint+1] = { "Non,0,0:" };
						end;
					elseif k == 3 then
						if pm == 'PlayMode_Oni' then ccpoint[#ccpoint+1] = { "Cha,"..ppoint..",0:" };
						else ccpoint[#ccpoint+1] = { "Cha,0,0:" };
						end;
					elseif k == 5 then
						if pm == 'PlayMode_Rave' then ccpoint[#ccpoint+1] = { "Rav,"..ppoint..",0:" };
						else ccpoint[#ccpoint+1] = { "Rav,0,0:" };
						end;
					end;
				elseif failcount >= 1 then
					if k == 1 then ccpoint[#ccpoint+1] = { "Sco,0,0:" };
					elseif k == 2 then ccpoint[#ccpoint+1] = { "Non,0,0:" };
					elseif k == 3 then ccpoint[#ccpoint+1] = { "Cha,0,0:" };
					elseif k == 4 then ccpoint[#ccpoint+1] = { "End,"..ppoint..",0:" };
					elseif k == 5 then ccpoint[#ccpoint+1] = { "Rav,0,0:" };
					elseif k == 6 then ccpoint[#ccpoint+1] = { "Ecco,0,0:" };
					elseif k == 7 then ccpoint[#ccpoint+1] = { "Esco,0,0:" };
					elseif k == 8 then ccpoint[#ccpoint+1] = { "Ccco,0,0:" };
					elseif k == 9 then ccpoint[#ccpoint+1] = { "Csco,0,0:" };
					end;
				end;
			end;
		end;
		return ccpoint;
	end;
	local CCList = GetCCCount();
	local ccptext = "#Status:";

	for i=1, 9 do
		if CCList[i] then
			ccptext = ccptext..""..table.concat(CCList[i]);
		else
			ccptext = ccptext;
		end;
	end;
	ccptext = string.sub(ccptext,1,-2);
	ccptext = ccptext..";\r\n";
	File.Write( cc_path , ccptext );
end;

---------------------------------------------------------------------------------------------------------------------------------------
--[[	
	t[#t+1] = LoadFont("Common normal")..{
		InitCommand=cmd(x,SCREEN_RIGHT-100;y,SCREEN_TOP+66;horizalign,right;zoom,0.45;playcommand,"Set");
		SetCommand=function(self)
			self:settext(aliveseconds);
		end;	
	};

	t[#t+1] = LoadFont("Common normal")..{
		InitCommand=cmd(x,SCREEN_RIGHT-100;y,SCREEN_TOP+66;horizalign,right;zoom,0.45;playcommand,"Set");
		SetCommand=function(self)
			self:settext("alive : "..bs["SurvivalSeconds"]);
		end;	
	};
	
	t[#t+1] = LoadFont("Common normal")..{
		InitCommand=cmd(x,SCREEN_RIGHT-100;y,SCREEN_TOP+76;horizalign,right;zoom,0.45;playcommand,"Set");
		SetCommand=function(self)
			self:settext("step : "..stepseconds);
		end;	
	};
]]

return t;