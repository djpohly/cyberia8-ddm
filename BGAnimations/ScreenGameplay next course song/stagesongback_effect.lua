local t = Def.ActorFrame{};

local coursemode = GAMESTATE:IsCourseMode();

t[#t+1] = Def.ActorFrame{
	StartCommand=cmd(fov,100;blend,'BlendMode_Add';);
	FinishCommand=cmd(finishtweening;diffusealpha,0;);

	Def.Quad {
		StartCommand=cmd(FullScreen;diffuse,color("0,0,0,1");diffusealpha,0;linear,1;diffusealpha,1;);
		FinishCommand=cmd(finishtweening;diffusealpha,1;linear,0.1;diffusealpha,0;);
	};
	
	Def.Quad {
		StartCommand=function(self)
			local pm = GAMESTATE:GetPlayMode();
			self:FullScreen();
			self:diffuse(color("0,0.7,1,1"));
			if pm == "PlayMode_Nonstop" then
				self:diffuserightedge(color("0.6,0.6,0,0.35"));
			elseif pm == "PlayMode_Oni" then
				self:diffuserightedge(color("0.4,0,0.6,0.35"));
			elseif pm == "PlayMode_Endless" then
				self:diffuserightedge(color("0.6,0,0,0.35"));
			elseif GAMESTATE:GetCurrentStage() == 'Stage_Extra1' then
				self:diffuse(color("0.5,0,0,1"));
				self:diffuserightedge(color("0.3,0,0.1,0.45"));
			else
				self:diffuserightedge(color("0,0.7,1,0.35"));
			end;
		end;
		FinishCommand=cmd(finishtweening;diffusealpha,1;linear,0.1;diffusealpha,0;);
	};

	--_square
	Def.ActorFrame{
		StartCommand=cmd(x,SCREEN_CENTER_X+100;y,SCREEN_CENTER_Y+100;rotationz,20;
					zoom,1.5;decelerate,0.5;zoom,1;rotationx,200;rotationy,130;rotationz,200;sleep,2.6;accelerate,0.3;zoom,5;);
		FinishCommand=cmd(finishtweening;diffusealpha,0;);
	
		LoadActor( THEME:GetPathB("","_square") )..{
			StartCommand=cmd(y,-200;diffuse,color("1,1,1,0.5"););
			FinishCommand=cmd(finishtweening;diffusealpha,0;);
		};
		
		LoadActor( THEME:GetPathB("","_square") )..{
			StartCommand=cmd(y,240;diffuse,color("1,1,1,0.5");diffusebottomedge,color("0,0,0,0"););
			FinishCommand=cmd(finishtweening;diffusealpha,0;);
		};

		LoadActor( THEME:GetPathB("","_focus_gra/no_repeat") )..{
			StartCommand=cmd(y,-40;);
			FinishCommand=cmd(finishtweening;diffusealpha,0;);
		};
	};

	Def.ActorFrame{
		StartCommand=cmd(x,SCREEN_CENTER_X-130;y,SCREEN_CENTER_Y+50;rotationx,-120;rotationz,-90;
					addx,300;zoom,0.25;decelerate,1;addx,-300;zoom,1;rotationx,0;rotationz,90;sleep,2.1;accelerate,0.4;zoom,5;);
		FinishCommand=cmd(finishtweening;diffusealpha,0;);
		Def.ActorFrame{
			StartCommand=cmd(spin;effectmagnitude,16,2,-20;);
			FinishCommand=cmd(finishtweening;diffusealpha,1;linear,0.1;diffusealpha,0;);

			LoadActor( THEME:GetPathB("_shared","models/_08_1") )..{
				StartCommand=cmd(blend,'BlendMode_Add';x,-100;diffuse,color("0.6,0.6,0.6,0.05"););
				FinishCommand=cmd(finishtweening;diffusealpha,0;);
			};
		
			LoadActor( THEME:GetPathB("_shared","models/_08_1") )..{
				StartCommand=cmd(blend,'BlendMode_Add';x,100;diffuse,color("0.6,0.6,0.6,0.1"););
				FinishCommand=cmd(finishtweening;diffusealpha,0;);
			};
		};
	};

	-- banner title
	Def.ActorFrame{
		StartCommand=function(self)
			(cmd(Center;visible,false))(self)
			if backpath then self:visible(true);
			end;
		end;
		FinishCommand=cmd(finishtweening;diffusealpha,0;);

		Def.Banner{
			StartCommand=function(self)
				local songorcourse = SCREENMAN:GetTopScreen():GetNextCourseSong();
				local backpath = songorcourse:GetBackgroundPath();
				self:Load( backpath );
				(cmd(rotationx,50;rotationz,-30;scaletoclipped,SCREEN_WIDTH,SCREEN_HEIGHT;zoomtowidth,SCREEN_WIDTH*8;zoomtowidth,SCREEN_HEIGHT*8;
				diffusealpha,0;sleep,0.2;decelerate,0.6;rotationx,0;rotationz,0;diffusealpha,0.55;zoomtowidth,SCREEN_WIDTH*1.075;zoomtoheight,SCREEN_HEIGHT*1.075;
				linear,2.1;zoomtowidth,SCREEN_WIDTH;zoomtoheight,SCREEN_HEIGHT;
				accelerate,0.15;rotationx,50;rotationz,-30;zoomtowidth,SCREEN_WIDTH*1.2;zoomtoheight,SCREEN_HEIGHT*1.2;diffusealpha,0;))(self)
			end;
			FinishCommand=cmd(finishtweening;diffusealpha,0;);
		};
	};
};

return t;
