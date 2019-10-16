"use strict";

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

// Photoswipe Demo
// =============================================================
var PhotoswipeDemo =
/*#__PURE__*/
function () {
  function PhotoswipeDemo() {
    _classCallCheck(this, PhotoswipeDemo);

    this.init();
  }

  _createClass(PhotoswipeDemo, [{
    key: "init",
    value: function init() {
      // event handlers
      this.initPhotoSwipeFromDOM('.pswp-gallery'); // handle propagation from figure actions `a` tags

      $(document).ready(function () {
        $('.figure-action > a').on('click', function (e) {
          return e.stopPropagation();
        });
      });
    }
  }, {
    key: "initPhotoSwipeFromDOM",
    value: function initPhotoSwipeFromDOM(gallerySelector) {
      // parse slide data (url, title, size ...) from DOM elements
      // (children of gallerySelector)
      var parseThumbnailElements = function parseThumbnailElements(el) {
        var thumbElements = el.childNodes;
        var numNodes = thumbElements.length;
        var items = [];
        var figureEl;
        var linkEl;
        var size;
        var item;

        for (var i = 0; i < numNodes; i++) {
          // <figure> element
          figureEl = thumbElements[i]; // include only element nodes

          if (figureEl.nodeType !== 1) {
            continue;
          } // <a> element


          linkEl = figureEl.querySelectorAll('.img-link')[0];
          size = linkEl.getAttribute('data-size').split('x'); // create slide object

          item = {
            src: linkEl.getAttribute('href'),
            w: parseInt(size[0], 10),
            h: parseInt(size[1], 10) // img caption content

          };

          if (linkEl.children.length > 1) {
            item.title = linkEl.querySelectorAll('.img-caption')[0].innerHTML;
          } // <img> thumbnail element, retrieving thumbnail url


          if (linkEl.children.length > 0) {
            item.msrc = figureEl.querySelectorAll('img')[0].getAttribute('src');
          } // save link to element for getThumbBoundsFn


          item.el = figureEl;
          items.push(item);
        }

        return items;
      }; // find nearest parent element


      var closest = function closest(el, fn) {
        return el && (fn(el) ? el : closest(el.parentNode, fn));
      }; // triggers when user clicks on thumbnail


      var onThumbnailsClick = function onThumbnailsClick(e) {
        e = e || window.event;
        e.preventDefault ? e.preventDefault() : e.returnValue = false;
        var eTarget = e.target || e.srcElement; // find root element of slide

        var clickedListItem = closest(eTarget, function (el) {
          return el.tagName && el.tagName.toUpperCase() === 'FIGURE';
        });

        if (!clickedListItem) {
          return;
        } // find index of clicked item by looping through all child nodes
        // alternatively, you may define index via data- attribute


        var clickedGallery = clickedListItem.parentNode;
        var childNodes = clickedListItem.parentNode.parentNode.parentNode.querySelectorAll('.figure');
        var numChildNodes = childNodes.length;
        var nodeIndex = 0;
        var index;

        for (var i = 0; i < numChildNodes; i++) {
          if (childNodes[i].nodeType !== 1) {
            continue;
          }

          if (childNodes[i] === clickedListItem) {
            index = nodeIndex;
            break;
          }

          nodeIndex++;
        }

        if (index >= 0) {
          // open PhotoSwipe if valid index found
          openPhotoSwipe(index, clickedGallery);
        }

        return false;
      }; // parse picture index and gallery index from URL (#&pid=1&gid=2)


      var photoswipeParseHash = function photoswipeParseHash() {
        var hash = window.location.hash.substring(1);
        var params = {};

        if (hash.length < 5) {
          return params;
        }

        var vars = hash.split('&');

        for (var i = 0; i < vars.length; i++) {
          if (!vars[i]) {
            continue;
          }

          var pair = vars[i].split('=');

          if (pair.length < 2) {
            continue;
          }

          params[pair[0]] = pair[1];
        }

        if (params.gid) {
          params.gid = parseInt(params.gid, 10);
        }

        return params;
      };

      var openPhotoSwipe = function openPhotoSwipe(index, galleryElement, disableAnimation, fromURL) {
        var pswpElement = document.querySelectorAll('.pswp')[0];
        var gallery;
        var options;
        var items; // refer to galerySelector

        galleryElement = galleryElement.classList.contains('card-figure') ? galleryElement.parentNode.parentNode : galleryElement;
        items = parseThumbnailElements(galleryElement); // define options (if needed)

        options = {
          // define gallery index (for URL)
          galleryUID: galleryElement.getAttribute('data-pswp-uid'),
          getThumbBoundsFn: function getThumbBoundsFn(index) {
            // See Options -> getThumbBoundsFn section of documentation for more info
            var thumbnail = items[index].el.getElementsByTagName('img')[0]; // find thumbnail

            var pageYScroll = window.pageYOffset || document.documentElement.scrollTop;
            var rect = thumbnail.getBoundingClientRect();
            return {
              x: rect.left,
              y: rect.top + pageYScroll,
              w: rect.width
            };
          } // PhotoSwipe opened from URL

        };

        if (fromURL) {
          if (options.galleryPIDs) {
            // parse real index when custom PIDs are used
            // http://photoswipe.com/documentation/faq.html#custom-pid-in-url
            for (var j = 0; j < items.length; j++) {
              if (items[j].pid == index) {
                options.index = j;
                break;
              }
            }
          } else {
            // in URL indexes start from 1
            options.index = parseInt(index, 10) - 1;
          }
        } else {
          options.index = parseInt(index, 10);
        } // exit if index not found


        if (isNaN(options.index)) {
          return;
        }

        if (disableAnimation) {
          options.showAnimationDuration = 0;
        } // Pass data to PhotoSwipe and initialize it


        gallery = new PhotoSwipe(pswpElement, PhotoSwipeUI_Default, items, options);
        gallery.init();
      }; // loop through all gallery elements and bind events


      var galleryElements = document.querySelectorAll(gallerySelector);

      for (var i = 0, l = galleryElements.length; i < l; i++) {
        galleryElements[i].setAttribute('data-pswp-uid', i + 1);
        galleryElements[i].onclick = onThumbnailsClick;
      } // Parse URL and open gallery if it contains #&pid=3&gid=1


      var hashData = photoswipeParseHash();

      if (hashData.pid && hashData.gid) {
        openPhotoSwipe(hashData.pid, galleryElements[hashData.gid - 1], true, true);
      }
    }
  }]);

  return PhotoswipeDemo;
}();
/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */


$(document).on('theme:init', function () {
  new PhotoswipeDemo();
});