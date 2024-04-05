import { Controller } from "@hotwired/stimulus"
import debounce from "debounce"

// Connects to data-controller="checkbox-filter"
export default class extends Controller {
  static targets = ['checkbox', 'input', 'select']

  initialize(){
    this.range = debounce(this.range.bind(this), 300)
  }

  range(){
    const minPriceField = this.inputTargets.find(field => field.id == 'query_price_gteq')
    const maxPriceField = this.inputTargets.find(field => field.id == 'query_price_lteq')

    let queryParams = new URLSearchParams(window.location.search);

    if (minPriceField.value.length) {
      queryParams.set('query[price_gteq]', minPriceField.value)
    } else {
      queryParams.delete('query[price_gteq]')
    }

    if (maxPriceField.value.length) {
      queryParams.set('query[price_lteq]', maxPriceField.value)
    } else {
      queryParams.delete('query[price_lteq]')
    }

    this.submit(queryParams)
  }

  toggle() {
    const selectedCheckboxValues = this.checkboxTargets
      .filter(checkbox => checkbox.checked)
      .map(checkbox => checkbox.value);

    let queryParams = new URLSearchParams(window.location.search);

    queryParams.delete('query[category_id_eq]')

    if (selectedCheckboxValues.length) {
      queryParams.set('query[category_id_in][]', selectedCheckboxValues);
    } else {
      queryParams.delete('query[category_id_in][]')
    }

    this.submit(queryParams)
  }

  update() {
    const sortBy = this.selectTarget.value;

    let queryParams = new URLSearchParams(window.location.search);

    if (sortBy) {
      queryParams.set('query[s]', sortBy)
    } else {
      queryParams.delete('query[s]')
    }

    this.submit(queryParams)
  }

  submit(queryParams) {
    let newUrl = `${window.location.pathname}`

    if (queryParams.toString()) {
      newUrl = newUrl + `?${queryParams.toString()}`;
    }

    window.history.pushState(null, '', newUrl);
    this.element.requestSubmit()
  }
}
