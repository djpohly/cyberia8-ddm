
--[[ScreenTextEntry]]
local t = Def.ActorFrame {
	InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);

	Def.Quad{
		BeginCommand=function(self)
			self:visible(true);
			self:zoomtowidth(SCREEN_WIDTH);
			self:zoomtoheight(SCREEN_HEIGHT);
			self:diffuse(color("0,0,0,0"));
			self:linear(0.1);
			self:diffuse(color("0.025,0.1,0.2,0.75"));
		end;
	};
}

return t;

