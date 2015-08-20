Brewcleus.Views.RecipeForm = Backbone.CompositeView.extend({

  template: "<h1>RecipeForm Template</h1>",



  render: function(){
    var html = this.template;
    this.$el.html(html);
    return this;
  }
});
