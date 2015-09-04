Brewcleus.Views.RecipeIngredientForm = Backbone.CompositeView.extend({
  template: JST["recipe_ingredients/form_selector"],

  events: {
    "submit form": "submit"
  },

  initialize: function(options){
    this.parent = options.parent;

    this.collection = new Brewcleus.Collections.Ingredients();
    this.collection.fetch();
    this.listenTo(this.collection, "sync", this.render);
  },

  submit: function(event){
    event.preventDefault();

    var attrs = this.$("form").serializeJSON();
    var ingredient = this.collection.findWhere({
      name: attrs.recipe_ingredient.ingredient_name
    });

    if(!!ingredient){
      debugger
      attrs.recipe_ingredient.ingredient_id = ingredient.id
      this.addRecipeIngredient(attrs);
    }else{
      this.saveIngredient(attrs, this.addRecipeIngredient.bind(this));
    };
  },

  addRecipeIngredient: function(attrs){
    if(attrs.recipe_ingredient.amount &&
      attrs.recipe_ingredient.units &&
      attrs.recipe_ingredient.ingredient_name){

      this.model.set(attrs.recipe_ingredient);
      this.parent.addRecipeIngredient(this.model); // could use to pass a callback through here
      this.$(":input","#form").val("");
      this.model = new Brewcleus.Models.RecipeIngredient();

    }else{
      alert("Incomplete form data: all fields required.");
    };
  },

  saveIngredient: function(attrs, callback){
    var newIngredient = new Brewcleus.Models.Ingredient({
      name: attrs.recipe_ingredient.ingredient_name
    });

    newIngredient.save({}, {
      success: function(model, resp){
        this.collection.add(model);
        callback(attrs);
      }.bind(this),
      error: function(model, resp){
        alert("Invalid form data: " + resp.responseText);
      }
    });
  },

  render: function(){
    var html = this.template({ingredients: this.collection});
    this.$el.html(html);
    this.$("#input-recipe-ingredient-ingredient-name").autocomplete({
      source: this.collection.pluck("name")
    });
    return this;
  }
});
