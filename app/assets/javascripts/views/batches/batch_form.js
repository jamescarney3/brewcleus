Brewcleus.Views.BatchForm = Backbone.CompositeView.extend({

  template: JST["batches/form"],

  events: {
    "submit #batch-form": "submit"
  },

  initialize: function(){
    if(this.model.isNew()){
      this.syncRecipeData();
    }else{
      this.model.fetch();
    };
    this.listenTo(this.model, "change", this.render);
  },

  syncRecipeData: function(){
    recipe = new Brewcleus.Models.Recipe({ id: this.model.get("recipe_id") })
    batch = this.model;

    recipe.fetch({  //this could get its own method in the future - fetch is overpowered for this
      success: function(resp){
        debugger;
        batch.set({
          recipe_name: resp.get("name"),
          recipe_author: resp.get("author_username")
        });
      }
    });
  },

  submit: function(event){
    event.preventDefault();

    this.model.set($(event.currentTarget).serializeJSON().batch);

    var recipeId = this.model.get("recipe_id");

    this.model.save({}, {
      success: function(model, resp){
        Backbone.history.navigate("recipes/" + model.get("recipeId") + "/batches/" + model.id, {trigger: true})
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
