local curGameName = GAMESTATE:GetCurrentGame():GetName();

local t = Def.ActorFrame{
	LoadFont("Common Normal") .. {
		InitCommand=cmd(horizalign,right;diffuse,color("0,0,0,1");strokecolor,color("0,1,1,1");zoom,0.5;shadowlength,1;maxwidth,SCREEN_WIDTH;);
		BeginCommand=function(self)
			self:settextf( Screen.String("CurrentGametype"), curGameName );
		end;
	};
};
return t;