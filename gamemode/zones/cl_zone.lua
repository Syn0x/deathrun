include("sh_zone.lua")

net.Receive("ZoneSendZones", function()
	ZONE.zones = net.ReadTable()
end)

local line_mat = Material("color.vmt")
function ZONE:DrawCuboid( pos1, pos2, col )
	local pos1, pos2 = VectorMinMax( pos1, pos2 )

	col = Color(col.r, col.g, col.b, col.a )

	local points = {}
	points[1] = pos1
	points[7] = pos2

	points[2] = points[1] + ( Vector( pos2.x - pos1.x,0, 0) ) -- top level
	points[3] = points[2] + ( Vector( 0 ,pos2.y - pos1.y, 0) )
	points[4] = points[1] + ( Vector( 0 ,pos2.y - pos1.y, 0) )

	points[5] = points[1] + Vector( 0, 0, pos2.z - pos1.z)
	points[6] = points[5] + ( Vector( pos2.x - pos1.x,0, 0) )
	points[7] = points[6] + ( Vector( 0 ,pos2.y - pos1.y, 0) )
	points[8] = points[5] + ( Vector( 0 ,pos2.y - pos1.y, 0) )

	render.SetMaterial( line_mat )

	local width = 2

	render.DrawBeam( points[1], points[2], width, 1, 1, col )
	render.DrawBeam( points[2], points[3], width, 1, 1, col )
	render.DrawBeam( points[3], points[4], width, 1, 1, col )
	render.DrawBeam( points[4], points[1], width, 1, 1, col ) -- top level

	render.DrawBeam( points[5], points[6], width, 1, 1, col ) --bottom level
	render.DrawBeam( points[6], points[7], width, 1, 1, col )
	render.DrawBeam( points[7], points[8], width, 1, 1, col )
	render.DrawBeam( points[8], points[5], width, 1, 1, col )

	--Vertical connectors
	render.DrawBeam( points[1], points[5], width, 1, 1, col )
	render.DrawBeam( points[2], points[6], width, 1, 1, col )
	render.DrawBeam( points[3], points[7], width, 1, 1, col )
	render.DrawBeam( points[4], points[8], width, 1, 1, col )

end

CreateClientConVar("deathrun_zones_visibility","1",true, false)

hook.Add("PostDrawTranslucentRenderables", "DeathrunZoneCuboidDrawing", function()
	for name, z in pairs( ZONE.zones or {} ) do
		if z.type and GetConVar("deathrun_zones_visibility"):GetBool() == true then
			ZONE:DrawCuboid( z.pos1, z.pos2, z.color )
		end
	end
end)