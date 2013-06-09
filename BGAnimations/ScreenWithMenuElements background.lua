local t = Def.ActorFrame{};
local bUse3dModels = GetAdhocPref("Enable3DModels");

if bUse3dModels == 'On' then
	t[#t+1] = Def.Quad {
		InitCommand=function(self)
			local pm = GAMESTATE:GetPlayMode();
			self:FullScreen();
			self:diffuse(color("0,0.7,1,1"));
			if pm == "PlayMode_Nonstop" then
				self:diffuserightedge(color("0.6,0.6,0,0.35"));
			elseif pm == "PlayMode_Oni" then
				self:diffuserightedge(color("0.4,0,0.6,0.35"));
			elseif pm == "PlayMode_Endless" then
				self:diffuserightedge(color("0.6,0,0,0.35"));
			else
				self:diffuserightedge(color("0,0.7,1,0.35"));
			end;
		end;
	};
	t[#t+1] = Def.ActorFrame{
		InitCommand=cmd(fov,130);
		Def.ActorFrame{
			InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+50;);
			OnCommand=cmd(addx,-10;addy,10;rotationz,-60;decelerate,0.5;addx,10;addy,-10;rotationz,-100;zoomx,0.75;zoomy,1;queuecommand,"Repeat";);
			RepeatCommand=cmd(spin;effectmagnitude,6,0,0;);

			LoadActor( THEME:GetPathB("_shared","models/_08_wall") )..{
				InitCommand=cmd(blend,'BlendMode_Add';diffuse,color("0.8,0.9,0,0.15"););
			};
		};
	};
	t[#t+1] = Def.ActorFrame{
		InitCommand=cmd(fov,100);
	--_square
		Def.ActorFrame{
			--InitCommand=cmd(x,SCREEN_CENTER_X+100;y,SCREEN_CENTER_Y+60;rotationx,-45;rotationz,45;);
			InitCommand=cmd(x,SCREEN_CENTER_X+100;y,SCREEN_CENTER_Y+100;rotationz,20;);
			OnCommand=cmd(zoom,1.5;decelerate,0.5;zoom,1;rotationx,200;rotationy,130;rotationz,200;);
			LoadActor( THEME:GetPathB("","_square") )..{
				InitCommand=cmd(y,-200;diffuse,color("1,1,1,0.5"););
			};
			
			LoadActor( THEME:GetPathB("","_square") )..{
				InitCommand=cmd(y,240;diffuse,color("1,1,1,0.5");diffusebottomedge,color("0,0,0,0"););
			};

			LoadActor( THEME:GetPathB("","_focus_gra/no_selection") )..{
				InitCommand=cmd(y,-40;);
			};
		};
	};
else
	t[#t+1] = LoadActor( THEME:GetPathB("","_movie/_default_back") )..{
		InitCommand=cmd(Center;FullScreen);
	};
	t[#t+1] = Def.Quad {
		InitCommand=function(self)
			local pm = GAMESTATE:GetPlayMode();
			self:FullScreen();
			self:diffuse(color("0,0.7,1,1"));
			if pm == "PlayMode_Nonstop" then
				self:diffuserightedge(color("0.6,0.6,0,0.35"));
			elseif pm == "PlayMode_Oni" then
				self:diffuserightedge(color("0.4,0,0.6,0.35"));
			elseif pm == "PlayMode_Endless" then
				self:diffuserightedge(color("0.6,0,0,0.35"));
			else
				self:diffuserightedge(color("0,0.7,1,0.35"));
			end;
		end;
	};
	t[#t+1] = Def.ActorFrame{
		InitCommand=cmd(fov,100);
		--_square
		Def.ActorFrame{
			--InitCommand=cmd(x,SCREEN_CENTER_X+100;y,SCREEN_CENTER_Y+60;rotationx,-45;rotationz,45;);
			InitCommand=cmd(x,SCREEN_CENTER_X+100;y,SCREEN_CENTER_Y+100;rotationz,20;);
			OnCommand=cmd(zoom,1.5;decelerate,0.5;zoom,1;rotationx,200;rotationy,130;rotationz,200;);
			LoadActor( THEME:GetPathB("","_square") )..{
				InitCommand=cmd(y,-200;diffuse,color("1,1,1,0.5"););
			};
			
			LoadActor( THEME:GetPathB("","_square") )..{
				InitCommand=cmd(y,240;diffuse,color("1,1,1,0.5");diffusebottomedge,color("0,0,0,0"););
			};

			LoadActor( THEME:GetPathB("","_focus_gra/no_selection") )..{
				InitCommand=cmd(y,-40;);
			};
		};
	};
end;
--under
--etc
t[#t+1] = Def.ActorFrame{
	LoadActor( THEME:GetPathB("","underlay") )..{
	};
};

return t;