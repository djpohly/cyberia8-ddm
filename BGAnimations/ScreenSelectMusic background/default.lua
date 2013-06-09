--[[ScreenSelectMusic background]]

local t = Def.ActorFrame{};
local bUse3dModels = GetAdhocPref("Enable3DModels");
local screen = SCREENMAN:GetTopScreen();

if GAMESTATE:GetCurrentStage() == 'Stage_Extra1' then
	t[#t+1] = LoadActor( THEME:GetPathB("ScreenSelectMusicExtra","background") )..{
	};
elseif GAMESTATE:GetCurrentStage() == 'Stage_Extra2' then
	t[#t+1] = LoadActor( THEME:GetPathB("ScreenSelectMusicExtra2","background") )..{
	};
else
	if bUse3dModels == 'On' then
		t[#t+1] = Def.Quad {
			InitCommand=cmd(FullScreen;diffuse,color("0,0.7,1,1");diffuserightedge,color("0,0.7,1,0.35"););
		};
		t[#t+1] = Def.ActorFrame{
			InitCommand=cmd(fov,100);

			Def.ActorFrame{
				InitCommand=cmd(x,SCREEN_RIGHT-100;y,SCREEN_CENTER_Y+50;rotationy,-30;);
				OnCommand=cmd(addx,300;zoom,3;decelerate,1;addx,-300;zoom,2.5;rotationx,0;rotationz,40;rotationy,30;);
				
				LoadActor( THEME:GetPathB("_shared","models/_08_line") )..{
					InitCommand=cmd(blend,'BlendMode_Add';diffuse,color("0.4,0.2,0,0.5");queuecommand,"Repeat";);
					RepeatCommand=cmd(spin;effectmagnitude,-11,-8,4;);
				};
				
				LoadActor( THEME:GetPathB("_shared","models/_08_line") )..{
					InitCommand=cmd(zoom,0.8;blend,'BlendMode_Add';diffuse,color("0.4,0.2,0,0.6");queuecommand,"Repeat";);
					RepeatCommand=cmd(spin;effectmagnitude,6,-8,-5;);
				};
			};
			Def.ActorFrame{
				InitCommand=cmd(x,SCREEN_LEFT+160;y,SCREEN_CENTER_Y+50;rotationx,-120;rotationz,-90;);
				OnCommand=cmd(addx,300;zoom,1.1;decelerate,1;addx,-300;zoom,0.8;rotationx,0;rotationz,90;queuecommand,"Repeat";);
				RepeatCommand=cmd(spin;effectmagnitude,16,2,-20;);

				LoadActor( THEME:GetPathB("_shared","models/_08_1") )..{
					InitCommand=cmd(blend,'BlendMode_Add';x,-100;diffuse,color("0.6,0.6,0.6,0.1"););
				};
				
				LoadActor( THEME:GetPathB("_shared","models/_08_1") )..{
					InitCommand=cmd(blend,'BlendMode_Add';x,100;diffuse,color("0.6,0.6,0.6,0.2"););
				};
			};
		};
	else
		t[#t+1] = LoadActor( THEME:GetPathB("","_movie/_default_back") )..{
			InitCommand=cmd(Center;FullScreen);
		};
		t[#t+1] = Def.Quad {
			InitCommand=cmd(FullScreen;diffuse,color("0,0.7,1,1");diffuserightedge,color("0,0.7,1,0.35"););
		};
	end;
	
	--_square
	t[#t+1] = Def.ActorFrame{
		--InitCommand=cmd(x,SCREEN_CENTER_X+100;y,SCREEN_CENTER_Y+60;rotationx,-45;rotationz,45;);
		InitCommand=cmd(fov,100;x,SCREEN_CENTER_X+100;y,SCREEN_CENTER_Y+100;rotationz,20;);
		OnCommand=cmd(zoom,1.5;decelerate,0.5;zoom,1;rotationx,200;rotationy,130;rotationz,200;);

		LoadActor( THEME:GetPathB("","_square") )..{
			InitCommand=cmd(y,-200;diffuse,color("1,1,1,0.5"););
		};
		
		LoadActor( THEME:GetPathB("","_square") )..{
			InitCommand=cmd(y,240;diffuse,color("1,1,1,0.5");diffusebottomedge,color("0,0,0,0"););
		};

		LoadActor( THEME:GetPathB("","_focus_gra/selection") )..{
			InitCommand=cmd(y,-40;);
		};
	};
	--under
	--over
	t[#t+1] = LoadActor( THEME:GetPathB("","_background_parts") )..{
	};
	--etc
	t[#t+1] = Def.ActorFrame{
		InitCommand=function(self)
			if GAMESTATE:IsCourseMode() then self:x(SCREEN_CENTER_X-100);
			else self:x(SCREEN_CENTER_X);
			end;
			(cmd(zoomx,10;zoomy,0;y,SCREEN_CENTER_Y+30;))(self)
		end;
		OnCommand=cmd(sleep,0.2;decelerate,0.3;zoom,1;);
		LoadActor("_bannerback2")..{
			CurrentSongChangedMessageCommand=cmd(stoptweening;diffusealpha,0;accelerate,0.1;diffusealpha,1;zoomy,1.1;glow,color("1,1,0,0.75");decelerate,0.3;glow,color("1,1,0,0");zoomy,1;);
		};
	};

	t[#t+1] = LoadActor( THEME:GetPathB("","underlay") )..{
	};
end;

return t;