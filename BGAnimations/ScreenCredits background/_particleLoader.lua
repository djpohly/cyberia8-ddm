local Params = { 
	NumParticles = 30,
	VelocityXMin = 30,
	VelocityXMax = 70,
	VelocityYMin = 100,
	VelocityYMax = 200,
	VelocityZMin = 0,
	VelocityZMax = 0,
	BobRateZMin = 0.2,
	BobRateZMax = 0.4,
	ZoomMin = 0.3,
	ZoomMax = 0.7,
	SpinZ = 0,
	BobZ = 52,
	File = THEME:GetPathB("","_particle normal"),
};

local t = Def.ActorFrame{};
if hideFancyElements then return t; end

local tParticleInfo = {}

for i=1,Params.NumParticles do
	tParticleInfo[i] = {
		X = Params.VelocityXMin ~= Params.VelocityXMax and math.random(Params.VelocityXMin, Params.VelocityXMax) or Params.VelocityXMin,
		Y = math.random(Params.VelocityYMin, Params.VelocityYMax),
		Z = Params.VelocityZMin ~= Params.VelocityZMax and math.random(Params.VelocityZMin, Params.VelocityZMax) or Params.VelocityZMin,
		Zoom = math.random(Params.ZoomMin*1000,Params.ZoomMax*1000) / 1000,
		BobZRate = math.random(Params.BobRateZMin*1000,Params.BobRateZMax*1000) / 1000,
		Age = 0,
	};
	t[#t+1] = LoadActor( Params.File )..{
	Name="Particle"..i;
		InitCommand=function(self)
		self:basezoom(tParticleInfo[i].Zoom);
		self:x(math.random(SCREEN_LEFT+(self:GetWidth()*6),SCREEN_RIGHT-(self:GetWidth()*6)));
		self:y(math.random(SCREEN_TOP+(self:GetHeight()*6),SCREEN_BOTTOM-(self:GetHeight()*6)));
		--self:z(math.random(-64,0));
	end;
		OnCommand=cmd(glowshift;effectperiod,4;effectcolor1,ColorLightTone(color("1,1,0,1"));effectcolor2,ColorLightTone(color("0,1,1,1")));
	};
end

local function UpdateParticles(self,DeltaTime)
	tParticles = self:GetChildren();
	for i=1, Params.NumParticles do
		local p = tParticles["Particle"..i];
		local vX = tParticleInfo[i].X;
		local vY = tParticleInfo[i].Y;
		local vZ = tParticleInfo[i].Z;
		tParticleInfo[i].Age = tParticleInfo[i].Age + DeltaTime;
		p:x(p:GetX() - (vX * DeltaTime));
		p:y(p:GetY() - (vY * DeltaTime));
		p:z(p:GetZ() + (vZ * DeltaTime));
--		p:zoom( 1 + math.cos(
--			(tParticleInfo[i].Age * math.pi*2) 
--			)	* 0.125 );
		if p:GetX() > SCREEN_RIGHT + (p:GetWidth()*6 - p:GetZ()) then
			p:x(SCREEN_LEFT - (p:GetWidth()*6));
		elseif p:GetX() < SCREEN_LEFT - (p:GetWidth()*6 - p:GetZ()) then
			p:x(SCREEN_RIGHT + (p:GetWidth()*6));
		end
		if p:GetY() > SCREEN_BOTTOM + (p:GetHeight()*6 - p:GetZ()) then
			p:y(SCREEN_TOP - (p:GetHeight()*6));
		elseif p:GetY() < SCREEN_TOP - (p:GetHeight()*6 - p:GetZ()) then
			p:y(SCREEN_BOTTOM + (p:GetHeight()*6));
		end
	end;
end;

t.InitCommand = cmd(SetUpdateFunction,UpdateParticles);

return t;
