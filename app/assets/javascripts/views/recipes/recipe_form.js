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

  submit: function(event){
    event.preventDefault();
    var formData = new FormData();

    var name = this.$("#input-recipe-name").val();
    formData.append("recipe[name]", name);

    var style = this.$("#input-recipe-style").val();
    formData.append("recipe[style]", style);

    var rYield = this.$("#input-recipe-yield").val();
    formData.append("recipe[yield]", rYield);

    var originalGrav = this.$("#input-recipe-original_grav").val();
    formData.append("recipe[original_grav]", originalGrav);

    var finalGrav = this.$("#input-recipe-final_grav").val();
    formData.append("recipe[final_grav]", finalGrav);

    var ibus = this.$("#input-recipe-ibus").val();
    formData.append("recipe[ibus]", ibus);

    var description = this.$("#input-recipe-description").val();
    formData.append("recipe[description]", description);

    var authorId = Brewcleus.currentUser.id;
    formData.append("recipe[author_id]", authorId)

    var errorCallback = function(error){
      alert("Invalid/Incomplete Form Data: " + error);
    };

    var successCallback = function(id){
      this.removeRecipeIngredients(function(){
        alert("WooooOOOOooooop wooop");
      });
      // save specified RIs (also do in own function)
      // ONCE THOSE ARE DONE navigate to recipe show
      Backbone.history.navigate("recipes/" + id, {trigger: true});
    }.bind(this);

    this.model.saveFormData(formData, {
      error: errorCallback,
      success: successCallback
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
      var recipeIngredient = new Brewcleus.Models.RecipeIngredient(attrs);

      this.collection.add(recipeIngredient);

      var listItem = new Brewcleus.Views.RecipeIngredientListItem({
        model: recipeIngredient,
        parent: this
      });

      this.addSubview("#recipe-ingredients-list", listItem);

    }.bind(this));
  },

  preRemoveRecipeIngredients: function(recipeIngredient){
    if(!this.removedRecipeIngredients){
      this.removedRecipeIngredients = [recipeIngredient];
    }else{
      this.removedRecipeIngredients.push(recipeIngredient);
    };
  },

  removeRecipeIngredients: function(callback){
    if(this.removedRecipeIngredients){
      var destroyTarget = this.removedRecipeIngredients.length;
      var destroyCount = 0;

      this.removedRecipeIngredients.forEach(function(recipeIngredient){
        recipeIngredient.destroy({
          success: function(){
            alert("thing destroyed!");
            destroyCount += 1;
            if(destroyCount == destroyTarget){ callback(); };
          }
        });
      });

      // iterate through these and destroy them
      // pass destroy a success callback that increments a counter and then
      // calls the real callback when counter == array.length

    }else{
      callback(); //THIS PART WORKS
    };
  },

  render: function(){
    var html = this.template({recipe: this.model});
    this.$el.html(html);
    this.attachSubviews();
    return this;
  }
});
