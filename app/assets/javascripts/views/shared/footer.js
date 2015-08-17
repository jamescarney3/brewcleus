Brewcleus.Views.Footer = Backbone.View.extend({

  template: "<h4>Brewcleus Footer</h4>",

  initialize: function(options){
    this.render();
  },

  render: function(){
    var html = this.template;
    this.$el.html(html);
    return this;
  }

});
