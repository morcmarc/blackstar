return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "0.14.2",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 32,
  height = 10,
  tilewidth = 64,
  tileheight = 32,
  nextobjectid = 3,
  backgroundcolor = { 204, 228, 255, 0 },
  properties = {},
  tilesets = {
    {
      name = "grass",
      firstgid = 1,
      tilewidth = 64,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      image = "grass.png",
      imagewidth = 300,
      imageheight = 220,
      tileoffset = {
        x = 0,
        y = 0
      },
      properties = {},
      terrains = {},
      tilecount = 24,
      tiles = {
        {
          id = 0,
          properties = {
            ["collidable"] = "true"
          }
        }
      }
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "Tile Layer 1",
      x = 0,
      y = 0,
      width = 32,
      height = 10,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {
        ["collidable"] = "true"
      },
      encoding = "base64",
      compression = "gzip",
      data = "H4sIAAAAAAAAA2NgGAWjYBQMFGCkE8YFWOmEcQFOOmFcAADvxkHmAAUAAA=="
    }
  }
}
