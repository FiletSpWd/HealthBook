// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery3
//= require interactjs
//= require popper
//= require bootstrap
//= require_tree .

var dragMoveListener;

dragMoveListener = function(event) {
  var target, x, y;
  target = event.target;
  x = (parseFloat(target.getAttribute('data-x')) || 0) + event.dx;
  y = (parseFloat(target.getAttribute('data-y')) || 0) + event.dy;
  target.style.webkitTransform = target.style.transform = 'translate(' + x + 'px, ' + y + 'px)';
  target.setAttribute('data-x', x);
  return target.setAttribute('data-y', y);
};

window.dragMoveListener = dragMoveListener;

interact('.drag-drop').draggable({
  inertia: false,
  autoScroll: false,
  onmove: dragMoveListener,
  onend: function (event) {
    var textEl = event.target.querySelector('p');

    textEl && (textEl.textContent =
      'moved a distance of '
      + (Math.sqrt(Math.pow(event.pageX - event.x0, 2) +
                   Math.pow(event.pageY - event.y0, 2) | 0))
          .toFixed(2) + 'px');
  }
});

var ingredients = [];

interact('#have_ingredients').dropzone({
  accept: '.drag-drop',
  overlap: 0.75,

  ondropactivate: function(event) {},

  ondragenter: function(event) {
    event.target.classList.add('drop-target');
    event.relatedTarget.classList.add('can-drop');
    ingredients.push(event.relatedTarget.attributes['data-ingredient'].value);
    return $.get(event.relatedTarget.attributes['data-url'].value, { ingredients: ingredients });
  },

  ondragleave: function(event) {
    event.target.classList.remove('drop-target');
    event.relatedTarget.classList.remove('can-drop');
    ingredients = jQuery.grep(ingredients, function(value) {
      return value != event.relatedTarget.attributes['data-ingredient'].value;
    });
    return $.get(event.relatedTarget.attributes['data-url'].value, { ingredients: ingredients });
  },

  ondrop: function(event) {},

  ondropdeactivate: function(event) {
    event.target.classList.remove('drop-active');
    return event.target.classList.remove('drop-target');
  }
});