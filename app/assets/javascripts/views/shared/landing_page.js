Brewcleus.Views.LandingPage = Backbone.CompositeView.extend({

  template: "<h2>Brewcleus Landing Page. Hurrah!</h2>",

  render: function(){
    var html = this.template;
    this.$el.html(html);
    return this;
  }
});
