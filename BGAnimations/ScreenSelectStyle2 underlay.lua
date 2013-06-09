
local t = Def.ActorFrame{
-- part1
	LoadActor(THEME:GetPathG("ScreenSelectStyle","Icon/Versus"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X+69.5;y,SCREEN_CENTER_Y+108+10);
		OnCommand=cmd(diffuse,color("0.2,0.2,0.2,1");shadowlength,3;addx,SCREEN_WIDTH;sleep,0.125;decelerate,0.3;addx,-SCREEN_WIDTH;);
	};

};

return t;