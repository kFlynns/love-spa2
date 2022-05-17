-- module Story
local Story = {}
Story.__index = Story

-- load story section
function Story.load(section, data)
  local story = require("story/" .. section)
  if type(story) ~= "table"
  then
    error("story section \"" ..  section .. "\" returns no module")
  end -- if
  if not story.run
  then
    error("story section \"" ..  section .. "\" has no run method defined")
  end -- if
  print("run: \"" .. section .. "\n")
  story.run(data)
end -- function

return Story