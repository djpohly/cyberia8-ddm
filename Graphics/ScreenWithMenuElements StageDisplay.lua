local t = Def.ActorFrame {};

local coursemode = GAMESTATE:IsCourseMode();
local ccourse = GAMESTATE:GetCurrentCourse();
local pm = GAMESTATE:GetPlayMode();
local stageindex = 0;

if coursemode then
	t[#t+1] = LoadFont("PaneDisplay text") .. {
		InitCommand=cmd(playcommand,"Set");
		SetCommand=function(self)
			if ccourse then
				if pm == 'PlayMode_Endless' then self:settext( stageindex );
				else self:settext( stageindex .. " / " .. ccourse:GetEstimatedNumStages() );
				end;
				setenv("coursestindex",stageindex);
			end;
			self:diffuse(color("1,1,0,1"));
		end;
		OnCommand=THEME:GetMetric(Var "LoadingScreen","StageDisplayOnCommand");
		UpdateCommand=cmd(playcommand,"Set";);
		CurrentSongChangedMessageCommand=function(self)
			stageindex = stageindex + 1;
			self:playcommand("Set");
		end;
	};
elseif IsNetConnected() then
	t[#t+1] = LoadActor(THEME:GetPathG("","_stages/_selmusic Stage_Event")) .. {
		OnCommand=THEME:GetMetric(Var "LoadingScreen","StageDisplayOnCommand");
	};
else
	t[#t+1] = Def.Sprite {
		InitCommand=function(self)
			if getenv("omsflag") == 1 and GAMESTATE:IsExtraStage2() then
				self:Load( THEME:GetPathG("","_stages/_selmusic Stage_Extra2" ) );
			else
				self:Load( THEME:GetPathG("","_stages/_selmusic "..getenv("cStage")) );
			end;
		end;
		OnCommand=THEME:GetMetric(Var "LoadingScreen","StageDisplayOnCommand");
	};
end;

return t;