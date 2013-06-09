-- the return of dubaiOne's custom OptionsIcons.

local Player = ...;
assert(Player);
local pname = pname(Player);

local spacingX = THEME:GetMetric("ModIconRowSelectMusic","SpacingX");
local spacingY = THEME:GetMetric("ModIconRowSelectMusic","SpacingY");

local numRows = 1;
local numCols = THEME:GetMetric("ModIconRowSelectMusic","NumModIcons");

local c;
local u = Def.ActorFrame{
	Name="OptionIconRow"..pname;
	OnCommand=cmd(playcommand,"Update");
	UpdateCommand=function(self)
		local PlayerState = GAMESTATE:GetPlayerState(Player);
		local options = PlayerState:GetPlayerOptionsString('ModsLevel_Preferred');
		local listOfOptions = split(", ", options);
		local numOptions = #listOfOptions;

		local iconMain, iconImage, iconText;
		for row=1,numRows do
			for i=1,numCols do
				iconMain = self:GetChild( pname.."ModIcon"..i );
				iconImage = iconMain:GetChild("Icon");
				iconText = iconMain:GetChild("Label");

				local text = listOfOptions[i] or "";
				iconText:settext(text);
				if text == "" then
					iconImage:Load(THEME:GetPathG("ModIcon","Empty"));
				else
					iconImage:Load(THEME:GetPathG("ModIcon","Filled"));
				end;
			end;
		end;
	end;
	PlayerOptionsChangedMessageCommand=function(self,param)
		if param.PlayerNumber == Player then
			self:playcommand("Update");
		end;
	end;
};

local function MakeIcons()
	for i=1,numCols do
		u[#u+1] = Def.ActorFrame{
			Name=pname.."ModIcon"..i;
			InitCommand=cmd(x,((i-1) * spacingX);y,0;);
			LoadActor(THEME:GetPathG("ModIcon","Empty"))..{
				Name="Icon";
			};
			LoadFont("OptionIcon text")..{
				Name="Label";
				Text="";
				InitCommand=cmd(diffuse,color("1,1,1,1");maxwidth,36);
				OnCommand=THEME:GetMetric(Var "LoadingScreen","ModIconTextOnCommand");
			};
		};
	end;
end;

u.InitCommand=MakeIcons();

return u;