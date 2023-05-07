import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // connect() {
  //   this.element.textContent = "Hello World!"
  // }

  static targets = ["name"]

  greet() {
    const element = this.nameTarget
    const name = element.value
    console.log(`hello, ${name}!`)
  }
}
