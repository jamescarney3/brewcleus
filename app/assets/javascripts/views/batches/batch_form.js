Brewcleus.Views.BatchForm = Backbone.CompositeView.extend({

  template: JST["batches/form"],

  events: {
    "submit #batch-form": "submit"
  },

  initialize: function(options){
    this.recipeId = options.recipeId;

    if(this.model.isNew()){
      this.syncRecipeData();
    }else{
      this.validateRecipeId();
    };

    this.listenTo(this.model, "change", this.render);
  },

  syncRecipeData: function(){
    recipe = new Brewcleus.Models.Recipe({ id: this.model.get("recipe_id") })
    batch = this.model;

    recipe.fetch({  //this could get its own method in the future - fetch is overpowered for this
      success: function(resp){
        batch.set({
          recipe_name: resp.get("name"),
          recipe_author: resp.get("author_username")
        });
      }
    });
  },

  validateRecipeId: function(){
    var model = this.model;
    var recipe_id = this.recipeId;

    var goHome = function(){
      Backbone.history.navigate("", {trigger: true});
    };

    model.fetch({
      success: function(){
        if(model.get("recipe_id") != parseInt(recipe_id)){
          goHome();
        };
      },
      error: function(){
        goHome();
      }
    });
  },

  submit: function(event){
    event.preventDefault();

    this.model.set($(event.currentTarget).serializeJSON().batch);

    var recipeId = this.recipeId

    this.model.save({}, {
      success: function(model, resp){
        Backbone.history.navigate("recipes/" + recipeId + "/batches/" + model.id, {trigger: true})
      },
      error: function(model, resp){
        alert("Invalid form data: " + resp.responseText);
      }
    });
  },

  render: function(){
    var html = this.template({ batch: this.model});
    this.$el.html(html);
    return this;
  }
})
