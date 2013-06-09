
local pn = ...;
assert(pn);

local t = Def.ActorFrame{};

local ccourse = GAMESTATE:GetCurrentCourse();

local IsUsingSoloSingles = PREFSMAN:GetPreference('Center1Player');
local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn);
local numpn = GAMESTATE:GetNumPlayersEnabled();
local cst = GAMESTATE:GetCurrentStyle():GetStyleType();
local stt = GAMESTATE:GetCurrentStyle():GetStepsType();
local ingamestatsp1 = GetAdhocPref("IngameStatsP1");
local ingamestatsp2 = GetAdhocPref("IngameStatsP2");
local adgraph = GetAdhocPref("ScoreGraph"..ToEnumShortString(pn));

local statsCategoryValues = {
	{ Category = "TapNoteScore_W1" , Color = Colors.Judgment["JudgmentLine_W1"] , Text = "FA"},
	{ Category = "TapNoteScore_W2" , Color = Colors.Judgment["JudgmentLine_W2"] , Text = "WO"},
	{ Category = "TapNoteScore_W3" , Color = Colors.Judgment["JudgmentLine_W3"] , Text = "GR"},
	{ Category = "TapNoteScore_W4" , Color = Colors.Judgment["JudgmentLine_W4"] , Text = "GO"},
	{ Category = "TapNoteScore_W5" , Color = Colors.Judgment["JudgmentLine_W5"] , Text = "BA"},
	{ Category = "TapNoteScore_Miss" , Color = Colors.Judgment["JudgmentLine_Miss"] , Text = "PO"},
	{ Category = "HoldNoteScore_Held" , Color = Colors.Judgment["JudgmentLine_Held"] , Text = "OK"},
};

