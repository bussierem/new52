export default function() {
  this.namespace = '/api';

  this.get('/objects', function() {
    return {
      data: [
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

  // These comments are here to help you get started. Feel free to delete them.

  /*
    Config (with defaults).

    Note: these only affect routes defined *after* them!
  */

  // this.urlPrefix = '';    // make this `http://localhost:8080`, for example, if your API is on a different server
  // this.namespace = '';    // make this `/api`, for example, if your API is namespaced
  // this.timing = 400;      // delay for each request, automatically set to 0 during testing

  /*
    Shorthand cheatsheet:

    this.get('/posts');
    this.post('/posts');
    this.get('/posts/:id');
    this.put('/posts/:id'); // or this.patch
    this.del('/posts/:id');

    http://www.ember-cli-mirage.com/docs/v0.3.x/shorthands/
  */
}
