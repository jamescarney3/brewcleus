Brewcleus.Collections.Batches = Backbone.Collection.extend({

  model: Brewcleus.Models.Batch,

  url: "/api/batches",

  getOrFetch: function(id, callback){
    var mod = this.get(id);

    var mods = this;

    if (mod){
      mod.fetch();
      callback(mod);
    } else {
      mod = new this.model({id: id});
      mod.fetch({
        success: function(){
          mods.add(mod);
          callback(mod);
        }
      });
    };
    return mod;
  }

});
