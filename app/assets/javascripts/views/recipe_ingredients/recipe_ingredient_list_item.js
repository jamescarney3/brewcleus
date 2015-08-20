Brewcleus.Views.RecipeIngredientListItem = Backbone.CompositeView.extend({

  template: JST["recipe_ingredients/list_item"],

  events: {
    "click button":"removeRecipeIngredient"
  },

  initialize: function(options){
    this.parent = options.parent;
    this.render();
  },

  removeRecipeIngredient: function(){
    debugger;
    if(!this.model.isNew()){
      this.parent.preRemove(this.model);
    };
    this.parent.removeSubview("#recipe-ingredients-list", this);
  },

  render: function(){
    var html = this.template({recipeIngredient: this.model});
    this.$el.html(html);
    return this;
  }

});
