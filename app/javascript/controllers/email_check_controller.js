import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["email", "message"]

  check() {
    const value = this.emailTarget.value
    const validFormat = /^[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+$/i.test(value)

    if (value.length === 0) {
      this.reset()
      return
    }

    if (validFormat) {
      this.emailTarget.classList.remove("border-carmine")
      this.emailTarget.classList.add("border-white/10")
      this.messageTarget.textContent = ""
    } else {
      this.emailTarget.classList.remove("border-white/10")
      this.emailTarget.classList.add("border-carmine")
      this.messageTarget.textContent = "Please enter a valid email address"
    }
  }

  reset() {
    this.emailTarget.classList.remove("border-carmine")
    this.emailTarget.classList.add("border-white/10")
    this.messageTarget.textContent = ""
  }
}