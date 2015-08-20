Brewcleus.Views.RecipeForm = Backbone.View.extend({

  template: "<h1>RecipeForm Template</h1>",



  render: function(){
    var html = this.template;
    this.$el.html(html);
    return this;
  }
});
