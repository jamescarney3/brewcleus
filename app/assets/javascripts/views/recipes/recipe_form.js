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
    formData.append("recipe[author_id]", authorId);

    var errorCallback = function(error){
      alert("Invalid/Incomplete Form Data: " + error);
    };

    var successCallback = function(id){
      this.removeRecipeIngredients(function(){
        this.saveRecipeIngredients(function(){
          alert("callback fired, fucking finally.");
          Backbone.history.navigate("/recipes/" + id, {trigger: true});
        });
      }.bind(this));
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

      var successCallback = function(){
        destroyCount += 1;
        if(destroyCount == destroyTarget){ callback(); };
      };

      this.removedRecipeIngredients.forEach(function(recipeIngredient){
        recipeIngredient.destroy({ success: successCallback });
      });

    }else{
      callback();
    };
  },

  saveRecipeIngredients: function(callback){
    var saveTarget = this.subviews("#recipe-ingredients-list").value().length;
    var saveCount = 0;

    var successCallback = function(){
      saveCount += 1;
      if(saveCount == saveTarget){
        callback();
      };
    };

    this.subviews("#recipe-ingredients-list").forEach(function(subview){
      subview.model.save({}, { success: successCallback });
    });

    // INSTEAD FOR SPEED?: first success can fire navigation callback, last
    // success can trigger event on recipe that show view can listen for and
    // render on - although maybe better to wait until all done
  },

  render: function(){
    var html = this.template({recipe: this.model});
    this.$el.html(html);
    this.attachSubviews();
    return this;
  }
});
