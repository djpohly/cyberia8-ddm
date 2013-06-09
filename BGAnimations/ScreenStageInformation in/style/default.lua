local t = {};

local style = GAMESTATE:GetCurrentStyle();
if style then
	local st = style:GetName();
	
	return Def.ActorFrame {
		LoadActor("_style "..st)..{
			InitCommand=cmd(x,SCREEN_RIGHT-13;y,SCREEN_TOP+108;);
			OnCommand=cmd(horizalign,right;shadowlength,2;addx,5;diffusealpha,0;sleep,0.6;decelerate,0.5;addx,-10;diffusealpha,1;sleep,0.75;linear,0.1;
						y,SCREEN_CENTER_Y+132;linear,0.1;x,SCREEN_CENTER_X-34;diffusealpha,0;);
		};
		LoadActor("_style "..st)..{
			InitCommand=cmd(x,SCREEN_CENTER_X-197;y,SCREEN_CENTER_Y+148-10;);
			OnCommand=cmd(horizalign,left;shadowlength,2;diffusealpha,0;addx,400;sleep,2;linear,0.1;addx,-400;diffusealpha,1;sleep,0.7+0.5;linear,0.1;zoomy,0;);
		};
	};
else
	return Def.Actor {};
end

