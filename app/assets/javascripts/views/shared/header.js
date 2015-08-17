Brewcleus.Views.Header = Backbone.View.extend({

  // template: JST['shared/header'],

  template: "<h1>Brewcleus Header</h1>",

  initialize: function(options){
    this.render();
  },

  render: function(){
    var html = this.template;
    this.$el.html(html);
    return this;
  },

});
