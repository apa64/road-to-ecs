-- tiny ecs v1.1
-- by katrinakitten
-- entity component system framework

-- entity factory.
-- the created entity table has + and - overridden for adding and removing components, eg. e += c_pos(x,y)
-- t    - table, entity parameters
-- returns an entity as table
function ent(t)
  local cmpt = {}
  t = t or {}
  -- override entity's + and - operators
  setmetatable(t, {
    __index = cmpt,
    __add = function(self, cmp)
      assert(cmp._cn)
      self[cmp._cn] = cmp
      return self
    end,
    __sub = function(self, cn)
      self[cn] = nil
      return self
    end
  })
  return t
end

-- component factory.
-- creates component tables with name and parameter table.
-- cn   - string, the component name, eg. "pos"
-- t    - table, component parameters, eg. {x=x,y=y}
-- returns a component as table
function cmp(cn, t)
  t = t or {}
  t._cn = cn
  return t
end

-- system factory.
-- creates a system function that runs for entity which has specified components.
-- cns  - table, component names for this system, eg. {"pos","phys"}
-- f    - function(e), the system function with param for entity that has the systems, eg. function(e) e.pos.x+=e.phys.xv end
-- returns a system function
function sys(cns, f)
  return function(ents,...)
    for e in all(ents) do
      for cn in all(cns) do
        -- break to label _ if entity does not have component
        if (not e[cn]) goto _
      end
      -- run system function f for entity e
      f(e,...)
      -- for loop breaks to this label
      ::_::
    end
  end
end
