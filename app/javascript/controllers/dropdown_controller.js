import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dropdown"
export default class extends Controller {
  clearCategoryFilters() {
    const checkboxes = document.querySelectorAll('.category-checkbox-filters');
    checkboxes.forEach((checkbox) => {
      checkbox.checked = false;
    });
  }
}
