Brewcleus.Views.Header = Backbone.View.extend({

  // template: JST['shared/header'],

  template: JST["shared/header"],

  initialize: function(options){
    this.render();
  },

  render: function(){
    var html = this.template;
    this.$el.html(html);
    return this;
  },

});
