// Generated by CoffeeScript 1.7.1
(function() {
  var Memo, memo,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  Memo = (function() {
    function Memo() {
      this._fireChange = __bind(this._fireChange, this);
      this._storageKeyEventListeners = {};
    }

    Memo.prototype.set = function(key, value) {
      var serializedValue;
      if (value !== void 0) {
        serializedValue = JSON.stringify(value);
        window.localStorage[key] = serializedValue;
        return value;
      }
    };

    Memo.prototype.get = function(key) {
      var value;
      if (value = localStorage[key]) {
        return this._parseJSONSilently(value);
      } else {
        return null;
      }
    };

    Memo.prototype.keys = function() {
      return Object.keys(localStorage);
    };

    Memo.prototype["delete"] = function(key) {
      return localStorage.removeItem(key);
    };

    Memo.prototype.clear = function() {
      return localStorage.clear();
    };

    Memo.prototype.all = function() {
      var object;
      object = {};
      this.keys().map((function(_this) {
        return function(key) {
          return object[key] = _this.get(key);
        };
      })(this));
      return object;
    };

    Memo.prototype.addListener = function(key, handler) {
      var handlers;
      if (handlers = this._storageKeyEventListeners[key]) {
        return handlers.push(handler);
      } else {
        return this._storageKeyEventListeners[key] = [handler];
      }
    };

    Memo.prototype._fireChange = function(storageEvent) {
      var eventObject, listener, listeners, _i, _len, _results;
      if (!(this._listenersForEvent(storageEvent) && this._storageValueChanged(storageEvent))) {
        return;
      }
      listeners = this._listenersForEvent(storageEvent) || [];
      eventObject = {
        key: storageEvent.key,
        oldValue: this._parseJSONSilently(storageEvent.oldValue),
        newValue: this._parseJSONSilently(storageEvent.newValue),
        url: storageEvent.url
      };
      _results = [];
      for (_i = 0, _len = listeners.length; _i < _len; _i++) {
        listener = listeners[_i];
        _results.push(listener(eventObject));
      }
      return _results;
    };

    Memo.prototype._listenersForEvent = function(storageEvent) {
      return this._storageKeyEventListeners[storageEvent.key];
    };

    Memo.prototype._storageValueChanged = function(storageEvent) {
      return storageEvent.oldValue !== storageEvent.newValue;
    };

    Memo.prototype._parseJSONSilently = function(jsonString) {
      var error;
      try {
        return JSON.parse(jsonString);
      } catch (_error) {
        error = _error;
        return jsonString;
      }
    };

    return Memo;

  })();

  memo = new Memo;

  window.addEventListener('storage', memo._fireChange, false);

  window.memo = memo;

}).call(this);
