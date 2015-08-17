window.Brewcleus = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function(){
    alert("Hello from Brewcleus!");
    this.router = new Brewcleus.Routers.Router({
      $rootEl: $("#content")
    });

    this.currentUser = new Brewcleus.Models.CurrentUser();
    this.currentUser.fetch();

    this.header = new Brewcleus.Views.Header({ el: "#header" });
    this.footer = new Brewcleus.Views.Footer({ el: "#footer" });

    Backbone.history.start();
  }
}
