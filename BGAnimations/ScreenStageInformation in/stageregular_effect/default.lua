
local t = Def.ActorFrame {};

--stage label
t[#t+1] = Def.ActorFrame{
	Def.Sprite {
		InitCommand=function(self)
			if getenv("omsflag") == 1 and GAMESTATE:IsExtraStage2() then
				self:Load(THEME:GetPathB("ScreenStageInformation","in/stageregular_effect/_label Stage_Extra2"));
			else
				self:Load(THEME:GetPathB("ScreenStageInformation","in/stageregular_effect/_label "..getenv("cStage")));
			end;
			self:horizalign(right);
			self:shadowlength(2);
			self:x(SCREEN_RIGHT-13);
			self:y(SCREEN_CENTER_Y-100);
		end;
		OnCommand=cmd(addx,340;diffusealpha,0;sleep,0.5;decelerate,0.2;addx,-340;diffusealpha,0.5;linear,0.6;diffusealpha,1;sleep,0.7;linear,0.075;addx,(-SCREEN_CENTER_X+164)-22;diffusealpha,0;);
	};

	Def.Sprite {
		InitCommand=function(self)
			if getenv("omsflag") == 1 and GAMESTATE:IsExtraStage2() then
				self:Load(THEME:GetPathB("ScreenStageInformation","in/stageregular_effect/_label Stage_Extra2"));
			else
				self:Load(THEME:GetPathB("ScreenStageInformation","in/stageregular_effect/_label "..getenv("cStage")));
			end;
			self:x(SCREEN_RIGHT-100);
			self:y(SCREEN_CENTER_Y-90);
			self:diffusealpha(0.4);
		end;
		OnCommand=cmd(addx,SCREEN_WIDTH;sleep,0.2;accelerate,0.5;addx,-SCREEN_WIDTH;zoom,2;linear,1.75;addx,-SCREEN_WIDTH*0.035;diffusealpha,0;);
	};

	Def.Sprite {
		InitCommand=function(self)
			if getenv("omsflag") == 1 and GAMESTATE:IsExtraStage2() then
				self:Load(THEME:GetPathB("ScreenStageInformation","in/stageregular_effect/_label Stage_Extra2"));
			else
				self:Load(THEME:GetPathB("ScreenStageInformation","in/stageregular_effect/_label "..getenv("cStage")));
			end;
			self:horizalign(left);
			self:shadowlength(2);
			self:x(SCREEN_CENTER_X-200);
			self:y(SCREEN_CENTER_Y-100);
		end;		
		OnCommand=cmd(diffusealpha,0;sleep,2;linear,0.075;diffusealpha,1;y,SCREEN_CENTER_Y+100-10;sleep,0.7+0.5;zoomtoheight,4;linear,0.1;zoomtowidth,SCREEN_WIDTH*2;zoomtoheight,0;diffusealpha,0;);
	};
};

return t;