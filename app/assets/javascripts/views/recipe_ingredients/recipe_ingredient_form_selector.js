Brewcleus.Views.RecipeIngredientFormSelector = Backbone.CompositeView.extend({
  template: JST["recipe_ingredients/form_selector"],

  intialize: function(){
    this.collection = new Brewcleus.Collections.Ingredients();
    this.collection.fetch();
    this.listenTo(this.collection, "sync", this.render);
    this.listenTo("")
  },

  render: function(){
    var html = this.template({ingredients: this.collection});
    this.$el.html(html);
    return this;
  }
});
