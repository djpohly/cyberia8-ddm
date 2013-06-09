local t = Def.ActorFrame{};

t[#t+1] = Def.ActorFrame{
	Def.Quad {
		InitCommand=cmd(FullScreen;diffuse,color("1,1,1,1");diffusebottomedge,color("0,0,0,1"););
	};
	Def.Quad {
		InitCommand=function(self)
			self:FullScreen();
			if getenv("omsflag") == 1 then
				self:diffuse(color("0,0.5,0.5,1"));
				self:diffuserightedge(color("0,0.3,0.1,0.45"));
			else
				self:diffuse(color("1,1,1,1"));
				self:diffuserightedge(color("0,0,0,1"));	
			end;
		end;
	};
};

t[#t+1] = LoadActor( THEME:GetPathB("","eva_back") )..{
};

t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(fov,100);

	Def.ActorFrame{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;rotationx,-120;rotationz,-90;);
		OnCommand=cmd(addx,300;zoom,1.5;decelerate,1;addx,-300;zoom,0.8;rotationx,0;rotationz,90;queuecommand,"Repeat";);
		RepeatCommand=cmd(spin;effectmagnitude,16,2,-20;);

		LoadActor( THEME:GetPathB("_shared","models/_08_1") )..{
			InitCommand=cmd(blend,'BlendMode_Add';x,-100;diffuse,color("0.6,0.6,0.6,0.1"););
		};
		
		LoadActor( THEME:GetPathB("_shared","models/_08_1") )..{
			InitCommand=cmd(blend,'BlendMode_Add';x,100;diffuse,color("0.6,0.6,0.6,0.2"););
		};
	};
};

t[#t+1] = LoadActor( THEME:GetPathB("ScreenSelectMusicExtra2","background/_particleLoader") )..{
	InitCommand=cmd(fov,100;x,SCREEN_LEFT+50;y,-SCREEN_CENTER_Y;rotationz,40;rotationy,30;);
};

return t;