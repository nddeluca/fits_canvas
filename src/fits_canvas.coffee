FitsCanvas = {}

FitsCanvas.VERSION = '0.0.1'

FitsCanvas.Canvas = require('./canvas')
FitsCanvas.Display = require('./display')
FitsCanvas.ScaleProcessor = require('./scale_processor')
FitsCanvas.ColorProcessor = require('./color_processor')

FitsCanvas.utils = require ('./utils')
FitsCanvas.scales = require('./scales')
FitsCanvas.colors = require('./colors')

module?.exports = FitsCanvas

