Brewcleus.Views.RecipeForm = Backbone.CompositeView.extend({

  template: JST["recipes/form"],

  events: {
    "submit form":"submit"
  },

  initialize: function(){
    this.syncRecipe();
    this.listenTo(this.model, "sync", function(){
      this.syncRecipeIngredients();
      this.render();
    });
  },

  submit: function(){
    

  },

  syncRecipe: function(){
    if(!this.model.isNew()){
      this.model.fetch();
    };
  },

  syncRecipeIngredients: function(){
    this.model.attributes.recipe_ingredients.forEach(function(attrs){
      attrs.recipe_id = this.model.id;
      var recipeIngredient = new Brewcleus.Models.RecipeIngredient(attrs);

      this.collection.add(recipeIngredient);

      var listItem = new Brewcleus.Views.RecipeIngredientListItem({
        model: recipeIngredient,
        parent: this
      });

      this.addSubview("#recipe-ingredients-list", listItem);

    }.bind(this));
  },

  preRemove: function(recipeIngredient){
    debugger;
    if(!this.removedRecipeIngredients){
      this.removedRecipeIngredients = [recipeIngredient];
    }else{
      this.removedRecipeIngredients.push(recipeIngredient);
    };
  },

  render: function(){
    var html = this.template({recipe: this.model});
    this.$el.html(html);
    this.attachSubviews();
    return this;
  }
});
