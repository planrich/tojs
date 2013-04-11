/*
 * i18n.js
 */

i18n.defaultLocale = 'de';
i18n.defaultLang = 'de';
i18n.lang = i18n.defaultLang;

i18n.translate = function (key, options) {
    var ret = i18n._trans;
    var nav = key.split('.');
    nav.unshift(i18n.lang);
    nav.forEach(function(d,i) {
        ret = ret[d];
    });
    if (ret === undefined) {
        return "translation missing [" + i18n.lang + "." + key + "]";
    }
    return ret;
};
