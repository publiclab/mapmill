# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#jQuery ->
 # $("#s3-uploader").S3Uploader()

addEventHandler = (obj, evt, handler) ->
  if obj.addEventListener
    
    # W3C method
    obj.addEventListener evt, handler, false
  else if obj.attachEvent
    
    # IE method.
    obj.attachEvent "on" + evt, handler
  else
    
    # Old school method.
    obj["on" + evt] = handler
  return
if window.FileReader
  drop = undefined
  addEventHandler window, "load", ->
    cancel = (e) ->
      e.preventDefault()  if e.preventDefault
      false
    status = document.getElementById("upload-status")
    drop = document.getElementById("upload-area")
    list = document.getElementById("upload-list")
    addEventHandler drop, "dragover", cancel
    addEventHandler drop, "dragenter", cancel
    addEventHandler drop, "drop", (e) ->
      e = e or window.event
      e.preventDefault()  if e.preventDefault
      dt = e.dataTransfer
      files = dt.files
      i = 0

      while i < files.length
        file = files[i]
        reader = new FileReader()
        reader.readAsDataURL file
        addEventHandler reader, "loadend", ((e, file) ->
          #bin = generate_thumbnail(@result)
          bin = @result
          newFile = document.createElement("div")
          newFile.innerHTML = "Loaded : " + file.name + " size " + file.size + " B"
          list.appendChild newFile
          fileNumber = list.getElementsByTagName("div").length
          status.innerHTML = (if fileNumber < files.length then "Loaded 100% of file " + fileNumber + " of " + files.length + "..." else "Done loading. processed " + fileNumber + " files.")
          img = document.createElement("img")
          img.file = file
          img.src = bin
          im
          list.appendChild img
          return
        ).bindToEventHandler(file)
        i++
      false

    Function::bindToEventHandler = bindToEventHandler = ->
      handler = this
      boundParameters = Array::slice.call(arguments)
      (e) ->
        e = e or window.event
        boundParameters.unshift e
        handler.apply this, boundParameters
        return

    return

else
  document.getElementById("status").innerHTML = "Your browser does not support the HTML5 FileReader."
