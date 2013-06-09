return Def.ActorFrame {
	Def.StepsDisplayList {
		Name="StepsDisplayListRow";
		CurrentSongChangedMessageCommand=function(self)
			local coursemode = GAMESTATE:IsCourseMode();
			local SongOrCourse = "";
			if coursemode then
				SongOrCourse = GAMESTATE:GetCurrentCourse();
			else
				SongOrCourse = GAMESTATE:GetCurrentSong();
			end;
			if SongOrCourse then self:visible(true);
			else self:visible(false);
			end;
		end;
		CurrentCourseChangedMessageCommand=cmd(playcommand,"CurrentSongChangedMessage";);
		CursorP1 = Def.ActorFrame {
			InitCommand=cmd(x,-20;rotationz,90;player,PLAYER_1);
			PlayerJoinedMessageCommand=function(self, params)
				if params.Player == PLAYER_1 then
					self:visible(true);
				end;
			end;
			PlayerUnjoinedMessageCommand=function(self, params)
				if params.Player == PLAYER_1 then
					self:visible(false);
				end;
			end;
			LoadActor(THEME:GetPathG("_StepsDisplayListRow cursor", "p1"))..{
				CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"PositionCheck");
				CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"PositionCheck");
				PositionCheckCommand=function(self)
					if GAMESTATE:GetNumPlayersEnabled() > 1 then
						if GAMESTATE:GetCurrentSong() then
							local p1Steps = GAMESTATE:GetCurrentSteps(PLAYER_1);
							local p2Steps = GAMESTATE:GetCurrentSteps(PLAYER_2);
							if p1Steps and p2Steps then
								if p1Steps:GetDifficulty() == p2Steps:GetDifficulty() then
									self:y(11);
								else
									self:y(0);
								end;
							end;
						elseif GAMESTATE:GetCurrentCourse() then
							local p1CSteps = GAMESTATE:GetCurrentTrail(PLAYER_1);
							local p2CSteps = GAMESTATE:GetCurrentTrail(PLAYER_2);
							if p1CSteps and p2CSteps then
								if p1CSteps:GetDifficulty() == p2CSteps:GetDifficulty() then
									self:y(11);
								else
									self:y(0);
								end;
							end;
						end;
					end;
				end;
			};
		};
		CursorP2 = Def.ActorFrame {
			InitCommand=cmd(x,-14;y,4;rotationz,90;player,PLAYER_2);
			PlayerJoinedMessageCommand=function(self, params)
				if params.Player == PLAYER_2 then
					self:visible(true);
				end;
			end;
			PlayerUnjoinedMessageCommand=function(self, params)
				if params.Player == PLAYER_2 then
					self:visible(false);
				end;
			end;
			LoadActor(THEME:GetPathG("_StepsDisplayListRow cursor", "p2"))..{
			};
		};
		CursorP1Frame = Def.Actor{
			ChangeCommand=cmd(stoptweening;decelerate,0.125);
		};
		CursorP2Frame = Def.Actor{
			ChangeCommand=cmd(stoptweening;decelerate,0.125);
		};
	};
};
