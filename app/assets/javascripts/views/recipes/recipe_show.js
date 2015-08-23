Brewcleus.Views.RecipeShow = Backbone.CompositeView.extend({

  template: JST["recipes/show"],

  // events: {
  //   "submit #recipe-form":"submit"
  // },

  initialize: function(){
    this.model.fetch();
    this.listenTo(this.model, "sync", this.render);
  },

  render: function(){
    var html = this.template({ recipe: this.model });
    this.$el.html(html);
    return this;
  }


});
