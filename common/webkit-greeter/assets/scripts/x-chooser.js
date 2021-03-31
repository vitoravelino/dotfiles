/* eslint-disable no-underscore-dangle */

export default class ChooserElement extends HTMLElement {
  constructor() {
    super();

    this._selected = {};
    this._hidden = true;
  }

  set options(options) {
    this._options = options;
  }

  set collectionKey(key) {
    this._collectionKey = key;
  }

  set displayKey(key) {
    this._displayKey = key;
  }

  set icon(icon) {
    this._icon = icon;
  }

  preselect(value) {
    if (!this._options) {
      throw Error('No options set exception');
    }

    this._selected = this._options.find((o) => o[this._collectionKey] === value);
  }

  onSelect(e) {
    const { value } = e.target.dataset;

    this.select(value);
    this.toggleDisplay();
  }

  select(value) {
    this._selected = this._options.find((o) => o[this._collectionKey] === value);

    this.rerender();
    this.triggerOptionSelectedEvent();
  }

  attachLocalEventListeners() {
    this.querySelector('.chooser').addEventListener(
      'click',
      this.toggleDisplay.bind(this)
    );
    this.querySelector('.chooser-options').addEventListener(
      'click',
      this.onSelect.bind(this)
    );
  }

  attachGlobalEventListeners() {
    document.addEventListener('keyup', (e) => {
      const ESC = 27;

      if (e.keyCode === ESC) {
        this.hide();
      }
    });
  }

  hide() {
    if (!this._hidden) {
      this.toggleDisplay();
    }
  }

  toggleDisplay() {
    const $options = this.querySelector('.chooser-options');
    const state = this._hidden ? 'block' : 'none';

    this._hidden = !this._hidden;
    $options.style.display = state;
  }

  triggerOptionSelectedEvent() {
    const event = new CustomEvent('optionSelected', {
      detail: {
        value: this._selected,
      },
    });

    this.dispatchEvent(event);
  }

  fixPosition() {
    const $icon = this.querySelector('.label-block-icon');

    if (this._icon) {
      this.querySelector('.chooser-options').style.left = `${$icon.offsetWidth}px`;
    }
  }

  connectedCallback() {
    this.render();
    this.attachGlobalEventListeners();
    this.attachLocalEventListeners();
    setTimeout(this.fixPosition.bind(this), 300);
  }

  rerender() {
    this.render();
    this.attachLocalEventListeners();
    setTimeout(this.fixPosition.bind(this), 300);
  }

  /* eslint-disable prettier/prettier */
  render() {
    this.innerHTML = `
      <div class="label-block chooser">
        ${this._icon ? `
          <div class="label-block-icon fal">
            ${this._icon}
          </div>
        `: ''}
        <div class="label-block-content">
          ${this._selected[this._displayKey]}
        </div>
      </div>
      <ul class="chooser-options">
        ${this._options.map((option) => `
          <li
            class="chooser-option ${this._selected[this._collectionKey] === option[this._collectionKey] ? 'chooser-option--selected' : ''}"
            data-value="${option[this._collectionKey]}"
          >
            ${option[this._displayKey]}
          </li>
        `).join('')}
      </ul>
    `;
  }
}

customElements.define('x-chooser', ChooserElement);
