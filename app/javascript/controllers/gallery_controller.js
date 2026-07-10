import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["modal", "image"]

    connect() {
        this.urls = Array.from(this.element.querySelectorAll("[data-gallery-url]")).map(el => el.dataset.galleryUrl)
        this.index = 0
    }

    open(event) {
        this.index = parseInt(event.currentTarget.dataset.index, 10)
        this.show()
    }

    show() {
        this.imageTarget.src = this.urls[this.index]
        this.modalTarget.classList.remove("hidden")
    }

    close(event) {
        if (event.target === this.modalTarget || event.currentTarget.dataset.close) {
        this.modalTarget.classList.add("hidden")
        }
    }

    next(event) {
        event.stopPropagation()
        this.index = (this.index + 1) % this.urls.length
        this.show()
    }

    prev(event) {
        event.stopPropagation()
        this.index = (this.index - 1 + this.urls.length) % this.urls.length
        this.show()
    }
}