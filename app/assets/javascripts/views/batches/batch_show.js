Brewcleus.Views.BatchShow = Backbone.CompositeView.extend({

  template: JST["batches/show"],

  initialize: function(){
    this.model.fetch();
    this.listenTo(this.model, "sync", this.render)
  },

  render: function(){
    var html = this.template({ batch: this.model});
    this.$el.html(html);
    return this;
  }

});
