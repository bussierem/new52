'use babel';

export default class CukeExamplesTableView {

  constructor(serializedState) {
    const variables = serializedState.variables;
    console.log(`Variables: ${variables}`);
    // Create root element
    this.element = document.createElement('div');
    this.element.classList.add('cuke-examples-table');

    const container = document.createElement('div');
    container.setAttribute('style', 'text-align: center;');
    const form = document.createElement('form');
    form.setAttribute('onsubmit', this.parseForm());
    form.setAttribute('style', 'margin:auto; border:solid; width:50%');
    // var input = document.createElement('input');
    // input.type = "button";
    // input.value = "Test";
    // input.onclick = () => {
    //   // Generate table here
    // };
    // form.appendChild(input);
    const message = document.createElement('div');
    message.setAttribute('style', 'font-size:16pt;');
    message.classList.add('message');
    message.textContent = "Variables:";
    form.appendChild(message);
    form.appendChild(document.createElement('br'));
    let table = document.createElement('table');
    table.setAttribute('style', 'margin:auto; width:50%');
    variables.forEach((v) => {
      let row = document.createElement('tr');
      let nameCol = document.createElement('td');
      nameCol.setAttribute('style','text-align: right;');
      let inputCol = document.createElement('td');
      v = String(v);
      let label = document.createElement('label');
      label.setAttribute('for', v);
      label.textContent = `${v}:`;
      nameCol.appendChild(label);
      inputCol.appendChild(this.createInput(v));
      row.appendChild(nameCol);
      row.appendChild(inputCol);
      form.appendChild(row);
    });
    // Submit button
    let row = document.createElement('tr');
    let col = document.createElement('td');
    col.setAttribute('style', 'text-align: center');
    let submit = document.createElement('input');
    submit.type = 'submit';
    col.appendChild(submit);
    row.appendChild(col);
    table.appendChild(row);
    // Finish up
    form.appendChild(table);
    container.appendChild(form);
    this.element.appendChild(container);
  }

  parseForm() {
    console.log("Yay");
  }

  createInput(variable) {
    let input = document.createElement('input');
    input.type = "text";
    console.log(`Creating input for ${variable}`);
    input.setAttribute('id', variable);
    return input;
  }

  // Returns an object that can be retrieved when package is activated
  serialize() {}

  // Tear down any state and detach
  destroy() {
    this.element.remove();
  }

  getElement() {
    return this.element;
  }

}
