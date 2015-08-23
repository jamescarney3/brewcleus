Brewcleus.Views.UserShow = Backbone.CompositeView.extend({
  template: JST["users/show"],

  initialize: function(options){
    this.model.fetch();
    this.listenTo(this.model, "sync", this.render);
  },

  render: function(){
    var html = this.template({ user: this.model });
    this.$el.html(html);
    return this;
  }
});
