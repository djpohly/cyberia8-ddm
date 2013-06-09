local t = Def.ActorFrame{};
local bUse3dModels = GetAdhocPref("Enable3DModels");

if bUse3dModels == 'On' then
	t[#t+1] = Def.ActorFrame{
		InitCommand=cmd(fov,100);
		--back
		Def.Quad {
			InitCommand=cmd(FullScreen;diffuse,color("0,0.7,1,1");diffuserightedge,color("0,0.7,1,0.35"););
		};
		
		Def.ActorFrame{
			InitCommand=cmd(fov,100;);
			Def.ActorFrame{
				InitCommand=cmd(Center;);
				--OnCommand=cmd(zoom,10;addx,-10;addy,10;rotationz,-60;sleep,28.5-14.75+0.3;decelerate,0.5;addx,10;addy,-10;rotationz,-100;zoom,0.75;queuecommand,"Repeat";);
				OnCommand=cmd(zoom,10;addx,-10;addy,10;rotationz,-60;sleep,0.4+0.3;decelerate,0.5;addx,10;addy,-10;rotationz,-100;zoom,0.75;queuecommand,"Repeat";);
				RepeatCommand=cmd(spin;effectmagnitude,6,0,0;);

				LoadActor( THEME:GetPathB("_shared","models/_08_wall") )..{
					InitCommand=cmd(blend,'BlendMode_Add';diffuse,color("0.8,0.9,0,0.2"););
				};
			};

			Def.ActorFrame{
				InitCommand=cmd(x,SCREEN_RIGHT-160;y,SCREEN_CENTER_Y;);
				--OnCommand=cmd(zoom,10;sleep,28.5-14.75+0.3;decelerate,0.5;zoom,0.4;rotationx,-120;rotationz,-90;queuecommand,"Repeat";);
				OnCommand=cmd(zoom,10;sleep,0.4+0.3;decelerate,0.5;zoom,0.4;rotationx,-120;rotationz,-90;queuecommand,"Repeat";);
				RepeatCommand=cmd(spin;effectmagnitude,16,2,-20;);

				LoadActor( THEME:GetPathB("_shared","models/_08_1") )..{
					InitCommand=cmd(blend,'BlendMode_Add';x,-100;diffuse,color("0.6,0.6,0.6,0.3"););
				};
				
				LoadActor( THEME:GetPathB("_shared","models/_08_1") )..{
					InitCommand=cmd(blend,'BlendMode_Add';x,100;diffuse,color("0.6,0.6,0.6,0.4"););
				};
			};
		};
	};
else
	t[#t+1] = LoadActor( THEME:GetPathB("","_movie/_default_back") )..{
		InitCommand=cmd(Center;FullScreen;rotationz,180;);
	};
	t[#t+1] = Def.Quad {
		InitCommand=cmd(FullScreen;diffuse,color("0,0.7,1,1");diffuserightedge,color("0,0.7,1,0.35"););
	};
end;

t[#t+1] = Def.ActorFrame{
	Def.Quad{
		--OnCommand=cmd(FullScreen;diffuse,color("0.2,0,0,1");sleep,28.7-14.75;diffuse,color("1,1,1,1");linear,1;diffuse,color("0,0,0,0"););
		OnCommand=cmd(FullScreen;diffuse,color("0,0.2,0.2,1");sleep,0.6;diffuse,color("1,1,1,1");linear,1;diffuse,color("0,0,0,0"););
	};

	Def.Quad{
		InitCommand=cmd(CenterX;vertalign,top;y,SCREEN_TOP;zoomtowidth,SCREEN_WIDTH;zoomtoheight,0;diffuse,color("0,0,0,0"););
		--OnCommand=cmd(sleep,28.7-14.75;accelerate,0.5;diffuse,color("0,0.7,1,0.35");diffusetopedge,color("0,1,1,1");zoomtoheight,SCREEN_HEIGHT*0.35;);
		OnCommand=cmd(sleep,0.6;accelerate,0.5;diffuse,color("0,0.7,1,0.35");diffusetopedge,color("0,1,1,1");zoomtoheight,SCREEN_HEIGHT*0.35;);
	};
	
	Def.Quad{
		InitCommand=cmd(CenterX;vertalign,bottom;y,SCREEN_BOTTOM;zoomtowidth,SCREEN_WIDTH;zoomtoheight,0;diffuse,color("0,0,0,0"););
		--OnCommand=cmd(sleep,28.7-14.75;accelerate,0.5;diffuse,color("0,0.7,1,0.35");diffusebottomedge,color("0,1,1,1");zoomtoheight,SCREEN_HEIGHT*0.35;);
		OnCommand=cmd(sleep,0.6;accelerate,0.5;diffuse,color("0,0.7,1,0.35");diffusebottomedge,color("0,1,1,1");zoomtoheight,SCREEN_HEIGHT*0.35;);
	};
	
	Def.Quad{
		InitCommand=cmd(Center;zoomtowidth,SCREEN_WIDTH;zoomtoheight,0;diffuse,color("0,0,0,0"););
		--OnCommand=cmd(sleep,28.7-14.75;accelerate,0.5;diffuse,color("0,0.7,1,0.35");zoomtoheight,SCREEN_HEIGHT-((SCREEN_HEIGHT*0.35)*2);queuecommand,"Repeat";);
		OnCommand=cmd(sleep,0.6;accelerate,0.5;diffuse,color("0,0.7,1,0.35");zoomtoheight,SCREEN_HEIGHT-((SCREEN_HEIGHT*0.35)*2);queuecommand,"Repeat";);
		RepeatCommand=cmd(sleep,4.8;diffuse,color("1,1,0,1");linear,0.6;diffuse,color("0,0.7,1,0.35");sleep,1.2;queuecommand,"Repeat";);
	};
};

