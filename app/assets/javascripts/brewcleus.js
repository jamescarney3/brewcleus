window.Brewcleus = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function(){
    alert("Hello from Brewcleus!");
    this.header = new Brewcleus.Views.Header({ el: "#header" });
    this.footer = new Brewcleus.Views.Footer({ el: "#footer" });
  }
}
