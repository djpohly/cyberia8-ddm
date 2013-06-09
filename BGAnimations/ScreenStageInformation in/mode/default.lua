
local t = Def.ActorFrame{};

local function pload()
	local pm = GAMESTATE:GetPlayMode();
	local picload = "in/mode/mode_regular";
	if pm == 'PlayMode_Regular' then picload = "in/mode/mode_regular";
	elseif pm == 'PlayMode_Rave' then picload = "in/mode/mode_battle";
	elseif GAMESTATE:IsCourseMode() then picload = "in/mode/mode_course";
	else picload = "in/mode/mode_regular";
	end;
	return picload
end;

local function xpos()
	local pm = GAMESTATE:GetPlayMode();
	if pm == 'PlayMode_Regular' then return -SCREEN_CENTER_X-38;
	elseif pm == 'PlayMode_Rave' then return -SCREEN_CENTER_X-22.5;
	elseif GAMESTATE:IsCourseMode() then return -SCREEN_CENTER_X-20;
	else return -SCREEN_CENTER_X-38;
	end;
end;

t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(x,SCREEN_RIGHT-13;y,SCREEN_TOP+94;);

	Def.Sprite{
		InitCommand=function(self)
			self:Load(THEME:GetPathB("ScreenStageInformation",pload()));
		end;
		OnCommand=cmd(horizalign,right;shadowlength,2;addx,5;diffusealpha,0;sleep,0.75;decelerate,0.5;addx,-10;diffusealpha,1;
					sleep,0.7;linear,0.1;y,SCREEN_CENTER_Y+40-10;linear,0.1;x,xpos();sleep,0.8+0.5;linear,0.1;zoomy,0;);
	};
};

return t;