--production after
t[#t+1] = Def.ActorFrame{
	InitCommand=function(self)
		self:x(SCREEN_CENTER_X);
		self:y(SCREEN_CENTER_Y);
		--self:sleep(28.7-14.75+0.8);
		self:sleep(1.4);
		if GetScreenAspectRatio() >= 1.6 then
			self:decelerate(0.4);
			self:x(SCREEN_LEFT+300);
		end;
	end;

	Def.ActorFrame{
		InitCommand=cmd(x,150;);
		LoadActor(THEME:GetPathB("","_logo/8_front"))..{
			--OnCommand=cmd(diffusealpha,0;sleep,28.7-14.75;diffuse,color("1,1,1,1");sleep,3.6;diffuse,color("1,1,1,0.4");linear,1;diffuse,color("1,1,1,1");queuecommand,"Repeat";);
			OnCommand=cmd(diffusealpha,0;sleep,0.6;diffuse,color("1,1,1,1");sleep,3.6;diffuse,color("1,1,1,0.4");linear,1;diffuse,color("1,1,1,1");queuecommand,"Repeat";);
			RepeatCommand=cmd(diffuse,color("1,1,1,1");sleep,5.6;diffuse,color("1,1,1,0.4");linear,1;diffuse,color("1,1,1,1");queuecommand,"Repeat";);
		};
		LoadActor(THEME:GetPathB("","_logo/8_effect"))..{
		--[[
			OnCommand=cmd(diffusealpha,0;glow,color("0,0,0,0");sleep,28.7-14.75;diffusealpha,0;glow,color("0,0,0,0");cropbottom,1;sleep,3.6;
						diffusealpha,1;glow,color("1,1,0,1");linear,0.3;zoom,1.1;cropbottom,0;diffusealpha,0;
						glow,color("0,0,0,0");zoom,1;sleep,0.7;queuecommand,"Repeat";);
		]]
			OnCommand=cmd(diffusealpha,0;glow,color("0,0,0,0");sleep,0.6;diffusealpha,0;glow,color("0,0,0,0");cropbottom,1;sleep,3.6;
						diffusealpha,1;glow,color("1,1,0,1");linear,0.3;zoom,1.1;cropbottom,0;diffusealpha,0;
						glow,color("0,0,0,0");zoom,1;sleep,0.7;queuecommand,"Repeat";);
			RepeatCommand=cmd(diffusealpha,0;glow,color("0,0,0,0");cropbottom,1;sleep,5.6;diffusealpha,1;glow,color("1,1,0,1");linear,0.3;zoom,1.1;
						cropbottom,0;diffusealpha,0;glow,color("0,0,0,0");sleep,0.7;zoom,1;queuecommand,"Repeat";);
		};
	};

	Def.ActorFrame{
		InitCommand=cmd(x,150;);
		LoadActor(THEME:GetPathB("","_logo/8_front"))..{
			--OnCommand=cmd(diffusealpha,0;sleep,28.5-14.75;diffusealpha,1;accelerate,0.15;zoom,6;diffusealpha,0;);
			OnCommand=cmd(diffusealpha,0;sleep,0.4;diffusealpha,1;accelerate,0.15;zoom,6;diffusealpha,0;);
		};
		LoadActor(THEME:GetPathB("","_logo/8_front"))..{
			--OnCommand=cmd(diffusealpha,0;sleep,28.6-14.75;zoom,1;diffusealpha,0.5;accelerate,0.3;zoom,3;diffusealpha,0;);
			OnCommand=cmd(diffusealpha,0;sleep,0.5;zoom,1;diffusealpha,0.5;accelerate,0.3;zoom,3;diffusealpha,0;);
		};
		LoadActor(THEME:GetPathB("","_logo/8_front"))..{
		--[[
			OnCommand=cmd(diffusealpha,0;glow,color("0,0,0,0");sleep,28.05-14.75;zoomx,20;zoomy,1.25;accelerate,0.75;zoom,1;
						diffusealpha,1;glow,color("1,1,0,1");linear,1;glow,color("0,0,0,0");diffusealpha,0;);
		]]
			OnCommand=cmd(diffusealpha,0;glow,color("0,0,0,0");sleep,0.4;zoomx,20;zoomy,1.25;accelerate,0.75;zoom,1;
						diffusealpha,1;glow,color("1,1,0,1");linear,1;glow,color("0,0,0,0");diffusealpha,0;);
		};
	};

	LoadActor(THEME:GetPathB("","_logo/backcs"))..{
		InitCommand=cmd(x,-88;y,-19;);
	--[[
		OnCommand=cmd(diffusealpha,0;sleep,28.7-14.75;cropbottom,1;decelerate,0.3;cropbottom,0;zoomy,1;diffuse,color("1,1,1,1");sleep,3.8;
					zoom,1.1;diffuse,color("0,0,0,0");cropright,1;linear,0.5;diffuse,color("1,1,1,1");cropright,0;zoom,1;sleep,0.3;queuecommand,"Repeat";);
	]]
		OnCommand=cmd(diffusealpha,0;sleep,0.6;cropbottom,1;decelerate,0.3;cropbottom,0;zoomy,1;diffuse,color("1,1,1,1");sleep,3.8;
					zoom,1.1;diffuse,color("0,0,0,0");cropright,1;linear,0.5;diffuse,color("1,1,1,1");cropright,0;zoom,1;sleep,0.3;queuecommand,"Repeat";);
		RepeatCommand=cmd(diffuse,color("1,1,1,1");sleep,5.8;zoom,1.1;diffuse,color("0,0,0,0");cropright,1;
						linear,0.5;diffuse,color("1,1,1,1");cropright,0;zoom,1;sleep,0.3;queuecommand,"Repeat";);
	};
	LoadActor(THEME:GetPathB("","_logo/title-cs"))..{
		InitCommand=cmd(x,-174;y,-20;);
	--[[
		OnCommand=cmd(diffuse,color("0,0,0,0");sleep,28.7-14.75;sleep,4.2;diffuse,color("0,1,1,1");zoom,1;
					linear,0.3;zoom,1.25;diffuse,color("0,0,0,0");sleep,0.1;queuecommand,"Repeat";);
	]]
		OnCommand=cmd(diffuse,color("0,0,0,0");sleep,0.6;sleep,4.2;diffuse,color("0,1,1,1");zoom,1;
					linear,0.3;zoom,1.25;diffuse,color("0,0,0,0");sleep,0.1;queuecommand,"Repeat";);
		RepeatCommand=cmd(diffuse,color("0,0,0,0");sleep,6.2;diffuse,color("0,1,1,1");zoom,1;linear,0.3;zoom,1.25;diffuse,color("0,0,0,0");sleep,0.1;queuecommand,"Repeat";);
	};

	LoadActor(THEME:GetPathB("","_logo/title-tyle"))..{
		InitCommand=cmd(x,-12;y,-6.5;);
		--OnCommand=cmd(diffuse,color("0,0,0,0");sleep,28.7-14.75;sleep,4.3;diffuse,color("0.3,0.4,1,1");zoom,1;linear,0.3;diffuse,color("0,0,0,0");queuecommand,"Repeat";);
		OnCommand=cmd(diffuse,color("0,0,0,0");sleep,0.6;sleep,4.3;diffuse,color("0.3,0.4,1,1");zoom,1;linear,0.3;diffuse,color("0,0,0,0");queuecommand,"Repeat";);
		RepeatCommand=cmd(diffuse,color("0,0,0,0");sleep,6.3;diffuse,color("0.3,0.4,1,1");zoom,1;linear,0.3;diffuse,color("0,0,0,0");queuecommand,"Repeat";);
	};
	LoadActor(THEME:GetPathB("","_logo/title-yberia"))..{
		InitCommand=cmd(x,-48;y,-48;);
		--OnCommand=cmd(diffuse,color("0,0,0,0");sleep,28.7-14.75;sleep,4.1;diffuse,color("0.3,0.4,1,1");zoom,1;linear,0.3;diffuse,color("0,0,0,0");sleep,0.2;queuecommand,"Repeat";);
		OnCommand=cmd(diffuse,color("0,0,0,0");sleep,0.6;sleep,4.1;diffuse,color("0.3,0.4,1,1");zoom,1;linear,0.3;diffuse,color("0,0,0,0");sleep,0.2;queuecommand,"Repeat";);
		RepeatCommand=cmd(diffuse,color("0,0,0,0");sleep,6.1;diffuse,color("0.3,0.4,1,1");zoom,1;linear,0.3;diffuse,color("0,0,0,0");sleep,0.2;queuecommand,"Repeat";);
	};

	LoadActor(THEME:GetPathB("","_logo/cs8c"))..{
		InitCommand=cmd(x,-27;y,48;);
		--OnCommand=cmd(diffusealpha,0;addx,-10;sleep,28.6-14.75;decelerate,0.5;addx,10;diffusealpha,1;);
		OnCommand=cmd(diffusealpha,0;addx,-10;sleep,0.5;decelerate,0.5;addx,10;diffusealpha,1;);
	};

	LoadActor(THEME:GetPathB("","_logo/wau"))..{
		InitCommand=cmd(x,-88;y,-19;);
	--[[
		OnCommand=cmd(diffusealpha,0;sleep,28.1-14.75;diffuse,color("1,1,0,1");croptop,1;decelerate,0.6;croptop,0;
					linear,1;diffusealpha,0;sleep,3;queuecommand,"Repeat";);
	]]
		OnCommand=cmd(diffusealpha,0;diffuse,color("1,1,0,1");croptop,1;decelerate,0.6;croptop,0;
					linear,1;diffusealpha,0;sleep,3;queuecommand,"Repeat";);
		RepeatCommand=cmd(diffusealpha,0;diffuse,color("1,1,0,1");croptop,1;decelerate,0.6;croptop,0;linear,1;
					diffusealpha,0;sleep,5;queuecommand,"Repeat";);
	};
	LoadActor(THEME:GetPathB("","_logo/title-cybst"))..{
		InitCommand=cmd(x,-88;y,-19;);
	--[[
		OnCommand=cmd(diffusealpha,0;sleep,28.4-14.75;diffuse,color("1,1,0,1");fadetop,1;fadebottom,1;zoom,2;accelerate,0.2;zoom,1;fadetop,0;fadebottom,0;diffusealpha,1;
					linear,1;diffusealpha,0;sleep,3.4;queuecommand,"Repeat";);
	]]
		OnCommand=cmd(diffusealpha,0;sleep,0.3;diffuse,color("1,1,0,1");fadetop,1;fadebottom,1;zoom,2;accelerate,0.2;zoom,1;fadetop,0;fadebottom,0;diffusealpha,1;
					linear,1;diffusealpha,0;sleep,3.4;queuecommand,"Repeat";);
		RepeatCommand=cmd(diffuse,color("1,1,0,1");fadetop,1;fadebottom,1;zoom,2;accelerate,0.2;zoom,1;fadetop,0;fadebottom,0;diffusealpha,1;
					linear,1;diffusealpha,0;sleep,5.4;queuecommand,"Repeat";);
	};
	LoadActor(THEME:GetPathB("","_logo/subtitle"))..{
		InitCommand=cmd(x,4;y,21;);
	--[[
		OnCommand=cmd(diffusealpha,0;glow,color("0,0,0,0");sleep,28.7-14.75;diffusealpha,1;zoomx,100;linear,0.3;zoomx,1;sleep,3;glow,color("0,0,1,1");
					accelerate,0.5;glow,color("0,0,0,0");sleep,0.5;queuecommand,"Repeat";);
	]]
		OnCommand=cmd(diffusealpha,0;glow,color("0,0,0,0");sleep,0.6;diffusealpha,1;zoomx,100;linear,0.3;zoomx,1;sleep,3;glow,color("0,0,1,1");
					accelerate,0.5;glow,color("0,0,0,0");sleep,0.5;queuecommand,"Repeat";);
		RepeatCommand=cmd(glow,color("0,0,0,0");sleep,5.6;glow,color("0,0,1,1");accelerate,0.5;glow,color("0,0,0,0");sleep,0.5;queuecommand,"Repeat";);
	};
	LoadActor(THEME:GetPathB("","_logo/title-cs"))..{
		InitCommand=cmd(x,-174;y,-20;);
		--OnCommand=cmd(diffuse,color("0,0,0,0");sleep,28.5-14.75;diffuse,color("0,1,1,1");zoom,5;linear,0.1;zoom,1;linear,0.5;diffuse,color("0,0,0,0"););
		OnCommand=cmd(diffuse,color("0,0,0,0");sleep,0.4;diffuse,color("0,1,1,1");zoom,5;linear,0.1;zoom,1;linear,0.5;diffuse,color("0,0,0,0"););
	};
};

return t;