(function() {
  'use strict';

  var globals = typeof window === 'undefined' ? global : window;
  if (typeof globals.require === 'function') return;

  var modules = {};
  var cache = {};
  var aliases = {};
  var has = ({}).hasOwnProperty;

  var expRe = /^\.\.?(\/|$)/;
  var expand = function(root, name) {
    var results = [], part;
    var parts = (expRe.test(name) ? root + '/' + name : name).split('/');
    for (var i = 0, length = parts.length; i < length; i++) {
      part = parts[i];
      if (part === '..') {
        results.pop();
      } else if (part !== '.' && part !== '') {
        results.push(part);
      }
    }
    return results.join('/');
  };

  var dirname = function(path) {
    return path.split('/').slice(0, -1).join('/');
  };

  var localRequire = function(path) {
    return function expanded(name) {
      var absolute = expand(dirname(path), name);
      return globals.require(absolute, path);
    };
  };

  var initModule = function(name, definition) {
    var hot = null;
    hot = hmr && hmr.createHot(name);
    var module = {id: name, exports: {}, hot: hot};
    cache[name] = module;
    definition(module.exports, localRequire(name), module);
    return module.exports;
  };

  var expandAlias = function(name) {
    return aliases[name] ? expandAlias(aliases[name]) : name;
  };

  var _resolve = function(name, dep) {
    return expandAlias(expand(dirname(name), dep));
  };

  var require = function(name, loaderPath) {
    if (loaderPath == null) loaderPath = '/';
    var path = expandAlias(name);

    if (has.call(cache, path)) return cache[path].exports;
    if (has.call(modules, path)) return initModule(path, modules[path]);

    throw new Error("Cannot find module '" + name + "' from '" + loaderPath + "'");
  };

  require.alias = function(from, to) {
    aliases[to] = from;
  };

  var extRe = /\.[^.\/]+$/;
  var indexRe = /\/index(\.[^\/]+)?$/;
  var addExtensions = function(bundle) {
    if (extRe.test(bundle)) {
      var alias = bundle.replace(extRe, '');
      if (!has.call(aliases, alias) || aliases[alias].replace(extRe, '') === alias + '/index') {
        aliases[alias] = bundle;
      }
    }

    if (indexRe.test(bundle)) {
      var iAlias = bundle.replace(indexRe, '');
      if (!has.call(aliases, iAlias)) {
        aliases[iAlias] = bundle;
      }
    }
  };

  require.register = require.define = function(bundle, fn) {
    if (typeof bundle === 'object') {
      for (var key in bundle) {
        if (has.call(bundle, key)) {
          require.register(key, bundle[key]);
        }
      }
    } else {
      modules[bundle] = fn;
      delete cache[bundle];
      addExtensions(bundle);
    }
  };

  require.list = function() {
    var list = [];
    for (var item in modules) {
      if (has.call(modules, item)) {
        list.push(item);
      }
    }
    return list;
  };

  var hmr = globals._hmr && new globals._hmr(_resolve, require, modules, cache);
  require._cache = cache;
  require.hmr = hmr && hmr.wrap;
  require.brunch = true;
  globals.require = require;
})();

(function() {
var global = window;
var __makeRelativeRequire = function(require, mappings, pref) {
  var none = {};
  var tryReq = function(name, pref) {
    var val;
    try {
      val = require(pref + '/node_modules/' + name);
      return val;
    } catch (e) {
      if (e.toString().indexOf('Cannot find module') === -1) {
        throw e;
      }

      if (pref.indexOf('node_modules') !== -1) {
        var s = pref.split('/');
        var i = s.lastIndexOf('node_modules');
        var newPref = s.slice(0, i).join('/');
        return tryReq(name, newPref);
      }
    }
    return none;
  };
  return function(name) {
    if (name in mappings) name = mappings[name];
    if (!name) return;
    if (name[0] !== '.' && pref) {
      var val = tryReq(name, pref);
      if (val !== none) return val;
    }
    return require(name);
  }
};

require.register("prefixed-event/lib/prefixed-event.js", function(exports, require, module) {
  require = __makeRelativeRequire(require, {}, "prefixed-event");
  (function() {
    module.exports = (function(){
'use strict';

var pfx = ["webkit", "moz", "MS", "o", ""];
function assert(pred,msg){
    if(!pred) {
        throw new Error(msg)
    }

}

function noop(){}
return {
    add: function(element, type, callback) {
        callback = (callback || noop);
        assert(element,'element is required')
        assert(type,'type is required')

        for (var p = 0; p < pfx.length; p++) {
            if (!pfx[p]) {
                type = type.toLowerCase();
            }
            element.addEventListener(pfx[p]+type, callback, false);
        }
    }
    ,remove: function(element,type,callback){
        callback = (callback || noop);
        assert(element,'element is required')
        assert(type,'type is required')
        for (var p = 0; p < pfx.length; p++) {
            if (!pfx[p]) {
                type = type.toLowerCase();
            }
            element.removeEventListener(pfx[p]+type, callback, false);
        }
    }

}

})();
  })();
});
require.register("web/static/js/app.ts", function(exports, require, module) {
"use strict";
var prefixedEvent = require('prefixed-event');
function insertAfter(newNode, referenceNode) {
    referenceNode.parentNode.insertBefore(newNode, referenceNode.nextSibling);
}
var Works = (function () {
    function Works() {
        var _this = this;
        var works = document.querySelectorAll('.work');
        for (var k = 0; k < works.length; k++) {
            works[k].addEventListener('click', function (e) {
                e.preventDefault();
                _this.showWork(e.currentTarget);
            });
        }
    }
    Works.prototype.showWork = function (elem) {
        if (elem == this.activeElement) {
            return false;
        }
        if (this.activeDetail) {
            this.hideWork();
        }
        var detail = elem.querySelector('.work-detail').cloneNode(true);
        var row = Math.ceil((parseInt(elem.getAttribute('id').replace('work', '')) + 1) / 4);
        var lastFromThisRow = document.querySelector('#work' + (row * 4 - 1));
        console.log('#work' + (row * 4 - 1));
        insertAfter(detail, lastFromThisRow);
        detail.getBoundingClientRect();
        detail.classList.add('active');
        this.activeElement = elem;
        this.activeDetail = detail;
    };
    Works.prototype.hideWork = function () {
        var detail = this.activeDetail;
        window.setTimeout(function () {
            detail.parentNode.removeChild(detail);
        }, 5000);
        detail.classList.remove('active');
    };
    return Works;
}());
var w = new Works();
//# sourceMappingURL=app.js.map
});

;require.alias("prefixed-event/lib/prefixed-event.js", "prefixed-event");require.register("___globals___", function(exports, require, module) {
  
});})();require('___globals___');

require('web/static/js/app');
//# sourceMappingURL=app.js.map