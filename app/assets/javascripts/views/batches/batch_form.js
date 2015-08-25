Brewcleus.Views.BatchForm = Backbone.CompositeView.extend({

  template: JST["batches/form"],

  events: {
    "submit #batch-form": "submit"
  },

  initialize: function(){
    this.listenTo(this.model, "change", this.render)
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
