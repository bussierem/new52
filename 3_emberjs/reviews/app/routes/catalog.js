import Route from '@ember/routing/route';

export default Route.extend({
  model() {
    return [
      {
        name: 'Apple',
        category: 'Fruit',
        desc: "It's an apple, what do you expect here?"
      },
      {
        name: 'Fork',
        category: 'Silverware',
        desc: 'Seriously?  You need a description of a fork?'
      },
      {
        name: 'TV',
        category: 'Electronics',
        desc: "Okay so it's this funny flat thing with pixels..."
      },
      {
        name: 'Dog',
        category: 'Animal',
        desc: 'Woof woof.  Woof woof bark, bow-wow bark woof.  Boof.'
      }
    ];
  }
});
