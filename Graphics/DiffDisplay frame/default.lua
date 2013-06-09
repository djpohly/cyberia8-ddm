local Player = ...
assert(Player,"Needs a Player")

local t = Def.ActorFrame{};

local difficultyStates = {
	Difficulty_Beginner	= 0,
	Difficulty_Easy		= 2,
	Difficulty_Medium	= 4,
	Difficulty_Hard		= 6,
	Difficulty_Challenge	= 8,
	Difficulty_Edit		= 10,
};
local stageindex = 0;
local scroll = {false,false};

local jrev;
jrev = Def.ActorFrame{
	LoadActor("frame")..{
		Name="Frame";
		InitCommand=cmd(animate,false;setstate,0;);
		BeginCommand=cmd(player,Player;playcommand,"Set");
		SetCommand=function(self,params)
			local selection;
			if GAMESTATE:IsCourseMode() then
				local trail = GAMESTATE:GetCurrentTrail(Player);
				local e = trail:GetTrailEntries();
				if #e > 0 then
					selection = e[stageindex]:GetSteps():GetDifficulty();
				end
			else
				selection = GAMESTATE:GetCurrentSteps(Player):GetDifficulty();
			end;
			local state = difficultyStates[selection];
			if Player == PLAYER_2 then state = state + 1; end;
			self:setstate(state);

			if Player == params.PlayerNumber then
				local ps = GAMESTATE:GetPlayerState(Player);
				local po = ps:GetPlayerOptions("ModsLevel_Preferred");
				local modstr = "default, " .. ps:GetPlayerOptionsString("ModsLevel_Preferred");
				if string.find(modstr,"^.*Reverse.*") then
					scroll[Player] = true;
					self:y(-188);
				else
					scroll[Player] = false;
					self:y(188);
				end;
			end;
		end;
		CodeMessageCommand=function(self,params)
			if Player == params.PlayerNumber then
				if params.Name == "ScrollNomal" then
					scroll[Player] = false;
				elseif params.Name == "ScrollReverse" then
					scroll[Player] = true;
				end;
			end;
		end;
		CurrentSongChangedMessageCommand=function(self)
			if GAMESTATE:IsCourseMode() then
				stageindex = stageindex + 1;
			end;
			self:playcommand("Set");
		end;
	};
	
	LoadFont("_Shared2")..{
		Name="Description";
		InitCommand=cmd(zoom,0.5;maxwidth,SCREEN_WIDTH*0.5;);
		BeginCommand=cmd(player,Player;playcommand,"Set");
		SetCommand=function(self,params)
			local selection;	
			if GAMESTATE:IsCourseMode() then
				local trail = GAMESTATE:GetCurrentTrail(Player);
				local e = trail:GetTrailEntries();
				if #e > 0 then
					selection = e[stageindex]:GetSteps();
				end
			else
				selection = GAMESTATE:GetCurrentSteps(Player);
			end;
			self:diffuse(Colors.Difficulty[selection:GetDifficulty()]);
			if Player == PLAYER_1 then
				self:horizalign(left);
				self:x(50);
			else
				self:horizalign(right);
				self:x(-50);
			end;
			if selection:GetDifficulty() == "Difficulty_Edit" and  selection:GetDescription() ~= "" then
				self:settext(selection:GetDescription());
			else
				self:settext("");
			end;

			if Player == params.PlayerNumber then
				local ps = GAMESTATE:GetPlayerState(Player);
				local po = ps:GetPlayerOptions("ModsLevel_Preferred");
				local modstr = "default, " .. ps:GetPlayerOptionsString("ModsLevel_Preferred");
				if string.find(modstr,"^.*Reverse.*") then
					self:y(-186);
				else
					self:y(186);
				end;
			end;
		end;
	};
};

local function update(self)
	if GAMESTATE:IsPlayerEnabled(Player) then
			local ps = GAMESTATE:GetPlayerState(Player);
			local po = ps:GetPlayerOptions("ModsLevel_Preferred");
			local modstr = "default, " .. ps:GetPlayerOptionsString("ModsLevel_Preferred");
			if string.find(modstr,"^.*Reverse.*") then
			self:finishtweening();
			self:GetChild("Frame"):y(-188);
			self:GetChild("Description"):y(-186);
		else
			self:finishtweening();
			self:GetChild("Frame"):y(188);	
			self:GetChild("Description"):y(186);
		end;
	end;
end;

jrev.InitCommand=cmd(SetUpdateFunction,update;);
t[#t+1] = jrev;


return t;