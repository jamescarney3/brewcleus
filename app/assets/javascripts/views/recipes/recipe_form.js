Brewcleus.Views.RecipeForm = Backbone.CompositeView.extend({

  template: JST["recipes/form"],

  initialize: function(){
    this.syncRecipe();
    this.listenTo(this.model, "change", function(){
      this.syncRecipeIngredients();
      this.render();
    });
  },

  syncRecipe: function(){
    if(!this.model.isNew()){
      this.model.fetch();
    };
  },

  syncRecipeIngredients: function(){
    this.model.attributes.recipe_ingredients.forEach(function(attrs){
      attrs.recipe_id = this.model.id;
      this.collection.add(attrs);
    }.bind(this));
  },

  render: function(){
    var html = this.template({recipe: this.model});
    this.$el.html(html);
    return this;
  }
});
