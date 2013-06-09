local t = Def.ActorFrame{};
local bUse3dModels = GetAdhocPref("Enable3DModels");

if bUse3dModels == 'On' then
	t[#t+1] = Def.ActorFrame{
		InitCommand=cmd(fov,100);
		Def.Quad {
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
	};
else
	t[#t+1] = LoadActor( THEME:GetPathB("","_movie/_back_1") )..{
		InitCommand=cmd(Center;FullScreen);
	};
	t[#t+1] = Def.ActorFrame{
		InitCommand=cmd(fov,100);
		Def.Quad {
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
	};
end;

t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(fov,100);
--_square
	Def.ActorFrame{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+160;);
		OnCommand=cmd(zoom,1.5;decelerate,0.75;zoom,0.6;rotationx,-90;);

		LoadActor( THEME:GetPathB("","_square") )..{
			InitCommand=cmd(y,-400;diffuse,color("1,1,1,0.5"););
		};
		
		LoadActor( THEME:GetPathB("","_square") )..{
			InitCommand=cmd(y,60;diffuse,color("1,1,1,0.5"););
		};

	};

	Def.ActorFrame{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+50;rotationy,-30;);
		OnCommand=cmd(zoom,3;decelerate,0.75;zoom,2.5;rotationx,0;rotationz,40;rotationy,30;);
		
		LoadActor( THEME:GetPathB("_shared","models/_08_line") )..{
			InitCommand=cmd(blend,'BlendMode_Add';diffuse,color("0.4,0.2,0,0.5");queuecommand,"Repeat";);
			RepeatCommand=cmd(spin;effectmagnitude,-5,-4,2;);
		};
		
		LoadActor( THEME:GetPathB("_shared","models/_08_line") )..{
			InitCommand=cmd(zoom,0.8;blend,'BlendMode_Add';diffuse,color("0.4,0.2,0,0.6");queuecommand,"Repeat";);
			RepeatCommand=cmd(spin;effectmagnitude,3,-4,-2;);
		};
	};
	Def.ActorFrame{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y-50;rotationx,-120;rotationz,-90;);
		OnCommand=cmd(zoom,0.8;decelerate,0.75;zoom,0.3;rotationx,0;rotationz,90;queuecommand,"Repeat";);
		RepeatCommand=cmd(spin;effectmagnitude,8,1,-10;);

		LoadActor( THEME:GetPathB("_shared","models/_08_1") )..{
			InitCommand=cmd(blend,'BlendMode_Add';x,-100;diffuse,color("0.6,0.6,0.6,0.2"););
		};
		
		LoadActor( THEME:GetPathB("_shared","models/_08_1") )..{
			InitCommand=cmd(blend,'BlendMode_Add';x,100;diffuse,color("0.6,0.6,0.6,0.3"););
		};
	};

};

return t;