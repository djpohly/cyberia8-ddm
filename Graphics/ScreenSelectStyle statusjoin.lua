local t = Def.ActorFrame{};

for i = 1, 2 do
	local function player()
		local PLAYER;
		if i == 1 then PLAYER = PLAYER_1
		else PLAYER = PLAYER_2
		end;
		return PLAYER;
	end;

	t[#t+1] = Def.ActorFrame{
		InitCommand=function(self)
			if i == 1 then (cmd(x,(SCREEN_CENTER_X*0.575)-34;y,SCREEN_BOTTOM-28;))(self)
			else (cmd(x,(SCREEN_CENTER_X*1.425)+20;y,SCREEN_BOTTOM-28;))(self)
			end;
		end;
		LoadActor(THEME:GetPathG("ScreenWithMenuElements","Statusbar/at"))..{
			OnCommand=cmd(playcommand,"Refresh");
			CoinInsertedMessageCommand=cmd(playcommand,"Refresh");
			CoinModeChangedMessageCommand=cmd(playcommand,"Refresh");
			RefreshCommand=function(self)
				(cmd(finishtweening;diffusealpha,0;zoom,1.35;decelerate,0.3;diffusealpha,1;zoom,1;))(self)
			end;
			PlayerJoinedMessageCommand=function(self,param)
				if param.Player == player() then
					(cmd(finishtweening;diffusealpha,0;zoom,1.35;decelerate,0.3;diffusealpha,1;zoom,1;))(self)
				end;
			end;
		};
		Def.Sprite{
			InitCommand=function(self)
				(cmd(x,-103;y,-5;))(self)
				if i == 1 then self:Load(THEME:GetPathG("ScreenWithMenuElements","Statusbar/p1"));
				else self:Load(THEME:GetPathG("ScreenWithMenuElements","Statusbar/p2"));
				end;
			end;
			OnCommand=cmd(playcommand,"Refresh");
			CoinInsertedMessageCommand=cmd(playcommand,"Refresh");
			CoinModeChangedMessageCommand=cmd(playcommand,"Refresh");
			RefreshCommand=function(self)
				local join = GAMESTATE:IsHumanPlayer(player());
				if join then
					(cmd(finishtweening;diffusealpha,0;zoom,1.35;decelerate,0.3;diffusealpha,1;zoom,1;))(self)
				else
					(cmd(finishtweening;diffusealpha,1;zoom,1;accelerate,0.3;diffusealpha,0;zoom,1.35;))(self)
				end;
			end;
			PlayerJoinedMessageCommand=function(self,param)
				if param.Player == player() then
					(cmd(finishtweening;diffusealpha,0;zoom,1.35;decelerate,0.3;diffusealpha,1;zoom,1;))(self)
				end;
			end;
		};

		LoadActor(THEME:GetPathG("ScreenWithMenuElements","Statusbar/joinup"))..{
			InitCommand=cmd(x,10;y,-12;diffusealpha,0.6;);
			OnCommand=cmd(playcommand,"Refresh");
			CoinInsertedMessageCommand=cmd(playcommand,"Refresh");
			CoinModeChangedMessageCommand=cmd(playcommand,"Refresh");
			RefreshCommand=function(self)
				local join = GAMESTATE:IsHumanPlayer(player());
				if join then
					self:finishtweening();
					self:visible(false);
				else
					self:visible(true);
					(cmd(finishtweening;diffusealpha,0;zoom,1.35;decelerate,0.3;diffusealpha,1;zoom,1;))(self)
				end;
			end;
			PlayerJoinedMessageCommand=function(self,param)
				if param.Player == player() then
					self:finishtweening();
					self:visible(false);
				end;
			end;
		};

		Def.ActorFrame{
			InitCommand=cmd(playcommand,"CheckNumPlayers");
			CheckNumPlayersCommand=function(self)
				if GAMESTATE:GetNumPlayersEnabled() > 1 then
					self:visible(false);
				else
					self:visible(true);
				end;
			end;

			LoadFont("_shared2")..{
				InitCommand=cmd(x,20;y,-14;zoom,0.6;maxwidth,260);
				--Text="TESTING";
				OnCommand=cmd(playcommand,"Refresh");
				CoinInsertedMessageCommand=cmd(playcommand,"Refresh");
				CoinModeChangedMessageCommand=cmd(playcommand,"Refresh");
				RefreshCommand=function(self)
					(cmd(zoomy,0;linear,0.3;zoomy,0.6;diffuseshift;effectperiod,0.4;effectcolor1,color("1,0.9,0.2,1");effectcolor2,color("1,0.3,0.4,1");))(self)
					local bCanPlay;
					if beta_vcheck() == true then
						bCanPlay = true;
					else
						bCanPlay = GAMESTATE:EnoughCreditsToJoin();
					end;
					local p1join = GAMESTATE:IsHumanPlayer(PLAYER_1);
					local p2join = GAMESTATE:IsHumanPlayer(PLAYER_2);
					if i == 1 then
						if bCanPlay and p2join then
							self:finishtweening();
							self:visible(true);
							self:settext(THEME:GetString("ScreenTitleJoin","HelpTextJoin"));
						elseif p1join then
							self:finishtweening();
							self:visible(false);
						else
							self:finishtweening();
							self:visible(true);
							self:settext(THEME:GetString("ScreenTitleJoin","HelpTextWait"));
						end;
					else
						if bCanPlay and p1join then
							self:finishtweening();
							self:visible(true);
							self:settext(THEME:GetString("ScreenTitleJoin","HelpTextJoin"));
						elseif p2join then
							self:finishtweening();
							self:visible(false);
						else
							self:finishtweening();
							self:visible(true);
							self:settext(THEME:GetString("ScreenTitleJoin","HelpTextWait"));
						end;
					end;
				end;
				PlayerJoinedMessageCommand=function(self,param)
					if param.Player == player() then
						self:finishtweening();
						self:visible(false);
					end;
				end;
			};
		};
	};
end;

return t;