-- A simple helper module for drawing polygons and polylines with
-- rounded corners in love2d 0.9 (http://love2d.org/)
-- The MIT License (MIT)
-- Copyright (c) 2014 Periklis Ntanasis <pntanasis@gmail.com>

local corner_rounder = {}

--[[
Here are all the possible 90/270 degrees corner cases:

 * 1 left -> right -> down
 * 2 left -> right -> up
 * 3 right -> left -> up
 * 4 left -> right -> down
 * 5 down -> up -> left
 * 6 up -> down -> left
 * 7 up -> down -> right
 * 8 down -> up -> right	
]]

local function get_X(r, y, a, b)
	return  a + math.sqrt(math.abs(r*r - math.pow((y-b), 2)))
end

local function get_Y(r, x, a, b)
	return  b + math.sqrt(math.abs(r*r - math.pow((x-a), 2)))
end

-- these functions are needed because graphics system isn't Cartesian
-- and classic circle equation cannot be applied
local function get_inverse_X(r, y, a, b)
	return  a - math.sqrt(math.abs(r*r - math.pow((y-b), 2)))
end

local function get_inverse_Y(r, x, a, b)
	return  b - math.sqrt(math.abs(r*r - math.pow((x-a), 2)))
end

local function check_lines(lineA, lineB)
	if lineA[2] == lineA[4] then
		-- A is horizontal
		local Aleft_to_right = true
		if lineA[1] > lineA[3] then
			Aleft_to_right = false
		end
		local Bup_to_down = true
		if lineB[2] > lineB[4] then
			Bup_to_down = false
		end
		if lineB[1] == lineB[3] then
			-- B is vertical			
			if Aleft_to_right then
				if Bup_to_down then
					return 1 -- +,+
				else
					return 2 -- +,-
				end
			else
				if Bup_to_down then
					return 4 -- -,+
				else
					return 3 -- -,-
				end
			end				
		end
	else
		-- A is vertical
		local Aup_to_down = true
		if lineA[2] > lineA[4] then
			Aup_to_down = false
		end
		local Bleft_to_right = true
		if lineB[1] > lineB[3] then
			Bleft_to_right = false
		end
		if lineB[2] == lineB[2] then
			-- B is horizontal
			if Aup_to_down then
				if Bleft_to_right then
					return 7 -- +, +
				else
					return 6 -- -, +
				end
			else
				if Bleft_to_right then
					return 8 -- -,-
				else
					return 5 -- +,-
				end
			end
		end
	end
	return 0 -- corner of 180 degrees
end

function corner_rounder.get_points(lines, r, n, polyline)
	r = r or 8
	n = n or 20
	local points = {}	
	local center = {}
	for i = 1, #lines do
		local next_line = i+1
		if next_line == #lines+1 then
			next_line = 1
		end
		center.x = 0
		center.y = 0
		-- add the lines to the points table
		if lines[i][2] == lines[i][4] then
			-- vertical line
			if math.abs(lines[i][1] - lines[i][3]) <= r then
				print("A line should be longer than r")
				os.exit()
			elseif math.abs(lines[i][1] - lines[i][3]) <= 2*r then
				print("Warning: A line is shorter than 2r")
			end
			if polyline and i == 1 then
				table.insert(points , lines[i][1])
			else
				if lines[i][1] < lines[i][3] then
					table.insert(points , lines[i][1]+r)
				else
					table.insert(points , lines[i][1]-r)
				end
			end
			table.insert(points , lines[i][2])
			if polyline and i == #lines then
				table.insert(points , lines[i][3])
			else
				if lines[i][1] < lines[i][3] then
					table.insert(points , lines[i][3]-r)
				else
					table.insert(points , lines[i][3]+r)
				end
			end
			table.insert(points , lines[i][4])
		elseif lines[i][1] == lines[i][3] then
			-- horizontal line
			if math.abs(lines[i][2] - lines[i][4]) <= r then
				print("A line should be longer than r")
				os.exit()
			elseif math.abs(lines[i][2] - lines[i][4]) <= 2*r then
				print("Warning: A line is shorter than 2r")
			end
			table.insert(points , lines[i][1])
			if polyline and i == 1 then
				table.insert(points , lines[i][2])
			else
				if lines[i][2] < lines[i][4] then
					table.insert(points , lines[i][2]+r)
				else
					table.insert(points , lines[i][2]-r)
				end
			end
			table.insert(points , lines[i][3])
			if polyline and i == #lines then
				table.insert(points , lines[i][4])
			else
				if lines[i][2] < lines[i][4] then
					table.insert(points , lines[i][4]-r)
				else
					table.insert(points , lines[i][4]+r)
				end
			end
		end
		local corner_case
		if polyline and i == #lines then
			corner_case = 0
		else
			corner_case = check_lines(lines[i], lines[next_line])
		end
		-- calculate the circle center
		if corner_case == 1 then
			center.x = lines[i][3] - r
			center.y = lines[i][4] + r
		elseif corner_case == 2 then
			center.x = lines[i][3] - r
			center.y = lines[i][4] - r
		elseif corner_case == 3 then
			center.x = lines[i][3] + r
			center.y = lines[i][4] - r
		elseif corner_case == 4 then
			center.x = lines[i][3] + r
			center.y = lines[i][4] + r
		elseif corner_case == 5 then
			center.x = lines[i][3] - r
			center.y = lines[i][4] + r
		elseif corner_case == 6 then
			center.x = lines[i][3] - r
			center.y = lines[i][4] - r
		elseif corner_case == 7 then
			center.x = lines[i][3] + r
			center.y = lines[i][4] - r
		elseif corner_case == 8 then
			center.x = lines[i][3] + r
			center.y = lines[i][4] + r
		end
		-- if there is a corner of 90/270 degrees
		if center.x ~= 0 and center.y ~= 0 then
			local y = 0
			local x = 0
			dist = r / n
			for j = 1,n-1 do
				if corner_case == 1 then
					x = dist * j + center.x
					y = get_inverse_Y(r, x, center.x, center.y)
				elseif corner_case == 2 then
					x = dist * j + center.x
					y = get_Y(r, x, center.x, center.y)
				elseif corner_case == 3 then
					x = center.x - dist * j
					y = get_Y(r, x, center.x, center.y)
				elseif corner_case == 4 then
					x = center.x - dist * j
					y = get_inverse_Y(r, x, center.x, center.y)
				elseif corner_case == 5 then
					x = lines[i][3] - dist * j
					-- alternatively can be written like that
					-- x = center.x + r - dist*j
					y = get_inverse_Y(r, x, center.x, center.y)
				elseif corner_case == 6 then
					y = center.y + dist * j
					x = get_X(r, y, center.x, center.y)
				elseif corner_case == 7 then
					y = center.y + dist * j
					x = get_inverse_X(r, y, center.x, center.y)
				elseif corner_case == 8 then
					y = center.y - dist * j
					x = get_inverse_X(r, y, center.x, center.y)
				end
				table.insert(points, x)				
				table.insert(points, y)
			end
		end 
	end
	return points
end

local function points_to_lines(points, polyline)
	local lines = {}
	if #points % 2 == 1 then
		print("Unexpected number of points!")
		os.exit()
	end
	local i = 1
	while i < #points do
		if i == #points-1 then
			if not polyline then
				table.insert(lines, {points[i], points[i+1], points[1], points[2]} )
			end
		else
			table.insert(lines, {points[i], points[i+1], points[i+2], points[i+3]} )
		end		
		i = i + 2
	end
	return lines
end

function corner_rounder.tranform_polygon_points(points, r, n)
	return corner_rounder.get_points(points_to_lines(points, false), r, n)
end

function corner_rounder.tranform_line_points(points, r, n)
	return corner_rounder.get_points(points_to_lines(points, true), r, n, true)
end

return corner_rounder