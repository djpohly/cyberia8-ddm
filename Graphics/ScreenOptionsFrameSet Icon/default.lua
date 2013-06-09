--[[ScreenOptionsFrameSet Icon]]
local t = Def.ActorFrame{};

t[#t+1] = Def.ActorFrame{
	LoadActor("frame")..{
		InitCommand=cmd(x,SCREEN_LEFT+(SCREEN_WIDTH*0.4);y,SCREEN_TOP+(SCREEN_HEIGHT*0.13);zoom,0.8;);
	};
};

return t;