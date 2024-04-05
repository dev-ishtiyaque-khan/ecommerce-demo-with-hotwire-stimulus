import { Controller } from "@hotwired/stimulus"
import debounce from "debounce"

// Connects to data-controller="cart"
export default class extends Controller {
  static targets = ['quantity', 'plusButton', 'minusButton'];
  static values = { stock: Number }

  initialize(){
    this.submitForm = debounce(this.submitForm.bind(this), 500)
  }

  connect() {
    this.toggleButtons(this.quantityTarget.value);
  }

  toggleButtons(newQuantity) {
    this.plusButtonTarget.disabled = newQuantity >= this.stockValue;
    this.minusButtonTarget.disabled = newQuantity <= 1;
  }

  update_quantity(event) {
    event.preventDefault();

    const quantityChange = parseInt(event.target.getAttribute('data-quantity'), 10);
    const newQuantity = parseInt(this.quantityTarget.value, 10) + quantityChange;

    this.toggleButtons(newQuantity);

    if (newQuantity > 0) {
      this.quantityTarget.value = newQuantity;
      this.submitForm();
    }
  }

  submitForm() {
    this.element.requestSubmit();
  }
}
