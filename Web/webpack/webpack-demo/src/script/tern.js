var fs = require('fs');
var _ = require('lodash');

obj.each(function (index) {
    this.innerHTML = this + " is the element, " + index + " is the position";
});
_.apply
_.parecom
$.ajaxSetup
$.get('mydomain.com/url',
    { param1: value1 },
    function (data, textStatus, jqXHR) {
        // success callback
    }
);
$.ajax({
    url: 'mydomain.com/url',
    type: 'POST',
    dataType: 'xml/html/script/json',
    data: $.param( $('Element or Expression') ),
    complete: function (jqXHR, textStatus) {
        // callback
    },
    success: function (data, textStatus, jqXHR) {
        // success callback
    },
    error: function (jqXHR, textStatus, errorThrown) {
        // error callback
    }
});
