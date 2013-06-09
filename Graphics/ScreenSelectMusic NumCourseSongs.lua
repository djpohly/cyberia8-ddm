local t = Def.ActorFrame {
	LoadFont("_numbers1") ..{
		InitCommand=cmd(horizalign,left;shadowlength,0;SetTextureFiltering,false;maxwidth,150;addx,-10;diffuse,color("1,1,0,1");diffusealpha,0;sleep,0.8;decelerate,0.4;addx,10;diffusealpha,1);
		SetCommand=function(self)
			local course = GAMESTATE:GetCurrentCourse();
			local stages = 0;
			if course then
				stages = course:GetEstimatedNumStages();
			end;
			self:settext(stages);
		end;
		CurrentCourseChangedMessageCommand=cmd(playcommand,"Set");
		CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"Set");
		CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"Set");
	};
};

return t;