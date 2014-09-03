# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $("#s3-uploader").S3Uploader()


if(window.FileReader)  
  addEventHandler(window, 'load', () ->
    status = document.getElementById('upload-status')
    drop   = document.getElementById('s3-uploader')
    list   = document.getElementById('upload-list')
    
    cancel(e) ->
      if (e.preventDefault) 
         e.preventDefault()
      return false
  
    # Tells the browser that we *can* drop on this target
    addEventHandler(drop, 'dragover', cancel)
    addEventHandler(drop, 'dragenter', cancel)
  )
else  
  document.getElementById('upload-status').innerHTML = 'Your browser does not support the HTML5 FileReader.';


addEventHandler(drop, 'drop', (e) -> 
  e = e || window.event # get window.event if e argument missing (in IE)   
  if (e.preventDefault) 
    e.preventDefault() #stops the browser from redirecting off to the image.

  dt    = e.dataTransfer
  files = dt.files
  for file in files 
    reader = new FileReader();
    #attach event handlers here...
    reader.readAsDataURL(file);
  
  return false
)

addEventHandler reader, 'loadend', ((e, file) -> 
    bin           = this.result 
    newFile       = document.createElement('div')
    newFile.innerHTML = 'Loaded : '+file.name+' size '+file.size+' B'
    list.appendChild(newFile)  
    fileNumber = list.getElementsByTagName('div').length
    status.innerHTML = fileNumber < files.length ? 'Loaded 100% of file '+fileNumber+' of '+files.length+'...' : 'Done loading. processed '+fileNumber+' files.'

    img = document.createElement("img")
    img.file = file;
    img.src = bin
    list.appendChild(img)
).bindToEventHandler(file)


addEventHandler(obj, evt, handler) -> 
    if(obj.addEventListener)
        #W3C method
        obj.addEventListener(evt, handler, false)
    else if(obj.attachEvent) 
        #IE method.
        obj.attachEvent('on'+evt, handler)
    else 
        #Old school method.
       obj['on'+evt] = handler



