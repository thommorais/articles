/**
 * @see handleDragEnd functions to get the return
 **/

let boxes_ = document.querySelectorAll('.drag'),
    dragSrcEl_ = null,
    target = null,
    folders = {}

handleDragStart = function(e) {

    dragSrcEl_ = this
    this.classList.add('moving')
    folders = {}
    folders.folder = this.dataset.name

}

handleDragOver = function(e) {

    e.preventDefault && e.preventDefault()
    e.dataTransfer.dropEffect = 'move'
    target = this
    return false

}

handleDragEnter = function(e) {

  this.classList.add('over')
  if(this.dataset.folder == 'false') this.style.opacity = '0.3'

}

handleDragLeave = function(e) {

    this.classList.remove('over')
    if(this.dataset.folder == 'false') this.style.opacity = '1'

}

handleDrop = function(e) {

    e.stopPropagation && e.stopPropagation()
    if (dragSrcEl_ != this) folders.target = this.dataset.name

    return false
}

/**
 * @desc this is the last event o drag and drop of folder and files.
 * @param {event}
 * @return {object} with the folder target who will receive the dragged folder
 **/
handleDragEnd = function(e) {

    Array.prototype.forEach.call(boxes_, function(box) {
        box.classList.remove('over')
        box.classList.remove('moving')
    })


    if (folders.target && target.dataset.folder != 'false') {

        let folderTarget = document.querySelector(`[data-name="${folders.folder}"]`)

        folderTarget.style.display = 'none'

        console.log(folders)

        return folders

    }

}



function load() {

    boxes_ = document.querySelectorAll('.drag')
    dragSrcEl_ = null

    Array.prototype.forEach.call(boxes_, function(box) {
        box.setAttribute('draggable', 'true')
        box.addEventListener('dragstart', handleDragStart, false)
        box.addEventListener('dragenter', handleDragEnter, false)
        box.addEventListener('dragover', handleDragOver, false)
        box.addEventListener('dragleave', handleDragLeave, false)
        box.addEventListener('drop', handleDrop, false)
        box.addEventListener('dragend', handleDragEnd, false)
    })

}
