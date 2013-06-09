local t = Def.ActorFrame{};

local coursemode = GAMESTATE:IsCourseMode();
local songorcourse;
if coursemode then
	songorcourse = GAMESTATE:GetCurrentCourse();
else
	songorcourse = GAMESTATE:GetCurrentSong();
end;
local backpath = songorcourse:GetBackgroundPath();

t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(fov,100;blend,'BlendMode_Add';);

	Def.Quad {
		InitCommand=function(self)
			local pm = GAMESTATE:GetPlayMode();
			self:FullScreen();
			self:diffuse(color("0,0.7,1,1"));
			if getenv("exflag") == "csc" then
				self:diffuse(color("0,0.5,0.5,1"));
				self:diffuserightedge(color("0,0.3,0.1,0.45"));
			elseif pm == "PlayMode_Nonstop" then
				self:diffuserightedge(color("0.6,0.6,0,0.35"));
			elseif pm == "PlayMode_Oni" then
				self:diffuserightedge(color("0.4,0,0.6,0.35"));
			elseif pm == "PlayMode_Endless" then
				self:diffuserightedge(color("0.6,0,0,0.35"));
			elseif GAMESTATE:GetCurrentStage() == 'Stage_Extra1' then
				self:diffuse(color("0.5,0,0,1"));
				self:diffuserightedge(color("0.3,0,0.1,0.45"));
			elseif GAMESTATE:GetCurrentStage() == 'Stage_Extra2' then
				self:diffuse(color("1,1,1,1"));
				self:diffuserightedge(color("0,0,0,1"));
			else
				self:diffuserightedge(color("0,0.7,1,0.35"));
			end;
		end;
	};

	--_square
	Def.ActorFrame{
		Condition=getenv("exflag") ~= "csc" and getenv("omsflag") ~= 1;
		--InitCommand=cmd(x,SCREEN_CENTER_X+100;y,SCREEN_CENTER_Y+60;rotationx,-45;rotationz,45;);
		InitCommand=cmd(x,SCREEN_CENTER_X+100;y,SCREEN_CENTER_Y+100;rotationz,20;);
		OnCommand=cmd(zoom,1.5;decelerate,0.5;zoom,1;rotationx,200;rotationy,130;rotationz,200;
					sleep,2.6;accelerate,0.3;zoom,5;);

		LoadActor( THEME:GetPathB("","_square") )..{
			InitCommand=cmd(y,-200;diffuse,color("1,1,1,0.5"););
		};
		
		LoadActor( THEME:GetPathB("","_square") )..{
			InitCommand=cmd(y,240;diffuse,color("1,1,1,0.5");diffusebottomedge,color("0,0,0,0"););
		};

		LoadActor( THEME:GetPathB("","_focus_gra/no_repeat") )..{
			InitCommand=cmd(y,-40;);
		};
	};

	Def.ActorFrame{
		Condition=getenv("exflag") == "csc" or getenv("omsflag") == 1;
		InitCommand=cmd(fov,100;x,SCREEN_CENTER_X+300;y,SCREEN_CENTER_Y;rotationx,-10;rotationy,-10;rotationz,10;);
		LoadActor(THEME:GetPathB("ScreenSelectMusicCS","background/cs_o"))..{
			OnCommand=function(self)
				(cmd(zoom,3;fadeleft,0.2;faderight,0.2;diffusealpha,0;decelerate,0.8;zoom,1;diffuse,color("0,0.8,0.9,1");sleep,2.3;accelerate,0.1;zoom,5;diffusealpha,0;))(self)
			end;
		};
	};

	Def.ActorFrame{
		InitCommand=cmd(x,SCREEN_CENTER_X-130;y,SCREEN_CENTER_Y+50;rotationx,-120;rotationz,-90;);
		OnCommand=cmd(addx,300;zoom,0.25;decelerate,1;addx,-300;zoom,1;rotationx,0;rotationz,90;sleep,2.1;accelerate,0.4;zoom,5;);
		Def.ActorFrame{
			OnCommand=cmd(spin;effectmagnitude,16,2,-20;);

			LoadActor( THEME:GetPathB("_shared","models/_08_1") )..{
				InitCommand=function(self)
					if getenv("exflag") == "csc" or getenv("omsflag") == 1 then
						(cmd(x,-100;diffuse,color("0,1,1,0.3")))(self)
					elseif GAMESTATE:GetCurrentStage() == 'Stage_Extra1' then
						(cmd(x,-100;diffuse,color("0,0,0,0.3")))(self)
					else (cmd(blend,'BlendMode_Add';x,-100;diffuse,color("0.6,0.6,0.6,0.3")))(self)
					end;
				end;
			};
		
			LoadActor( THEME:GetPathB("_shared","models/_08_1") )..{
				InitCommand=function(self)
					if getenv("exflag") == "csc" or getenv("omsflag") == 1 then
						(cmd(x,100;diffuse,color("0,1,1,0.4")))(self)
					elseif GAMESTATE:GetCurrentStage() == 'Stage_Extra1' then
						(cmd(x,100;diffuse,color("0,0,0,0.4")))(self)
					else (cmd(blend,'BlendMode_Add';x,100;diffuse,color("0.6,0.6,0.6,0.4")))(self)
					end;
				end;
			};
		};
	};

	-- banner title
	Def.ActorFrame{
		InitCommand=function(self)
			(cmd(Center;visible,false))(self)
			if backpath then self:visible(true);
			end;
		end;

		Def.Banner{
			OnCommand=function(self)
				self:Load( backpath );
				(cmd(rotationx,50;rotationz,-30;scaletoclipped,SCREEN_WIDTH,SCREEN_HEIGHT;zoomtowidth,SCREEN_WIDTH*8;zoomtowidth,SCREEN_HEIGHT*8;
				diffusealpha,0;sleep,0.2;decelerate,0.6;rotationx,0;rotationz,0;diffusealpha,0.55;zoomtowidth,SCREEN_WIDTH*1.075;zoomtoheight,SCREEN_HEIGHT*1.075;
				linear,2.1;zoomtowidth,SCREEN_WIDTH;zoomtoheight,SCREEN_HEIGHT;
				accelerate,0.15;rotationx,50;rotationz,-30;zoomtowidth,SCREEN_WIDTH*2;zoomtoheight,SCREEN_HEIGHT*2;diffusealpha,0;))(self)
			end;
		};
	};
};

return t;
