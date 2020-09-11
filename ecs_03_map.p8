pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
-- ecs_03_map v. 1.1
-- by @apa64
-- with tinyecs 1.1 by @katrinakitten https://www.lexaloffle.com/bbs/?tid=39021
-- map, camera and cell movement

--[[ MIT License

copyright (c) 2020 antti ollilainen

permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "software"), to deal
in the software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the software, and to permit persons to whom the software is
furnished to do so, subject to the following conditions:

the above copyright notice and this permission notice shall be included in all
copies or substantial portions of the software.

the software is provided "as is", without warranty of any kind, express or
implied, including but not limited to the warranties of merchantability,
fitness for a particular purpose and noninfringement. in no event shall the
authors or copyright holders be liable for any claim, damages or other
liability, whether in an action of contract, tort or otherwise, arising from,
out of or in connection with the software or the use or other dealings in the
software.
--]]
#include tinyecs-1.1.lua

-- map data
map_w = 32
map_h = 16
-- master container of entities
ents = {}
-- shortcut to player entity
e_player = nil

function _init()
  -- player
  e_player = mk_player(7, 4)
  add(ents, e_player)
end

function _update()
  s_control(ents)
end

function _draw()
  cls()
  draw_map()
  s_draw(ents)
end

-->8
-- #################### entities

-- make player at x,y
function mk_player(x, y)
  local e = ent()
  e += c_pos(x, y)
  e += c_spr(1)
  e += c_control()
  return e
end

-->8
-- ################## components

-- sprite
c_spr = function(spr)
  return cmp("spr", {spr = spr})
end

-- controllable sprite
c_control = function()
  return cmp("control")
end

-- map cell position
c_pos = function(x, y)
  return cmp("pos",
    { x = x, y = y })
end

-->8
-- ##################### systems

-- sprite drawing system.
s_draw = sys({"pos", "spr"},
function(e)
  spr(e.spr.spr,
    e.pos.x * 8,
    e.pos.y * 8)
end)

-- control system.
s_control = sys({"control", "pos"},
function(e)
  local newx = e.pos.x
  local newy = e.pos.y
  if (btnp(0)) newx -= 1
  if (btnp(1)) newx += 1
  if (btnp(2)) newy -= 1
  if (btnp(3)) newy += 1
  -- world borders
  e.pos.x = mid(0, newx, map_w-1)
  e.pos.y = mid(0, newy, map_h-1)
end)

-->8
-- ##################### helpers

-- draw map and move camera
-- to player position.
function draw_map()
  -- calculate map top left cell for current view
  -- increases in steps of 16: 0, 16, 32...
  local cam_x = flr(e_player.pos.x/16)*16
  local cam_y = flr(e_player.pos.y/16)*16
  -- move camera to show map section we want
  camera(cam_x * 8, cam_y * 8)
  -- draw the full map
  map(0, 0, 0, 0, map_w, map_h)
 end

__gfx__
00000000444440003333333333333333333333335555555500000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000041414000333333333b3b3333333666336656665600000000000000000000000000000000000000000000000000000000000000000000000000000000
0070070044444000333333333b333333336555635555555500000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000006000003333333333b333b3365555135666566600000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000466640003333333333b333b3365555135555555500000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700006000003333333333333b33331555136656665600000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000ccc0000333333333333b333333111335555555500000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000040400003333333333333333333333335666566600000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0000000001010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0402020202020202020202020202020502020202020202020202020202020204000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0402020202020202020202020202020502020202020202020202020202020204000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0402030202030202020204030202020502020402020202020202020202020204000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0402020202020202020202020202020502020202020202040202020302020204000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0402020204020202020302020202020502020202020202020202020202020204000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0402020202020202020202020202020502020302020202020202020202020204000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0402030202020302020202020402020402020202020202020302020204020204000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0402020202020202020202020202020202020202020202020202020202020204000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0402020202020202030202020202020302020202020202020202020202020204000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0402020202020202020202020202020402020202040202020202020202020204000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0402020302020202020204020202020502020202020202020202020203020204000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0402020402020202020202020202020502020202020202020202020202020204000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0402020202020203020202020202020502020202020202020202020202020204000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0402020202020202020202020202030502020202020202030202020402020204000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0402020202020202020202020202020502020302020202020202020202020204000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0505050505050505050505050505050504040404040404040404040404040404000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000