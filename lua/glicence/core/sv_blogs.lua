hook.Add("bLogs_FullyLoaded", "glicence_loadblogs", function()

  GLicence.blogs = bLogs:Module()

  GLicence.blogs.Category = "Livaco's Scripts"
  GLicence.blogs.Name     = "GLicence"
  GLicence.blogs.Colour   = Color(120, 120, 120, 255)

  bLogs:AddModule(GLicence.blogs)

end)

/*

template

if GLicence.blogs then

  GLicence.blogs:Log(bLogs:FormatPlayer(v) .. "cunt")

end

*/
