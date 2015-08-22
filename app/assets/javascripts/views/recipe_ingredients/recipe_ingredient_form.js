Brewcleus.Views.RecipeIngredientForm = Backbone.CompositeView.extend({
  template: JST["recipe_ingredients/form_selector"],

  events: {
    "submit form": "addRecipeIngredient"
  },

  initialize: function(options){
    this.parent = options.parent;

    this.collection = new Brewcleus.Collections.Ingredients();
    this.collection.fetch();
    this.listenTo(this.collection, "sync", this.render);
  },

  addRecipeIngredient: function(event){
    event.preventDefault();

    var attrs = this.$("form").serializeJSON();

    if(attrs.amount && attrs.units && attrs.ingredient_name){
      attrs.ingredient_id = this.collection.findWhere({name: attrs.ingredient_name}).id;
      this.model.set(attrs);

      this.parent.addRecipeIngredient(this.model);
      this.$(":input","#form").val("");
      this.model = new Brewcleus.Models.RecipeIngredient();
    }else{
      alert("Amount && units field can't be blank");
    };
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
