local pn = ...
assert(pn,"Must pass in a player, dingus");

local pm = GAMESTATE:GetPlayMode();

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
	Name="EvaluationFrame"..pn;
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

t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(x,GetGraphPosX(pn)-26;y,SCREEN_CENTER_Y);

	LoadActor("_graph_back")..{
		InitCommand=cmd(x,-26+10;y,-82+12);
		OnCommand=cmd(diffusealpha,0;addx,-50;addy,-50;decelerate,0.3;diffusealpha,1;addx,50;addy,50;);
	};

	LoadActor("_graph_top")..{
		InitCommand=cmd(x,10;y,-90+12);
		OnCommand=cmd(cropright,1;sleep,0.3;linear,0.3;cropright,0;);
	};

	Def.Sprite{
		InitCommand=function(self)
			if GAMESTATE:IsCourseMode() then
				self:Load(THEME:GetPathB("ScreenEvaluation","underlay/cleared_stage_frame"));
			else self:Load(THEME:GetPathB("ScreenEvaluation","underlay/grade_frame"));
			end;
			(cmd(y,-24+16+18))(self)
		end;
		OnCommand=cmd(diffusealpha,0;zoom,1.5;addx,-20;sleep,0.1;accelerate,0.4;diffusealpha,1;zoom,1;addx,20;);
	};

	LoadActor("exscore_frame")..{
		InitCommand=cmd(y,6+16+18);
		OnCommand=cmd(diffusealpha,0;zoom,1.5;addx,20;sleep,0.15;accelerate,0.4;diffusealpha,1;zoom,1;addx,-20;);
	};

	LoadActor("target_frame")..{
		InitCommand=cmd(y,30+16+18);
		OnCommand=cmd(diffusealpha,0;zoom,1.5;addx,-20;sleep,0.2;accelerate,0.4;diffusealpha,1;zoom,1;addx,20;);
	};
	
	Def.Sprite{
		InitCommand=cmd(x,-70;y,-22;);
		OnCommand=function(self)
			if pn == PLAYER_1 then self:Load(THEME:GetPathB("ScreenEvaluation","underlay/_player1"));
			else self:Load(THEME:GetPathB("ScreenEvaluation","underlay/_player2"));
			end;
			(cmd(diffusealpha,0;zoom,1.5;sleep,0.075;accelerate,0.4;diffusealpha,1;zoom,1;))(self)
		end;
	};
};

t[#t+1] = Def.Sprite{
	InitCommand=function(self)
		if pm == 'PlayMode_Oni' then
			self:Load(THEME:GetPathB("ScreenEvaluation","underlay/time_frame"));
		else self:Load(THEME:GetPathB("ScreenEvaluation","underlay/score_frame"));
		end;
		(cmd(x,GetGraphPosX(pn)-26;y,SCREEN_CENTER_Y+188))(self)
	end;
	OnCommand=cmd(diffusealpha,0;zoom,1.5;addx,-20;sleep,0.1;accelerate,0.4;diffusealpha,1;zoom,1;addx,20;);
};

return t;