local filename = "down_n";
local gcolor = "1,0.75,0,0.8";

if getenv("exflag") == "csc" then
	filename = "down_c";
	gcolor = "0,01,0.75,0.8";
end;

local t = Def.ActorFrame{};

t[#t+1] = LoadActor(""..filename.."")..{
	InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_TOP;vertalign,bottom;rotationx,180;rotationy,180;cropleft,1;cropright,0;);
	OnCommand=cmd(glow,color("0,1,1,0.8");sleep,0.2;decelerate,0.7;cropleft,0;diffusealpha,1;glow,color(gcolor);accelerate,0.3;glow,color("0,0,0,0");queuecommand,"Repeat";);
	RepeatCommand=cmd(sleep,10;diffusealpha,1;glow,color("0,1,1,0");linear,0.05;glow,color("0,1,1,0.59");decelerate,0.6;glow,color("0,1,1,0");queuecommand,"Repeat";);
	OffCommand=cmd(finishtweening;);
};

t[#t+1] = LoadActor(""..filename.."")..{
	InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_BOTTOM;vertalign,bottom;cropleft,1;cropright,0;);
	OnCommand=cmd(glow,color("0,1,1,0.8");sleep,0.2;decelerate,0.7;cropleft,0;diffusealpha,1;glow,color(gcolor);accelerate,0.3;glow,color("0,0,0,0");queuecommand,"Repeat";);
	RepeatCommand=cmd(sleep,10;diffusealpha,1;glow,color("0,1,1,0");linear,0.05;glow,color("0,1,1,0.9");decelerate,0.6;glow,color("0,1,1,0");queuecommand,"Repeat";);
	OffCommand=cmd(finishtweening;);
};

return t;
