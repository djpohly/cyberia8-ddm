local t = Def.ActorFrame{
	LoadActor("mods")..{
		OnCommand=cmd(playcommand,"Set");
		ShowCommand=cmd(linear,0.2;zoomy,1;);
		HideCommand=cmd(zoomy,0;);
		SetCommand=function(self)
			if GAMESTATE:IsCourseMode() then
				self:visible(true);
				-- check for a course
				local course = GAMESTATE:GetCurrentCourse();
				if course:HasMods() then
					self:playcommand("Show");
					self:glowshift();
					self:effectcolor1(color("0.7,1,0,0.5"));
					self:effectcolor2(color("1,1,1,0"));
					self:effectperiod(1);
				else
					self:playcommand("Hide");
				end;
			else
				self:visible(false);
			end;
		end;
		CurrentCourseChangedMessageCommand=cmd(playcommand,"Set");
	};
};

return t;