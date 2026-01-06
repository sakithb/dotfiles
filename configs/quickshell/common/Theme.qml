pragma Singleton

Singleton {
}

/*
{
  "colors": {
    "background": {
      "dark": "#161217",
      "default": "#161217",
      "light": "#fff7fc"
    },
    "error": {
      "dark": "#ffb4ab",
      "default": "#ffb4ab",
      "light": "#ba1a1a"
    },
    "error_container": {
      "dark": "#93000a",
      "default": "#93000a",
      "light": "#ffdad6"
    },
    "inverse_on_surface": {
      "dark": "#342f35",
      "default": "#342f35",
      "light": "#f7eef6"
    },
    "inverse_primary": {
      "dark": "#745186",
      "default": "#745186",
      "light": "#e1b7f5"
    },
    "inverse_surface": {
      "dark": "#e9e0e7",
      "default": "#e9e0e7",
      "light": "#342f35"
    },
    "on_background": {
      "dark": "#e9e0e7",
      "default": "#e9e0e7",
      "light": "#1e1a1f"
    },
    "on_error": {
      "dark": "#690005",
      "default": "#690005",
      "light": "#ffffff"
    },
    "on_error_container": {
      "dark": "#ffdad6",
      "default": "#ffdad6",
      "light": "#410002"
    },
    "on_primary": {
      "dark": "#432255",
      "default": "#432255",
      "light": "#ffffff"
    },
    "on_primary_container": {
      "dark": "#f5d9ff",
      "default": "#f5d9ff",
      "light": "#2c0b3e"
    },
    "on_primary_fixed": {
      "dark": "#2c0b3e",
      "default": "#2c0b3e",
      "light": "#2c0b3e"
    },
    "on_primary_fixed_variant": {
      "dark": "#5b396d",
      "default": "#5b396d",
      "light": "#5b396d"
    },
    "on_secondary": {
      "dark": "#382c3e",
      "default": "#382c3e",
      "light": "#ffffff"
    },
    "on_secondary_container": {
      "dark": "#f0dcf4",
      "default": "#f0dcf4",
      "light": "#231728"
    },
    "on_secondary_fixed": {
      "dark": "#231728",
      "default": "#231728",
      "light": "#231728"
    },
    "on_secondary_fixed_variant": {
      "dark": "#4f4255",
      "default": "#4f4255",
      "light": "#4f4255"
    },
    "on_surface": {
      "dark": "#e9e0e7",
      "default": "#e9e0e7",
      "light": "#1e1a1f"
    },
    "on_surface_variant": {
      "dark": "#cec3ce",
      "default": "#cec3ce",
      "light": "#4b444d"
    },
    "on_tertiary": {
      "dark": "#4c2526",
      "default": "#4c2526",
      "light": "#ffffff"
    },
    "on_tertiary_container": {
      "dark": "#ffdad9",
      "default": "#ffdad9",
      "light": "#331112"
    },
    "on_tertiary_fixed": {
      "dark": "#331112",
      "default": "#331112",
      "light": "#331112"
    },
    "on_tertiary_fixed_variant": {
      "dark": "#663b3c",
      "default": "#663b3c",
      "light": "#663b3c"
    },
    "outline": {
      "dark": "#978e98",
      "default": "#978e98",
      "light": "#7d747e"
    },
    "outline_variant": {
      "dark": "#4b444d",
      "default": "#4b444d",
      "light": "#cec3ce"
    },
    "primary": {
      "dark": "#e1b7f5",
      "default": "#e1b7f5",
      "light": "#745186"
    },
    "primary_container": {
      "dark": "#5b396d",
      "default": "#5b396d",
      "light": "#f5d9ff"
    },
    "primary_fixed": {
      "dark": "#f5d9ff",
      "default": "#f5d9ff",
      "light": "#f5d9ff"
    },
    "primary_fixed_dim": {
      "dark": "#e1b7f5",
      "default": "#e1b7f5",
      "light": "#e1b7f5"
    },
    "scrim": {
      "dark": "#000000",
      "default": "#000000",
      "light": "#000000"
    },
    "secondary": {
      "dark": "#d3c0d8",
      "default": "#d3c0d8",
      "light": "#68596e"
    },
    "secondary_container": {
      "dark": "#4f4255",
      "default": "#4f4255",
      "light": "#f0dcf4"
    },
    "secondary_fixed": {
      "dark": "#f0dcf4",
      "default": "#f0dcf4",
      "light": "#f0dcf4"
    },
    "secondary_fixed_dim": {
      "dark": "#d3c0d8",
      "default": "#d3c0d8",
      "light": "#d3c0d8"
    },
    "shadow": {
      "dark": "#000000",
      "default": "#000000",
      "light": "#000000"
    },
    "source_color": {
      "dark": "#9c45ce",
      "default": "#9c45ce",
      "light": "#9c45ce"
    },
    "surface": {
      "dark": "#161217",
      "default": "#161217",
      "light": "#fff7fc"
    },
    "surface_bright": {
      "dark": "#3d383d",
      "default": "#3d383d",
      "light": "#fff7fc"
    },
    "surface_container": {
      "dark": "#221e24",
      "default": "#221e24",
      "light": "#f5ebf3"
    },
    "surface_container_high": {
      "dark": "#2d282e",
      "default": "#2d282e",
      "light": "#efe5ed"
    },
    "surface_container_highest": {
      "dark": "#383339",
      "default": "#383339",
      "light": "#e9e0e7"
    },
    "surface_container_low": {
      "dark": "#1e1a1f",
      "default": "#1e1a1f",
      "light": "#faf1f9"
    },
    "surface_container_lowest": {
      "dark": "#110d12",
      "default": "#110d12",
      "light": "#ffffff"
    },
    "surface_dim": {
      "dark": "#161217",
      "default": "#161217",
      "light": "#e0d7df"
    },
    "surface_tint": {
      "dark": "#e1b7f5",
      "default": "#e1b7f5",
      "light": "#745186"
    },
    "surface_variant": {
      "dark": "#4b444d",
      "default": "#4b444d",
      "light": "#eadfea"
    },
    "tertiary": {
      "dark": "#f4b7b7",
      "default": "#f4b7b7",
      "light": "#815252"
    },
    "tertiary_container": {
      "dark": "#663b3c",
      "default": "#663b3c",
      "light": "#ffdad9"
    },
    "tertiary_fixed": {
      "dark": "#ffdad9",
      "default": "#ffdad9",
      "light": "#ffdad9"
    },
    "tertiary_fixed_dim": {
      "dark": "#f4b7b7",
      "default": "#f4b7b7",
      "light": "#f4b7b7"
    }
  },
  "image": "/home/sakithb/Pictures/Wallpapers/wallhaven-1q83qg.jpg",
  "is_dark_mode": true,
  "mode": "dark",
  "palettes": {
    "error": {
      "0": "#000000",
      "10": "#410002",
      "100": "#ffffff",
      "15": "#540003",
      "20": "#690005",
      "25": "#7e0007",
      "30": "#93000a",
      "35": "#a80710",
      "40": "#ba1a1a",
      "5": "#2d0001",
      "50": "#de3730",
      "60": "#ff5449",
      "70": "#ff897d",
      "80": "#ffb4ab",
      "90": "#ffdad6",
      "95": "#ffedea",
      "98": "#fff8f7",
      "99": "#fffbff"
    },
    "neutral": {
      "0": "#000000",
      "10": "#1d1b1e",
      "100": "#ffffff",
      "15": "#282528",
      "20": "#332f33",
      "25": "#3e3a3e",
      "30": "#494649",
      "35": "#555155",
      "40": "#615d61",
      "5": "#131013",
      "50": "#7b767a",
      "60": "#958f93",
      "70": "#b0a9ae",
      "80": "#cbc5c9",
      "90": "#e8e0e5",
      "95": "#f6eff3",
      "98": "#fff7fc",
      "99": "#fffbff"
    },
    "neutral_variant": {
      "0": "#000000",
      "10": "#1f1a21",
      "100": "#ffffff",
      "15": "#2a242c",
      "20": "#342e36",
      "25": "#403941",
      "30": "#4b444d",
      "35": "#575059",
      "40": "#635c65",
      "5": "#140f16",
      "50": "#7d747e",
      "60": "#978e98",
      "70": "#b2a8b2",
      "80": "#cec3ce",
      "90": "#eadfea",
      "95": "#f9edf8",
      "98": "#fff7fc",
      "99": "#fffbff"
    },
    "primary": {
      "0": "#000000",
      "10": "#30004a",
      "100": "#ffffff",
      "15": "#3f0060",
      "20": "#4f0076",
      "25": "#60008e",
      "30": "#6f0aa2",
      "35": "#7d21af",
      "40": "#8a31bc",
      "5": "#200033",
      "50": "#a54ed7",
      "60": "#c16af4",
      "70": "#d78dff",
      "80": "#e6b4ff",
      "90": "#f5d9ff",
      "95": "#fcebff",
      "98": "#fff7fc",
      "99": "#fffbff"
    },
    "secondary": {
      "0": "#000000",
      "10": "#231728",
      "100": "#ffffff",
      "15": "#2d2133",
      "20": "#382c3e",
      "25": "#443749",
      "30": "#4f4255",
      "35": "#5c4e61",
      "40": "#68596e",
      "5": "#170d1d",
      "50": "#817287",
      "60": "#9c8ba1",
      "70": "#b7a5bc",
      "80": "#d3c0d8",
      "90": "#f0dcf4",
      "95": "#fcebff",
      "98": "#fff7fc",
      "99": "#fffbff"
    },
    "tertiary": {
      "0": "#000000",
      "10": "#331112",
      "100": "#ffffff",
      "15": "#3f1b1c",
      "20": "#4c2526",
      "25": "#593031",
      "30": "#663b3c",
      "35": "#744647",
      "40": "#815252",
      "5": "#250609",
      "50": "#9d6a6a",
      "60": "#b98383",
      "70": "#d79c9d",
      "80": "#f4b7b7",
      "90": "#ffdad9",
      "95": "#ffedec",
      "98": "#fff8f7",
      "99": "#fffbff"
    }
  }
}
*/
