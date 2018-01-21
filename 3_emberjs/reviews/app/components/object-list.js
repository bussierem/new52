import Component from '@ember/component';

export default Component.extend({
  actions: {
    showObject(object) {
      alert(`Object: ${object.name}\nDesc: ${object.desc}`);
    }
  }
});
