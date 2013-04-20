/*
 * i18n.js
 */

i18n.defaultLocale = 'de';
i18n.defaultLang = 'de';
i18n.lang = i18n.defaultLang;

sub = function (to, which, replace) {
    return to.replace("%{" + which + "}", replace);
}


i18n.translate = function (key, options) {
    var ret = i18n._trans;
    var nav = key.split('.');
    nav.unshift(i18n.lang);
    nav.forEach(function(d,i) {
        if (ret !== undefined) {
            ret = ret[d];
        }
    });
    if (ret === undefined) {
        return "translation missing [" + i18n.lang + "." + key + "]";
    }

    // pluralization feature. probably only temporary
    if (ret.constructor === Object) {
        if ("count" in options) {
            if (ret.count === 0 && "zero" in ret) { return ret.zero; }
            if (ret.count === 1 && "one" in ret) { return ret.one; }
            if ("other" in ret) { return sub(ret.other, "count", options.count); };
        }

        return "translation pointed to hash [" + i18n.lang + "." + key + "]";
    }

    if (options !== undefined) {
        text = ret
        for (k in options) {
            text = sub(text, k, options[k])
        }
        return text
    }

    return ret;
};

// took from github.com user: fnando proj: i18n-js
i18n.parseDate = function(date) {
  var matches, convertedDate;

  // we have a date, so just return it.
  if (typeof(date) == "object") {
    return date;
  };

  // it matches the following formats:
  //   yyyy-mm-dd
  //   yyyy-mm-dd[ T]hh:mm::ss
  //   yyyy-mm-dd[ T]hh:mm::ss
  //   yyyy-mm-dd[ T]hh:mm::ssZ
  //   yyyy-mm-dd[ T]hh:mm::ss+0000
  //
  matches = date.toString().match(/(\d{4})-(\d{2})-(\d{2})(?:[ T](\d{2}):(\d{2}):(\d{2}))?(Z|\+0000)?/);

  if (matches) {
    for (var i = 1; i <= 6; i++) {
      matches[i] = parseInt(matches[i], 10) || 0;
    }

    // month starts on 0
    matches[2] -= 1;

    if (matches[7]) {
      convertedDate = new Date(Date.UTC(matches[1], matches[2], matches[3], matches[4], matches[5], matches[6]));
    } else {
      convertedDate = new Date(matches[1], matches[2], matches[3], matches[4], matches[5], matches[6]);
    }
  } else if (typeof(date) == "number") {
    // UNIX timestamp
    convertedDate = new Date();
    convertedDate.setTime(date);
  } else if (date.match(/\d+ \d+:\d+:\d+ [+-]\d+ \d+/)) {
    // a valid javascript format with timezone info
    convertedDate = new Date();
    convertedDate.setTime(Date.parse(date))
  } else {
    // an arbitrary javascript string
    convertedDate = new Date();
    convertedDate.setTime(Date.parse(date));
  }

  return convertedDate;
};

i18n.localize = function(what, data, options) {
    var date = i18n.parseDate(data);
    if (options === undefined) {
        options = {};
    }
    if (what.match(/date/)) {
        var weekDay = date.getDay();
        var day = date.getDate();
        var month1 = date.getMonth() + 1;
        var year = date.getFullYear();
        
        if (options.format) {
            var text = options.format;
            text = text.replace('%d', day)
            text = text.replace('%B', i18n.t('date.abbr_month_names.' + month1))
            text = text.replace('%Y', year)
            // add more good for now ?
            return text;
        }
    }

    return 'could not loc ' + what;
};

i18n.l = i18n.localize;
i18n.t = i18n.translate;
