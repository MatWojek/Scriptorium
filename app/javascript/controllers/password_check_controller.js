import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["password", "confirmation", "requirements", "lowercase", "uppercase", "digit", "length"]

  check() {
    const value = this.passwordTarget.value

    this.toggle(this.lowercaseTarget, /[a-z]/.test(value))
    this.toggle(this.uppercaseTarget, /[A-Z]/.test(value))
    this.toggle(this.digitTarget, /\d/.test(value))
    this.toggle(this.lengthTarget, value.length >= 8)

    this.checkMatch()
  }

  checkMatch() {
    if (!this.hasConfirmationTarget) return

    const match = this.passwordTarget.value === this.confirmationTarget.value
    const empty = this.confirmationTarget.value.length === 0

    if (empty) {
      this.confirmationTarget.classList.remove("border-carmine", "border-white/10")
      this.confirmationTarget.classList.add("border-white/10")
    } else if (match) {
      this.confirmationTarget.classList.remove("border-carmine")
      this.confirmationTarget.classList.add("border-white/10")
    } else {
      this.confirmationTarget.classList.remove("border-white/10")
      this.confirmationTarget.classList.add("border-carmine")
    }
  }

  toggle(el, valid) {
    el.classList.toggle("text-green-400", valid)
    el.classList.toggle("text-paper/30", !valid)
  }
}