local hs = {
	TotalSteps = 0,
	RadarCategory_Holds = 0,
	RadarCategory_Rolls = 0,
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

local stats = {
	TapNoteScore_W1 = 0,
	TapNoteScore_W2 = 0,
	TapNoteScore_W3 = 0,
	TapNoteScore_W4 = 0,
	TapNoteScore_W5 = 0,
	TapNoteScore_Miss = 0,
	HoldNoteScore_Held = 0,
	TapNoteScore_HitMine = 0,
	HoldNoteScore_LetGo = 0,
	TapNoteScore_AvoidMine = 0,
	TapNoteScore_CheckpointHit = 0,
	TapNoteScore_CheckpointMiss = 0,
	MaxCombo = 0,
};

local targetgraphheight = {
	Tier01 = 0;
	Tier02 = 1;
	Tier03 = 2;
	Tier04 = 3;
};

local MIGS = 0;
local MIGS_MAX = 0;
local cMIGS_MAX = 0;
local cscoregraphheight = 0;
local targetcoregraphheight = 0;
local graphheight = 220;
local adhoc = 0;
local w1Notes = 0;
local w2Notes = 0;
local w3Notes = 0;
local heldNotes = 0;
local hitMine = 0;
local chit = 0;
local migsad = 0;
local migsadhoc = 0;
local cmigsad = 0;
local cmigsadhoc = 0;
local per _tier = 0;

local function GetGraphPosX(pn)
	local r = 0;
	if numpn == 1 then
		if pn == PLAYER_1 then
			r=SCREEN_RIGHT-80;
		else
			r=SCREEN_LEFT+80;
		end;
	end;
	return r;
end;

local gpTier = {
	Tier01 = THEME:GetMetric("PlayerStageStats", "GradePercentTier01"),
	Tier02 = THEME:GetMetric("PlayerStageStats", "GradePercentTier02"),
	Tier03 = THEME:GetMetric("PlayerStageStats", "GradePercentTier03"),
	Tier04 = THEME:GetMetric("PlayerStageStats", "GradePercentTier04"),
	Tier05 = THEME:GetMetric("PlayerStageStats", "GradePercentTier05"),
	Tier06 = THEME:GetMetric("PlayerStageStats", "GradePercentTier06"),
	Tier07 = THEME:GetMetric("PlayerStageStats", "GradePercentTier07"),
};

---------------------------------------------------------------------------------------------------------------------------------------
--scoreset
t[#t+1] = LoadFont("PaneDisplay text")..{
	InitCommand=cmd(playcommand,"Set");
	UpdateCommand=cmd(playcommand,"Set";);
	SetCommand=function(self)
--		setenv("csperp","Grade_Tier01");
--		(cmd(horizalign,left;zoom,0.85;shadowlength,0;))(self)
		local StepsOrTrail;
		if GAMESTATE:IsCourseMode() then
			local ts = 0;
			local th = 0;
			local tr = 0;
			StepsOrTrail = GAMESTATE:GetCurrentTrail(pn):GetTrailEntries();
			for i = 1, #StepsOrTrail do
				ts = ts + StepsOrTrail[i]:GetSteps():GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds');
				th = th + StepsOrTrail[i]:GetSteps():GetRadarValues(pn):GetValue('RadarCategory_Holds');
				tr = tr + StepsOrTrail[i]:GetSteps():GetRadarValues(pn):GetValue('RadarCategory_Rolls');
			end;
			hs["TotalSteps"] = ts;
			hs["RadarCategory_Holds"] = th;
			hs["RadarCategory_Rolls"] = tr;
		else
			StepsOrTrail = GAMESTATE:GetCurrentSteps(pn);
			hs["TotalSteps"]			= StepsOrTrail:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds');
			hs["RadarCategory_Holds"]	= StepsOrTrail:GetRadarValues(pn):GetValue('RadarCategory_Holds');
			hs["RadarCategory_Rolls"]	= StepsOrTrail:GetRadarValues(pn):GetValue('RadarCategory_Rolls');
		end;
		if adgraph ~= "Off" and adgraph ~= "nil" then
			if string.find(adgraph,"Tier") then
				adhoc = THEME:GetMetric("PlayerStageStats","GradePercent"..adgraph);
			elseif string.find(adgraph,"0.") then
				adhoc = adgraph;
			else adhoc = 0;
			end;
		end;
		MIGS_MAX = hs["TotalSteps"] * wp["TapNoteScore_W1"]
				+ hs["RadarCategory_Holds"] * wp["HoldNoteScore_Held"]
				+ hs["RadarCategory_Rolls"] * wp["HoldNoteScore_Held"];
		migsad = MIGS_MAX * adhoc;
		migsadhoc = math.ceil(MIGS_MAX * adhoc);
	end;
	JudgmentMessageCommand=function(self, params)
		if params.Player == pn then
			if params.HoldNoteScore == 'HoldNoteScore_Held' then
				stats["HoldNoteScore_Held"] = stats["HoldNoteScore_Held"] + 1;
			elseif params.HoldNoteScore == 'HoldNoteScore_LetGo' then
				stats["HoldNoteScore_LetGo"] = stats["HoldNoteScore_LetGo"] + 1;
			elseif params.TapNoteScore == 'TapNoteScore_HitMine' then
				stats["TapNoteScore_HitMine"] = stats["TapNoteScore_HitMine"] + 1;
			elseif params.TapNoteScore == 'TapNoteScore_W1' then
				stats["TapNoteScore_W1"] = stats["TapNoteScore_W1"] + 1;
			elseif params.TapNoteScore == 'TapNoteScore_W2' then
				stats["TapNoteScore_W2"] = stats["TapNoteScore_W2"] + 1;
			elseif params.TapNoteScore == 'TapNoteScore_W3' then
				stats["TapNoteScore_W3"] = stats["TapNoteScore_W3"] + 1;
			elseif params.TapNoteScore == 'TapNoteScore_W4' then
				stats["TapNoteScore_W4"] = stats["TapNoteScore_W4"] + 1;
			elseif params.TapNoteScore == 'TapNoteScore_W5' then
				stats["TapNoteScore_W5"] = stats["TapNoteScore_W5"] + 1;
			elseif params.TapNoteScore == 'TapNoteScore_Miss' then
				stats["TapNoteScore_Miss"] = stats["TapNoteScore_Miss"] + 1;
			elseif params.TapNoteScore == 'TapNoteScore_CheckpointHit' then
				stats["TapNoteScore_CheckpointHit"] = stats["TapNoteScore_CheckpointHit"] + 1;
			elseif params.TapNoteScore == 'TapNoteScore_CheckpointMiss' then
				stats["TapNoteScore_CheckpointMiss"] = stats["TapNoteScore_CheckpointMiss"] + 1;
			end;
			stats["MaxCombo"] = pss:MaxCombo();
			
			w1Notes = stats["TapNoteScore_W1"] * wp["TapNoteScore_W1"];
			w2Notes = stats["TapNoteScore_W2"] * wp["TapNoteScore_W2"];
			w3Notes = stats["TapNoteScore_W3"] * wp["TapNoteScore_W3"];
			heldNotes = stats["HoldNoteScore_Held"] * wp["HoldNoteScore_Held"];
			hitMine = stats["TapNoteScore_HitMine"] * wp["TapNoteScore_HitMine"];
			cHit = stats["TapNoteScore_CheckpointHit"] * wp["TapNoteScore_W1"];

--			local pshold = pss:GetRadarActual():GetValue('RadarCategory_Holds');
--			local psroll = pss:GetRadarActual():GetValue('RadarCategory_Rolls');
			cMIGS_MAX = (stats["TapNoteScore_W1"] + stats["TapNoteScore_W2"] +
					stats["TapNoteScore_W3"] + stats["TapNoteScore_W4"] + 
					stats["TapNoteScore_W5"] + stats["TapNoteScore_Miss"] + 
					stats["HoldNoteScore_Held"] + stats["HoldNoteScore_LetGo"] + 
					stats["TapNoteScore_CheckpointMiss"]) * wp["TapNoteScore_W1"];

			--setenv("cw1score",stats["TapNoteScore_W1"]);
			--setenv("cw2score",stats["TapNoteScore_W2"]);
			--setenv("cw3score",stats["TapNoteScore_W3"]);
			--setenv("cw4score",stats["TapNoteScore_W4"]);
			--setenv("cw5score",stats["TapNoteScore_W5"]);
			--setenv("cmissscore",stats["TapNoteScore_Miss"]);
			--setenv("chminescore",stats["TapNoteScore_HitMine"]);
			--setenv("ccmissscore",stats["TapNoteScore_CheckpointMiss"]);
			--setenv("cheldscore",stats["HoldNoteScore_Held"]);
			--setenv("cletgoscore",stats["HoldNoteScore_LetGo"]);
			--setenv("cmaxcombo",stats["MaxCombo"]);
			MIGS = w1Notes + w2Notes + w3Notes + heldNotes + hitMine;
			cscoregraphheight = math.ceil(MIGS / MIGS_MAX * graphheight);
			cmigsad = cMIGS_MAX * adhoc;
			cmigsadhoc = math.ceil(cMIGS_MAX * adhoc);
			cscoregraphheight = math.floor(MIGS / MIGS_MAX * graphheight);
			if cscoregraphheight < 0 then cscoregraphheight = 0; end;
			targetcoregraphheight = math.floor( (cMIGS_MAX * adhoc ) / MIGS_MAX * graphheight);
			if targetcoregraphheight < 0 then targetcoregraphheight = 0; end;
--			local exscore = w1Notes + w2Notes + w3Notes + heldNotes;
			per_tier = MIGS / MIGS_MAX;
		end;
	end;
};

---------------------------------------------------------------------------------------------------------------------------------------
if (adgraph ~= "Off" and adgraph ~= "nil") then
	if numpn == 1 then
		if cst ~= 'StyleType_OnePlayerTwoSides' and cst ~= 'StyleType_TwoPlayersTwoSides' then
			t[#t+1] = Def.ActorFrame{
				InitCommand=function(self)
					self:y(SCREEN_CENTER_Y);
					if stt == 'StepsType_Dance_Solo' then
						if pn == PLAYER_1 then self:x(GetGraphPosX(pn)+18);
						else self:x(GetGraphPosX(pn)-26);
						end;
					else self:x(GetGraphPosX(pn));
					end;
				end;
				OnCommand=function(self)
					self:visible(true);
					if pn == PLAYER_1 then
						if adgraph ~= "Off" and adgraph ~= "nil" then
							(cmd(diffusealpha,0;addx,80;sleep,0.2;decelerate,0.4;diffusealpha,1;addx,-80;))(self)
						end;
					elseif pn == PLAYER_2 then
						if adgraph ~= "Off" and adgraph ~= "nil" then
							(cmd(diffusealpha,0;addx,-80;sleep,0.2;decelerate,0.4;diffusealpha,1;addx,80;))(self)
						end;
					else
						self:visible(false);
					end;
				end;
				LoadActor("tiergraph_back")..{
				};
				
				--maxexscore
				LoadFont("PaneDisplay text")..{
					InitCommand=cmd(playcommand,"Set");
					UpdateCommand=cmd(playcommand,"Set";);
					SetCommand=function(self)
						(cmd(x,-48;y,-141;horizalign,left;zoom,0.85;shadowlength,0))(self)
						if pn == PLAYER_1 then self:settext(migsadhoc);
						elseif pn == PLAYER_2 then self:settext(migsadhoc);
						end;
					end;
				};
				--exscore
				LoadFont("PaneDisplay text")..{
					InitCommand=cmd(x,-48;y,-141-15;settext,"0";horizalign,left;zoom,0.85;shadowlength,0;);
					JudgmentMessageCommand=function(self, params)
						self:settext(MIGS);
					end;
					SetCommand=cmd(playcommand,"On");
				};
			};

		--grade
			for i = 1, 4 do
				local Tiernum = THEME:GetMetric("PlayerStageStats","GradePercentTier0"..i);
				t[#t+1] = Def.ActorFrame{
					InitCommand=function(self)
						if stt == 'StepsType_Dance_Solo' then
							if pn == PLAYER_1 then self:x(GetGraphPosX(pn)+18);
							else self:x(GetGraphPosX(pn)-26);
							end;
						else self:x(GetGraphPosX(pn));
						end;
					end;
					OnCommand=function(self)
						self:visible(true);
						if pn == PLAYER_1 then
							if adgraph ~= "Off" and adgraph ~= "nil" then
								(cmd(diffusealpha,0;addx,-80;sleep,0.2;decelerate,0.4;diffusealpha,1;addx,80;))(self)
							end;
						elseif pn == PLAYER_2 then
							if adgraph ~= "Off" and adgraph ~= "nil" then
								(cmd(diffusealpha,0;addx,80;sleep,0.2;decelerate,0.4;diffusealpha,1;addx,-80;))(self)
							end;
						else
							self:visible(false);
						end;
					end;
					LoadActor("tiergraph_target")..{
						InitCommand=cmd(x,54;y,SCREEN_CENTER_Y-95;horizalign,right;animate,false;);
						OnCommand=function(self)
							local targets = targetgraphheight["Tier0"..i];
							if i == 1 then self:addy((graphheight * (1-Tiernum))-7);
							else self:addy(graphheight * (1-Tiernum));
							end;
							self:setstate(targets);
						end;
					};
				};
			end;

			--graph
			t[#t+1] = Def.ActorFrame{
				InitCommand=function(self)
					self:y(SCREEN_CENTER_Y+122);
					if stt == 'StepsType_Dance_Solo' then
						if pn == PLAYER_1 then self:x(GetGraphPosX(pn)+18);
						else self:x(GetGraphPosX(pn)-26);
						end;
					else self:x(GetGraphPosX(pn));
					end;
				end;
				OnCommand=function(self)
					self:visible(true);
					if pn == PLAYER_1 then
						(cmd(diffusealpha,0;addx,80;sleep,0.2;decelerate,0.4;diffusealpha,1;addx,-80;))(self)
					elseif pn == PLAYER_2 then
						(cmd(diffusealpha,0;addx,-80;sleep,0.2;decelerate,0.4;diffusealpha,1;addx,80;))(self)
					else self:visible(false);
					end;
				end;
				--user
				Def.Quad{
					InitCommand=cmd(x,-38;zoomx,26;zoomy,0;vertalign,bottom;diffuse,color("0,1,1,0.8");diffusebottomedge,color("0,1,1,0.3"););
					JudgmentMessageCommand=function(self)
						(cmd(stoptweening;linear,0.01;zoomy,cscoregraphheight))(self);		
					end;
					SetCommand=cmd(playcommand,"JudgmentMessage");
				};
				--ctarget
				Def.Quad{
					InitCommand=cmd(x,-4;zoomx,28;zoomy,0;vertalign,bottom;diffuse,color("0.7,0.7,0.7,0.8");diffusebottomedge,color("0.3,0.3,0.3,0.3"););
					OnCommand=function(self)
						(cmd(stoptweening;linear,0.01;zoomy,( graphheight * adhoc ) + 1;))(self);
					end;
				};
				--target
				Def.Quad{
					InitCommand=cmd(x,-4;zoomx,26;zoomy,0;vertalign,bottom;diffuse,color("1,0.5,0,0.8");diffusebottomedge,color("1,0.5,0,0.3"););
					JudgmentMessageCommand=function(self)
						(cmd(stoptweening;linear,0.01;zoomy,targetcoregraphheight;))(self);
					end;
					SetCommand=cmd(playcommand,"JudgmentMessage");
				};
			};
		--cst
		end;
	--numpn
	end;

	--[ja] ターゲット・1人プレイ時はグラフと一体、ダブル・2人プレイ時は判定表示と一体
	t[#t+1] = LoadFont("PaneDisplay text")..{
		InitCommand=function(self)
			self:visible(false);
			(cmd(vertalign,bottom;shadowlength,0))(self)
			self:y(SCREEN_BOTTOM-164);
			if numpn == 1 and cst == 'StyleType_OnePlayerTwoSides' then
				self:zoom(0.75);
				self:maxwidth(58);
				self:settext( "0:\n"..migsadhoc );
				if pn == PLAYER_1 then
					self:visible(true);
					(cmd(horizalign,right;x,SCREEN_CENTER_X+308))(self)
				elseif pn == PLAYER_2 then
					self:visible(true);
					(cmd(horizalign,left;x,SCREEN_CENTER_X-308))(self)
				end;
			elseif numpn == 2 then
				if GetScreenAspectRatio() >= 1.6 then
					self:zoom(0.75);
					self:maxwidth(58);
					self:settext( "0:\n"..migsadhoc );
					if pn == PLAYER_1 then
						self:visible(true);
						(cmd(horizalign,left;x,SCREEN_CENTER_X-45))(self)
					elseif pn == PLAYER_2 then
						self:visible(true);
						(cmd(horizalign,right;x,SCREEN_CENTER_X+45))(self)
					end;
				end;
			else
				self:visible(true);
				if stt == 'StepsType_Dance_Solo' then
					if pn == PLAYER_1 then self:x(GetGraphPosX(pn)+54+18);
					else self:x(GetGraphPosX(pn)+54-26);
					end;
				else self:x(GetGraphPosX(pn)+54);
				end;
				(cmd(y,SCREEN_CENTER_Y+122+24;horizalign,right;vertalign,bottom;zoom,0.85))(self)
				self:settext("TARGET:\n0");
			end;
		end;
		OnCommand=cmd(diffusealpha,0;addy,200;sleep,0.2;decelerate,0.4;diffusealpha,1;addy,-200;);
		JudgmentMessageCommand=function(self)
			self:diffuse(color("1,1,1,1"));
			if cst == 'StyleType_OnePlayerTwoSides' or cst == 'StyleType_TwoPlayersTwoSides' then
				self:settext(MIGS..":\n"..( MIGS - cmigsadhoc ));
			else
				self:settext("TARGET:\n"..( MIGS - cmigsadhoc ) );
			end;
			if MIGS - cmigsadhoc > 0 then
				self:diffuse(Colors.Count["Plus"]);
				if cst == 'StyleType_OnePlayerTwoSides' or cst == 'StyleType_TwoPlayersTwoSides' then
					self:settext(MIGS..":\n+"..( MIGS - cmigsadhoc ));
					if numpn == 2 then
						if pn == PLAYER_1 then self:settext(":"..MIGS.."\n+"..( MIGS - cmigsadhoc ));
						end;
					end;
				else
					self:settext("TARGET:\n+"..( MIGS - cmigsadhoc ));
				end;
			elseif MIGS - cmigsadhoc == 0 then self:diffuse(color("1,1,1,1"));
			elseif MIGS - cmigsadhoc < 0 then self:diffuse(Colors.Count["Minus"]);
			else self:diffuse(color("1,1,1,1"));
			end;
		end;
		SetCommand=cmd(playcommand,"JudgmentMessage");
	};

--adgraph
end;

if cst ~= 'StyleType_OnePlayerTwoSides' then
	--judge
	t[#t+1] = LoadActor("judge_back")..{
		InitCommand=function(self)
			self:visible(false);
			if stt == 'StepsType_Dance_Solo' or (IsUsingSoloSingles and numpn == 1) then
				self:y(SCREEN_BOTTOM-118);
				if pn == PLAYER_1 then self:x(SCREEN_LEFT+(SCREEN_WIDTH*0.1));
				else self:x(SCREEN_RIGHT-(SCREEN_WIDTH*0.1));
				end;
			elseif numpn == 2 then
				self:x(SCREEN_CENTER_X);
				self:y(SCREEN_BOTTOM-104);
			else
				self:y(SCREEN_BOTTOM-104);
				if pn == PLAYER_1 then self:x(SCREEN_RIGHT-216);
				else self:x(SCREEN_LEFT+216);
				end;
			end;
			if numpn == 2 then
				if GetScreenAspectRatio() >= 1.6 then
					if ingamestatsp1 == 'On' and ingamestatsp2 == 'On' then
						if pn == PLAYER_1 then self:visible(true);
						else self:visible(false);
						end;
					elseif pn == PLAYER_1 and ingamestatsp1 == 'On' or pn == PLAYER_2 and ingamestatsp2 == 'On' then
						self:visible(true);
					end;
				else self:visible(false);
				end;
			else
				if pn == PLAYER_1 and ingamestatsp1 == 'On' or pn == PLAYER_2 and ingamestatsp2 == 'On' then
					self:visible(true);
				end;
			end;
		end;
		OnCommand=cmd(diffusealpha,0;zoomy,10;addy,-40;sleep,0.2;linear,0.4;diffusealpha,1;zoomy,1;addy,40;);
	};

	t[#t+1] = Def.Sprite{
		InitCommand=function(self)
			self:x(SCREEN_CENTER_X-14);
			self:y(SCREEN_BOTTOM-146);
			self:visible(true);
			if numpn == 2 then
				if GetScreenAspectRatio() >= 1.6 then
					if ingamestatsp1 == 'On' and ingamestatsp2 == 'On' then
						self:visible(false);
					elseif ingamestatsp1 == 'On' and ingamestatsp2 == 'Off' then
						self:Load(THEME:GetPathG("","_StepsDisplayListRow cursor p1/p1_4"));
					elseif ingamestatsp2 == 'On' and ingamestatsp1 == 'Off' then
						self:Load(THEME:GetPathG("","_StepsDisplayListRow cursor p2/p2_4"));
					else self:visible(false);
					end;
				else self:visible(false);
				end;
			else
				self:visible(false);
			--[[
				if pn == PLAYER_1 and ingamestatsp1 == 'On' then
					self:Load(THEME:GetPathG("","_StepsDisplayListRow cursor p1/p1_4"));
				elseif pn == PLAYER_2 and ingamestatsp2 == 'On' then
					self:Load(THEME:GetPathG("","_StepsDisplayListRow cursor p2/p2_4"));
				else self:visible(false);
				end;
			]]
			end;
		end;
		OnCommand=cmd(zoomy,0;sleep,0.4;linear,0.4;zoomy,1;);
	};
--cst
end;

for idx, cat in pairs(statsCategoryValues) do
	local statsCategory = cat.Category;
	local statsColor = cat.Color;
	local statsText = cat.Text;

--[ja] 判定セパレーター・判定
	t[#t+1] = Def.ActorFrame{
		InitCommand=function(self)
			self:vertalign(bottom);
			self:y(SCREEN_BOTTOM-150);
			if cst == 'StyleType_OnePlayerTwoSides' then
				if pn == PLAYER_1 then self:x(SCREEN_CENTER_X+308);
				else self:x(SCREEN_CENTER_X-308);
				end;
			elseif stt == 'StepsType_Dance_Solo' or (IsUsingSoloSingles and numpn == 1) then
				self:y(SCREEN_BOTTOM-164);
				if pn == PLAYER_1 then self:x(SCREEN_LEFT+(SCREEN_WIDTH*0.1));
				else self:x(SCREEN_RIGHT-(SCREEN_WIDTH*0.1));
				end;
			elseif numpn == 2 then self:x(SCREEN_CENTER_X);
			else
				if pn == PLAYER_1 then self:x(SCREEN_RIGHT-216);
				else self:x(SCREEN_LEFT+216);
				end;
			end;
		end;
		OnCommand=cmd(diffusealpha,0;addy,200;sleep,0.2;decelerate,0.4;diffusealpha,1;addy,-200;);

		LoadFont("PaneDisplay text")..{
			InitCommand=function(self)
				self:visible(true);
				self:y(math.abs(idx*12));
				self:diffuse(statsColor);
				(cmd(zoom,0.75;shadowlength,0;diffusealpha,1;))(self)
				if numpn == 2 then
					if GetScreenAspectRatio() >= 1.6 then
						if ingamestatsp1 == 'On' and ingamestatsp2 == 'On' then
							if pn == PLAYER_1 then (cmd(horizalign,center;x,0;settext,":"))(self)
							else self:visible(false);
							end;
						elseif ingamestatsp1 == 'On' or ingamestatsp2 == 'On' then
							if pn == PLAYER_1 and ingamestatsp1 == 'On' then
								if pn == PLAYER_1 then (cmd(horizalign,right;x,-10;settext,statsText..":"))(self)
								else self:visible(false);
								end;
							elseif pn == PLAYER_2 and ingamestatsp2 == 'On' then
								if pn == PLAYER_2 then(cmd(horizalign,right;x,-10;settext,statsText..":"))(self)
								else self:visible(false);
								end;
							end;
						else self:visible(false);
						end;
					end;
				elseif cst == 'StyleType_OnePlayerTwoSides' then self:visible(false);
				elseif pn == PLAYER_1 and ingamestatsp1 == 'On' or pn == PLAYER_2 and ingamestatsp2 == 'On' then
					if pn == PLAYER_1 or pn == PLAYER_2 then (cmd(horizalign,right;x,-10;settext,statsText..":"))(self)
					else self:visible(false);
					end;
				else self:visible(false);
				end;
			end;
		};

		LoadFont("PaneDisplay text")..{
			InitCommand=function(self)
				self:visible(false);
				(cmd(zoom,0.75;shadowlength,0;diffusealpha,1;))(self)
				if numpn == 2 then
					if GetScreenAspectRatio() >= 1.6 then
						if ingamestatsp1 == 'On' and ingamestatsp2 == 'On' then
							self:visible(true);
							self:maxwidth(48);
							if pn == PLAYER_1 then
								(cmd(horizalign,left;x,-45))(self)
							elseif pn == PLAYER_2 then
								(cmd(horizalign,right;x,45))(self)
							end;
						elseif ingamestatsp1 == 'On' or ingamestatsp2 == 'On' then
							(cmd(horizalign,left;maxwidth,68;x,-6;))(self)
							if pn == PLAYER_1 and ingamestatsp1 == 'On' then
								self:visible(true);
							elseif pn == PLAYER_2 and ingamestatsp2 == 'On' then
								self:visible(true);
							end;
						else self:visible(false);
						end;
					end;
				elseif cst == 'StyleType_OnePlayerTwoSides' then
					self:maxwidth(48);
					self:diffuse(statsColor);
					if pn == PLAYER_1 and ingamestatsp1 == 'On' then
						(cmd(visible,true;horizalign,right))(self)
					elseif pn == PLAYER_2 and ingamestatsp2 == 'On' then
						(cmd(visible,true;horizalign,left))(self)
					else self:visible(false);
					end;
				elseif pn == PLAYER_1 and ingamestatsp1 == 'On' or pn == PLAYER_2 and ingamestatsp2 == 'On' then
					(cmd(visible,true;horizalign,left;maxwidth,68;x,-6;))(self)
				else self:visible(false);
				end;
				self:y(math.abs(idx*12));
				self:settext( 0 );
			end;
			JudgmentMessageCommand=function(self)
				local value = 0;
				if statsCategory == 'TapNoteScore_W1' then value = stats["TapNoteScore_W1"];
				elseif statsCategory == 'TapNoteScore_W2' then value = stats["TapNoteScore_W2"];
				elseif statsCategory == 'TapNoteScore_W3' then value = stats["TapNoteScore_W3"];
				elseif statsCategory == 'TapNoteScore_W4' then value = stats["TapNoteScore_W4"];
				elseif statsCategory == 'TapNoteScore_W5' then value = stats["TapNoteScore_W5"];
				elseif statsCategory == 'TapNoteScore_Miss' then value = stats["TapNoteScore_Miss"];
				elseif statsCategory == 'HoldNoteScore_Held' then value = stats["HoldNoteScore_Held"];
				end;
				self:settext( value );
			end;
			SetCommand=cmd(playcommand,"JudgmentMessage");
		};
	};
end;

t.CurrentSongChangedMessageCommand=function(self)
	self:playcommand("Set");
end;

return t;