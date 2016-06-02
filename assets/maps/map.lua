return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "0.14.2",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 100,
  height = 10,
  tilewidth = 32,
  tileheight = 32,
  nextobjectid = 12,
  properties = {},
  tilesets = {
    {
      name = "swamp1",
      firstgid = 1,
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      image = "swamp1.png",
      imagewidth = 32,
      imageheight = 32,
      tileoffset = {
        x = 0,
        y = 0
      },
      properties = {},
      terrains = {},
      tilecount = 1,
      tiles = {
        {
          id = 0,
          properties = {
            ["collidable"] = "true"
          }
        }
      }
    },
    {
      name = "swamp2",
      firstgid = 2,
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      image = "swamp2.png",
      imagewidth = 32,
      imageheight = 32,
      tileoffset = {
        x = 0,
        y = 0
      },
      properties = {},
      terrains = {},
      tilecount = 1,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "Background",
      x = 0,
      y = 0,
      width = 100,
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
      data = "H4sIAAAAAAAAA+3DsQkAAAgDsOr/R/uFdEggCQAAwI+x6lr1AI9DV/SgDwAA"
    },
    {
      type = "objectgroup",
      name = "Spawns",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      objects = {
        {
          id = 2,
          name = "theosophist_1",
          type = "Theosophist",
          shape = "rectangle",
          x = 674.805,
          y = 226.724,
          width = 25.4897,
          height = 25.4897,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "theosophist_2",
          type = "Theosophist",
          shape = "rectangle",
          x = 322.646,
          y = 226.053,
          width = 25.4897,
          height = 25.4897,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 10,
          name = "player",
          type = "Player",
          shape = "ellipse",
          x = 36.893,
          y = 6.70779,
          width = 20.1234,
          height = 18.7819,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "anthropophagist_1",
          type = "Anthropophagist",
          shape = "rectangle",
          x = 1122.89,
          y = 227.395,
          width = 25.4897,
          height = 25.4897,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
