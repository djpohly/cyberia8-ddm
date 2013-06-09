local t = Def.ActorFrame{};
--[ja] ステージ計算システム
local cStage = "";
local curStageNum = 0;
local songStages = 0;
local maxStages = PREFSMAN:GetPreference("SongsPerPlay");
local pm = GAMESTATE:GetPlayMode();

t[#t+1] = Def.Sprite {
	InitCommand=cmd(horizalign,right;shadowlength,2;);
	OnCommand=cmd(playcommand,"CurrentSongChangedMessage";);
	CurrentSongChangedMessageCommand=function(self)
		if not GAMESTATE:IsCourseMode() then
			if not GAMESTATE:IsEventMode() then
				cStage = GAMESTATE:GetCurrentStage();
				if cStage == 'Stage_1st' then
					curStageNum = 1;
				else
					curStageNum = getenv("cStageTotal");
				end;
				--[ja] リザルト画面送り用
				setenv("cStageTotal",curStageNum);
				
				--[ja] 表示用
				local ssSong = GAMESTATE:GetCurrentSong();
				if ssSong then
					if ssSong:IsLong() then songStages = 1;
					elseif ssSong:IsMarathon() then songStages = 2;
					else songStages = 0;
					end
					curStageNum = curStageNum + songStages;
				else curStageNum = curStageNum;
				end;

				if GAMESTATE:IsExtraStage() then cStage = 'Stage_Extra1'
				elseif GAMESTATE:IsExtraStage2() then cStage = 'Stage_Extra2'
				elseif curStageNum >= maxStages then cStage = 'Stage_Final'
				else
					local stageStr = FormatNumberAndSuffix( getenv("cStageTotal") );
					cStage = 'Stage_'..stageStr;
				end;
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
		setenv("cStage",cStage);
	end;
};

return t;
