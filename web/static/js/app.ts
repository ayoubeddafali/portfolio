let prefixedEvent = require('prefixed-event')

function insertAfter(newNode, referenceNode) {
    referenceNode.parentNode.insertBefore(newNode, referenceNode.nextSibling);
}

class Works {

    activeElement: HTMLElement
    activeDetail: HTMLElement

    constructor () {
        let works = document.querySelectorAll('.work')
        for (let k = 0; k < works.length; k++) {
            works[k].addEventListener('click', (e) => {
                e.preventDefault()
                this.showWork(e.currentTarget as HTMLElement)
            })
        }
    }

    showWork (elem: HTMLElement) {
        if (elem == this.activeElement) {
            return false
        }
        if (this.activeDetail) {
            this.hideWork()
        }
        let detail = elem.querySelector('.work-detail').cloneNode(true) as HTMLElement
        let row = Math.ceil((parseInt(elem.getAttribute('id').replace('work', '')) + 1) / 4)
        let lastFromThisRow = document.querySelector('#work' + (row * 4 - 1))
        console.log('#work' + (row * 4 - 1))
        insertAfter(detail, lastFromThisRow)
        detail.getBoundingClientRect()
        detail.classList.add('active')
        this.activeElement = elem
        this.activeDetail = detail
    }

    hideWork () {
        let detail = this.activeDetail
        window.setTimeout(() => {
            detail.parentNode.removeChild(detail)
        }, 5000)
        detail.classList.remove('active')
    }


}

let w = new Works()
