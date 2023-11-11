// app/javascript/controllers/dialog_controller.js
import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dialog"
export default class extends Controller {
  static targets = ["modal", "frame"]

  connect() {
    this.modalTarget.addEventListener("close", this.enableBodyScroll.bind(this))
  }

  disconnect() {
    this.modalTarget.removeEventListener("close", this.enableBodyScroll.bind(this))
  }

  // hide modal on successful form submission
  // data-action="turbo:submit-end->turbo-modal#submitEnd"
  submitEnd(e) {
    if (e.detail.success) {
      // console.log(e.detail.success)
      this.close()
    }
  }

  open() {
    // this.modalTarget.show()
    this.modalTarget.showModal()
    document.body.classList.add('overflow-hidden')
  }

  close() {
    this.modalTarget.close()
    // document.body.classList.remove('overflow-hidden')
    this.frameTarget.removeAttribute("src")
    this.frameTarget.innerHTML = ""
  }

  enableBodyScroll() {
    document.body.classList.remove('overflow-hidden')
  }

  clickOutside(event) {
    if (event.target === this.modalTarget) {
      this.close()
    }
  }
}
