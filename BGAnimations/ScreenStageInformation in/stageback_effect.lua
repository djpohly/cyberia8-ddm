local t = Def.ActorFrame{
	Def.Quad{
		OnCommand=cmd(diffuse,color("0,0,0,1");FullScreen;diffusealpha,1;linear,0.5;diffusealpha,0;sleep,2.4;linear,0.5;diffusealpha,1;);
	};

	Def.Quad{
		OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y-124;fadetop,0.2;fadebottom,0.2;diffuse,color("1,1,0.3,0.7");diffusealpha,0;
					zoomtowidth,SCREEN_WIDTH;zoomtoheight,32;sleep,1.45;decelerate,0.4;diffusealpha,1;linear,1.6;zoomtoheight,6;diffusealpha,0;addy,100;);
	};


	Def.Quad{
		OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y-100;fadetop,0.2;fadebottom,0.2;diffuse,color("0.2,0.7,0.6,1");diffusealpha,0;
					zoomtowidth,SCREEN_WIDTH;zoomtoheight,0;sleep,1.55;accelerate,0.3;diffusealpha,1;zoomtoheight,36;linear,1.2;zoomtoheight,2;diffusealpha,0;addy,120;);
	};


	Def.Quad{
		OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+100;fadetop,0.2;fadebottom,0.2;diffuse,color("0.3,0,1,1");diffusealpha,0;
					zoomtowidth,SCREEN_WIDTH;zoomtoheight,0;sleep,1.65;decelerate,0.2;diffusealpha,1;zoomtoheight,4;linear,2.4;zoomtoheight,20;diffusealpha,0;addy,-40;);
	};

	Def.Quad{
		OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+152;fadetop,0.2;fadebottom,0.2;diffuse,color("1,1,0.3,0.7");diffusealpha,0;
					zoomtowidth,SCREEN_WIDTH;zoomtoheight,0;sleep,1.75;accelerate,0.1;diffusealpha,1;zoomtoheight,32;linear,2;zoomtoheight,3;diffusealpha,0;addy,-50;);
	};

	Def.Quad{
		OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+84;fadetop,0.2;fadebottom,0.2;diffuse,color("0.2,1,1,1");diffusealpha,0;
					zoomtowidth,SCREEN_WIDTH;zoomtoheight,0;sleep,1.55;decelerate,0.3;diffusealpha,1;zoomtoheight,15;linear,1.6;zoomtoheight,2;diffusealpha,0;addy,-120;);
	};



	Def.Quad{
		OnCommand=function(self)
			if getenv("exflag") == "csc" or getenv("omsflag") == 1 then
				self:diffuse(color("0,1,1,0.5"));
			elseif GAMESTATE:GetCurrentStage() == 'Stage_Extra1' then
				self:diffuse(color("0.75,0,0,0.5"));
			elseif GAMESTATE:GetCurrentStage() == 'Stage_Extra2' then
				self:diffuse(color("1,1,1,0.5"));
			else self:diffuse(color("0.2,1,1,0.5"));
			end;
			(cmd(vertalign,top;x,SCREEN_CENTER_X;y,SCREEN_TOP+60;
			zoomtowidth,SCREEN_WIDTH;zoomtoheight,18;addx,SCREEN_WIDTH;sleep,1.8;decelerate,0.4;addx,-SCREEN_WIDTH;fadetop,0.2;fadebottom,0.2;
			linear,0.4;y,SCREEN_TOP;diffusealpha,0.6;zoomtoheight,SCREEN_HEIGHT/2;fadetop,0;fadebottom,0;sleep,0.8;linear,0.25;diffusealpha,0))(self)
		end;
	};

	Def.Quad{
		OnCommand=function(self)
			if getenv("exflag") == "csc" or getenv("omsflag") == 1 then
				self:diffuse(color("0,1,1,0.5"));
			elseif GAMESTATE:GetCurrentStage() == 'Stage_Extra1' then
				self:diffuse(color("0.75,0,0,0.5"));
			elseif GAMESTATE:GetCurrentStage() == 'Stage_Extra2' then
				self:diffuse(color("1,1,1,0.5"));
			else self:diffuse(color("0.2,1,1,0.5"));
			end;
			(cmd(vertalign,bottom;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-60;
			zoomtowidth,SCREEN_WIDTH;zoomtoheight,18;addx,-SCREEN_WIDTH;sleep,1.8;decelerate,0.4;addx,SCREEN_WIDTH;fadetop,0.2;fadebottom,0.2;
			linear,0.4;y,SCREEN_BOTTOM;diffusealpha,0.6;zoomtoheight,SCREEN_HEIGHT/2;fadetop,0;fadebottom,0;sleep,0.8;linear,0.25;diffusealpha,0))(self)
		end;
	};

};

return t;
