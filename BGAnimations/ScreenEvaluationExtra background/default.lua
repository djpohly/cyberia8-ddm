local t = Def.ActorFrame{};


t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(fov,100);
--under
--back
	Def.Quad {
		InitCommand=function(self)
			self:FullScreen();
			if getenv("exflag") == "csc" then
				self:diffuse(color("0,0.5,0.5,1"));
				self:diffuserightedge(color("0,0.3,0.1,0.45"));
			else
				self:diffuse(color("0.5,0,0,1"));
				self:diffuserightedge(color("0,0.7,1,0.35"));	
			end;
		end;
	};
};
--under
if getenv("exflag") == "csc" then
	t[#t+1] = Def.ActorFrame{
		InitCommand=cmd(fov,100;x,SCREEN_CENTER_X+300;y,SCREEN_CENTER_Y;rotationx,-10;rotationy,-10;rotationz,10;);
		OnCommand=cmd(zoom,1.5;decelerate,0.5;zoom,1;);
		LoadActor(THEME:GetPathB("ScreenSelectMusicCS","background/cs_o"))..{
			InitCommand=function(self)
				(cmd(fadeleft,0.2;faderight,0.2;diffuseshift;effectcolor1,color("0,0.3,0.4,0.8");effectcolor2,color("0,0.8,0.9,0.8");effectperiod,12))(self)
			end;
		};
	};
else
	t[#t+1] = LoadActor( THEME:GetPathB("","_focus_gra/extra_gra") )..{
	};
end;

t[#t+1] = LoadActor( THEME:GetPathB("","eva_back") )..{
};

t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(fov,100);

	Def.ActorFrame{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+50;rotationy,-30;);
		OnCommand=cmd(zoom,3;decelerate,0.75;zoom,2.5;rotationx,0;rotationz,40;rotationy,30;);
		
		LoadActor( THEME:GetPathB("_shared","models/_08_line") )..{
			InitCommand=function(self)
				if getenv("exflag") == "csc" then
					(cmd(diffuse,color("0,1,1,0.5");queuecommand,"Repeat"))(self)
				else
					(cmd(diffuse,color("0,0,0,0.5");queuecommand,"Repeat"))(self)
				end;
			end;
			RepeatCommand=cmd(spin;effectmagnitude,-5,-4,2;);
		};
		
		LoadActor( THEME:GetPathB("_shared","models/_08_line") )..{
			InitCommand=function(self)
				self:zoom(0.8);
				if getenv("exflag") == "csc" then
					(cmd(diffuse,color("0,1,1,0.6");queuecommand,"Repeat"))(self)
				else
					(cmd(diffuse,color("0,0,0,0.6");queuecommand,"Repeat"))(self)
				end;
			end;
			RepeatCommand=cmd(spin;effectmagnitude,3,-4,-2;);
		};
	};
	Def.ActorFrame{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y-50;rotationx,-120;rotationz,-90;);
		OnCommand=cmd(zoom,0.8;decelerate,0.75;zoom,0.3;rotationx,0;rotationz,90;queuecommand,"Repeat";);
		RepeatCommand=cmd(spin;effectmagnitude,8,1,-10;);

		LoadActor( THEME:GetPathB("_shared","models/_08_1") )..{
			InitCommand=function(self)
				self:x(-100);
				if getenv("exflag") == "csc" then
					self:diffuse(color("0,1,1,0.1"));
				else
					self:diffuse(color("0,0,0,0.1"));
				end;
			end;
		};
		
		LoadActor( THEME:GetPathB("_shared","models/_08_1") )..{
			InitCommand=function(self)
				self:x(100);
				if getenv("exflag") == "csc" then
					self:diffuse(color("0,1,1,0.1"));
				else
					self:diffuse(color("0,0,0,0.1"));
				end;
			end;
		};
	};

};

return t;