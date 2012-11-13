FitsCanvas
===================

Library to display fits files and other images in the browser using an html5 canvas.

Install
---
Assuming your using a spinejs or hem application:

Add to package.json
```coffeescript
"dependencies": {
  "fits_canvas": "git://github.com/nddeluca/fits_canvas.git"
}
```
Add to slug.json
```coffeescript
"dependencies": [
  "fits_canvas"
]
```
Run
```bash
npm install
```

Simple Usage
---
To display a fits file create a new Display Object.  The Display class takes a container id, width, and an image.
The conainter id is the css id of the containing div element where the canvas will be created.
The width is the width of the canvas the fits image is displayed on (also the width of the image).
The image is any object with data, width, and height attributes.
```coffeescript
display = new FitsCanvas.Display(container_id, width, image)
```
Once a FitsDisplay is created, call processImage() to build the fits image.
Then call draw() to draw the image to the canvas.
```coffeescript
display.processImage()
display.draw()
```
The default scaling of the image is linear, and the default color is grayscale.
The height is set by using the intial width to keep the same aspect ratio.

Note: The canvas does not have to be the same size as the fit file image.
The fits image will be scaled down or up to fit the canvas when drawn.

Use
Example of this usage:
```coffeescript
FitsCanvas = require('fits_canvas')
FITS = require('fits')

xhr = new XMLHttpRequest()
xhr.open('GET', 'images/my_fits_file.fits')
xhr.responseType = 'arraybuffer'  	
xhr.send()

xhr.onload = (e) ->
  #Use atrojs/fitsjs to get fits image from binary file
  fitsFile = new FITS.file(xhr.response)
  image = fitsFile.getDataUnit()
  image.getFrame()
  
  display = new FitsCanvas.Display('my-canvas-container',500,image)
  display.processImage()
  display.draw()
```
```html
<div id="my-canvas-container"></div>
```

Advanced Usage
---
The library also allows different scaling and color methods to be used.
However, currently only linear scaling and grayscale color are available.

Though, as more methods are written they can be set by setting the scale and color method of the FitsDisplay 
before calling processImage(). For example, the following code would use a log scale 
and heat color to show the fits image.
```coffeescript
display = new FitsCanvas.Display('my-container',500,image)
display.scale = FitCanvas.scales.log #Not availiable yet
display.color = FitCanvas.colors.heat #Not availiable yet
display.processImage()
display.draw()
```
In addition, custom functions can be written and used to scale or color the image.
```coffeescript
myScaleFunction = (imageData, scaleData) ->
  #Use own scaling method here
  
display.scale = myScaleFunction
```
The imageData parameter is the data from the fits image.  The scaleData parameter is the array being written to, 
and is a Uint8ClampedArray in order to insure values bewteen 0 and 255.  The fitsMin parameter is the 
mininum value in the imageData array, and the fitsMax parameter is the maxinum value in the fitsData array.

Similary with color:
```coffeescript
myColorFunction = (scaleData, colorData) ->
  #Use own color method here

display.color = myColorFunction
```
The scaleData is the data returned by the scaling method and is a Uint8ClampedArray with values from 0 to 255.
The colorData is a Uint32Array where each RGBA pixel (8 bits each value) is represented in each array index.

To get an idea of the usage, here is the linear and grayscale functions that are used by default.
```coffeescript
scales = 
  linear: (imageData, scaleData) ->
    min = utils.min(imageData)
    max = utils.max(imageData)
    range = max - min
    for i in [0..(scaleData.length - 1)]
      scaleData[i] = ~~(255*((imageData[i] - min)/range))
    return

colors =
  grayscale: (scaleData,colorData) ->
    for i in [0..(scaleData.length-1)]
      value = scaleData[i]
      colorData[i] = (255 << 24) | (value << 16) | (value << 8) | value
    return
```
Note: It's important that these functions end with return.  Ended with a loop will negatively affect performance.

To Do
---
* Write tests and benchmark
* Add processor endainness check (the grayscale algorithm currently only works on little-endian machines)

References
---
https://github.com/astrojs/fitsjs  
https://hacks.mozilla.org/2011/12/faster-canvas-pixel-manipulation-with-typed-arrays/  
http://tech-algorithm.com/articles/nearest-neighbor-image-scaling/  
http://coffeescriptcookbook.com/  

