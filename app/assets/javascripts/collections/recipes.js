Brewcleus.Collections.Recipes = Backbone.Collection.extend({

  model: Brewcleus.Models.Recipe,

  url: "/api/recipes",

  getOrFetch: function(id){
    var mod = this.get(id);

    var mods = this;

    if (mod){
      mod.fetch();
    } else {
      mod = new this.model({id: id});
      mod.fetch({
        success: function(){
          mods.add(mod);
        }
      });
    };
    return mod;
  },

  pickRandom: function(num){
    var method = "GET";
    var collection = this;
    var resp = $.ajax({
      url: ("/api/recipes/random/" + num),
      type: method,
      processData: false,
      contentType: false,
      success: function(resp){
        collection.set(resp, {parse: true});
        collection.trigger("sync");
      }
    });
    return collection
  }

});
