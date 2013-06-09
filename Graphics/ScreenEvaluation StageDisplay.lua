--[ja] ステージ計算システム

local ScreenName = Var "LoadingScreen";
local stageDisplayTypes = {
	ScreenSelectCourse = nil,
	ScreenSelectCourseNonstop = nil,
	ScreenSelectCourseOni = nil,
	ScreenSelectCourseEndless = nil,
	ScreenGameplay = nil,
	ScreenGameplayRave = nil,
	ScreenGameplayCourse = nil,
	ScreenGameplayCourseNonstop = nil,
	ScreenGameplayCourseOni = nil,
	ScreenGameplayCourseEndless = nil,
	ScreenGameplayExtra = nil,
	ScreenGameplayExtra2 = nil,
	ScreenDemonstration = nil,
	ScreenJukebox = nil,
	ScreenEvaluation = "selmusic",
	ScreenEvaluationStage = "selmusic",
	ScreenEvaluationRave = "selmusic",
	ScreenEvaluationExtra = nil,
	ScreenEvaluationExtra2 = nil,
	ScreenEvaluationNonstop = "selmusic",
	ScreenEvaluationOni = "selmusic",
	ScreenEvaluationEndless = "selmusic",
};
local stageDisplayType = stageDisplayTypes[ScreenName];
if stageDisplayType == nil then return Def.Actor{}; end;

local t = Def.ActorFrame {};

local cStage;
local curStageNum = 0;
local curStageCount = 0;
local songStages = 0;
local maxStages = PREFSMAN:GetPreference("SongsPerPlay");
local pm = GAMESTATE:GetPlayMode();

t[#t+1] = Def.ActorFrame {
	Def.Sprite {
		InitCommand=function(self)
			if not GAMESTATE:IsCourseMode() then
				if not GAMESTATE:IsEventMode() then
					cStage = GAMESTATE:GetCurrentStage();
					curStageNum = getenv("cStageTotal");
					local ssStats = STATSMAN:GetCurStageStats();
					--[ja] 選曲画面送り用
					if curStageNum >= maxStages then cStage = 'Stage_Final'
				--	elseif IsAnExtraStage() then
				--		if GAMESTATE:IsExtraStage() then cStage = 'Stage_Extra1'
				--		elseif GAMESTATE:IsExtraStage2() then cStage = 'Stage_Extra2'
				--		end;
					else
						local sssong = ssStats:GetPlayedSongs()[1];
						if ssStats then
							local sssong = ssStats:GetPlayedSongs()[1];
							if sssong then
								if sssong:IsLong() then songStages = 1;
								elseif sssong:IsMarathon() then songStages = 2;
								else songStages = 0;
								end
								curStageNum = getenv("cStageTotal") + songStages;
							else curStageNum = getenv("cStageTotal");
							end;
						end;

						curStageCount = getenv("cStageTotal");
						if maxStages <= curStageNum then
							cStage = 'Stage_Final';
						else
							local stageStr = FormatNumberAndSuffix( curStageCount );
							cStage = 'Stage_'..stageStr;
						end;
					end;
					setenv("cStageTotal",(curStageNum + 1));

				else cStage = 'Stage_Event';
				end;
			elseif GAMESTATE:IsCourseMode() then
				if pm == 'PlayMode_Nonstop' then cStage = 'Stage_Nonstop';
				elseif pm == 'PlayMode_Oni' then cStage = 'Stage_Oni';
				elseif pm == 'PlayMode_Endless' then cStage = 'Stage_Endless';
				end;
			else cStage = 'Stage_Next';
			end;
			self:Load( THEME:GetPathG("","_stages/_selmusic "..cStage) );
		end;
		OnCommand=THEME:GetMetric(Var "LoadingScreen","StageDisplayOnCommand");
	};
};

return t;