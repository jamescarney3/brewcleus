Brewcleus.Views.RecipeForm = Backbone.CompositeView.extend({

  template: JST["recipes/form"],

  initialize: function(){
    this.syncModel();
    this.listenTo(this.model, "change", this.render);
  },

  syncModel: function(){
    if(!this.model.isNew()){
      this.model.fetch();
    };
  },

  render: function(){
    var html = this.template({recipe: this.model});
    this.$el.html(html);
    return this;
  }
});
