local t = Def.ActorFrame{
	Def.Quad{
		InitCommand=cmd(FullScreen;diffuse,color("0,0.7,1,0.3");diffuserightedge,color("0,0.7,1,0.75"););
	};
	
	LoadActor("block3")..{
		InitCommand=cmd(CenterY;x,SCREEN_LEFT;zoomto,500,SCREEN_HEIGHT;customtexturerect,0,0,1,SCREEN_HEIGHT/self:GetHeight();ztest,true);
		OnCommand=cmd(texcoordvelocity,0,0.04;diffuse,color("1,1,1,0.4");diffuserightedge,color("1,1,1,0"););
	};
	
	Def.ActorFrame{
		InitCommand=cmd(x,SCREEN_LEFT+160;y,SCREEN_BOTTOM-100;);
		OnCommand=cmd(zoom,0.4;rotationx,-120;rotationz,-90;queuecommand,"Repeat";);
		RepeatCommand=cmd(spin;effectmagnitude,8,1,-10;);

		LoadActor( THEME:GetPathB("_shared","models/_08_1") )..{
			InitCommand=cmd(blend,'BlendMode_Add';x,-100;diffuse,color("0.6,0.6,0.6,0.1"););
		};
		
		LoadActor( THEME:GetPathB("_shared","models/_08_1") )..{
			InitCommand=cmd(blend,'BlendMode_Add';x,100;diffuse,color("0.6,0.6,0.6,0.2"););
		};
	};
	
	LoadActor( THEME:GetPathB("","_logo/full") )..{
		InitCommand=cmd(horizalign,right;shadowlength,2;x,SCREEN_RIGHT-50;y,SCREEN_BOTTOM-50;);
		OnCommand=cmd(zoomx,0.2*10;zoomy,0;diffusealpha,0.6;sleep,0.4;linear,0.1;zoomtoheight,2;decelerate,0.4;zoomx,0.2;decelerate,0.2;zoomy,0.2;);
	};
	
	LoadActor( "danger" )..{
		InitCommand=cmd(horizalign,right;x,SCREEN_RIGHT;y,SCREEN_CENTER_Y;);
		OnCommand=cmd(diffuse,color("1,0,0,0");sleep,39;linear,0.5;diffuse,color("1,0,0,0.5");linear,0.5;diffuse,color("1,1,1,0.75");linear,0.5;diffuse,color("1,0,0,0.5");
					linear,0.5;diffuse,color("1,1,1,0.75");linear,0.5;diffuse,color("1,0,0,0.5");linear,0.5;diffuse,color("1,1,1,0.75");linear,0.5;diffuse,color("1,0,0,0.5");
					linear,0.5;diffuse,color("1,1,1,0.75");linear,0.5;diffuse,color("1,0,0,0.5");linear,0.5;diffuse,color("1,1,1,0.75");linear,0.5;diffuse,color("1,0,0,0.5"););
	};
};

return t;