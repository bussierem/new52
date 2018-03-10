'use babel';

import CukeExamplesTableView from './cuke-examples-table-view';
import { CompositeDisposable } from 'atom';

export default {
  modalExists: false,
  cukeExamplesTableView: null,
  modalPanel: null,
  subscriptions: null,
  variables: () => {
    let editor = atom.workspace.getActiveTextEditor();
    var contents = editor.getText();
    var re = /"\<(.*)\>"/g;
    let v = new Array();
    while (match = re.exec(contents)) {
      v.push(match);
    }
    return v.map((x) => x[1]);
  },

  activate(state) {
    // Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    this.subscriptions = new CompositeDisposable();

    // Register command that toggles this view
    this.subscriptions.add(atom.commands.add('atom-workspace', {
      'cuke-examples-table:toggle': () => this.toggle()
    }));
  },

  deactivate() {
    this.modalPanel.destroy();
    this.subscriptions.dispose();
    this.cukeExamplesTableView.destroy();
  },

  serialize() {
    return {
      cukeExamplesTableViewState: this.cukeExamplesTableView.serialize()
    };
  },

  toggle() {
    console.log('CukeExamplesTable was toggled!');
    if (this.modalExists) {
      this.modalPanel.destroy();
      this.cukeExamplesTableView.destroy();
    } else {
      var state = { variables: this.variables(), parent: this };
      this.cukeExamplesTableView = new CukeExamplesTableView(state);
      this.modalPanel = atom.workspace.addModalPanel({
        item: this.cukeExamplesTableView.getElement(),
        visible: true
      });
    }
    this.modalExists = !this.modalExists;
  }

};
