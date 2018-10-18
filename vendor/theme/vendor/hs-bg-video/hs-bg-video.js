var hsYTPlayers = {},
  hsVimeoPlayers = {},
  hsYTInit = (function () {
    var onReady_funcs = [],
      api_isReady = false;

    return function (func, b_before) {
      if (func === true) {
        api_isReady = true;
        for (var i = 0; i < onReady_funcs.length; i++) {
          onReady_funcs.shift()();
        }
      }
      else if (typeof func == "function") {
        if (api_isReady) func();
        else onReady_funcs[b_before ? "unshift" : "push"](func);
      }
    }
  })(),
  hsVimeoInit = (function () {
    var onReady_funcs = [],
      api_isReady = false;

    return function (func, b_before) {
      if (func === true) {
        api_isReady = true;
        for (var i = 0; i < onReady_funcs.length; i++) {
          onReady_funcs.shift()();
        }
      }
      else if (typeof func == "function") {
        if (api_isReady) func();
        else onReady_funcs[b_before ? "unshift" : "push"](func);
      }
    }
  })();

$.fn.hsBgVideo = function (options) {
  hsYTAPICreate();
  hsVimeoAPICreate();

  var YTVideo = $('[data-hs-bgv-type="youtube"]'),
    VimeoVideo = $('[data-hs-bgv-type="vimeo"]'),
    defaultVideo = $(this);

  if (YTVideo.length) {
    YTVideo.each(function (i) {
      var $this = $(this),
        ID = $this.data('hs-bgv-id'),
        loop = $this.data('hs-bgv-loop') ? 1 : 0,
        preview = $('<div class="hs-video-preview" style="background-image: url(//img.youtube.com/vi/' + ID + '/maxresdefault.jpg);"></div>');

      $this
        .css('position', 'relative')
        .prepend(preview)
        .prepend('<div id="hsYTPlayer' + i + '" class="hs-youtube hs-bg-video" data-hs-bgv-id="' + ID + '" data-hs-bgv-loop="' + loop + '"></div>');
    });

    hsYTInit(function () {
      if (/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) return;

      $('.hs-youtube').each(function (i) {
        var ID = $(this).attr('id'),
          videoID = $(this).data('hs-bgv-id'),
          loop = $(this).data('hs-bgv-loop') ? 1 : 0;

        return hsYTPlayers[i] = new YT.Player(ID, {
          videoId: videoID,
          playerVars: {
            autoplay: 1,
            controls: 0,
            showinfo: 0,
            enablejsapi: 1,
            modestbranding: 1,
            iv_load_policy: 3,
            loop: loop,
            playlist: videoID
          },
          events: {
            'onReady': hsYTReady,
            'onStateChange': hsYTPlay
          }
        });
      });
    });
  }

  if (VimeoVideo.length) {
    VimeoVideo.each(function (i) {
      var $this = $(this),
        ID = $this.data('hs-bgv-id'),
        loop = $this.data('hs-bgv-loop') ? 1 : 0;

      function getComputerName() {
        $.getJSON('//www.vimeo.com/api/v2/video/' + ID + '.json?callback=?', function (data) {
          var preview = data[0].thumbnail_large;

          $this.prepend('<div class="hs-video-preview" style="background-image: url(' + preview + ');"></div>');
        });
      }

      getComputerName();

      $this
        .css('position', 'relative')
        .prepend('<div id="hsVimeoPlayer' + i + '" class="hs-vimeo hs-bg-video" data-hs-bgv-id="' + ID + '" data-hs-bgv-loop="' + loop + '"></div>');
    });

    hsVimeoInit(function () {
      if (/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) return;

      $('.hs-vimeo').each(function (i) {
        var ID = $(this).attr('id'),
          videoID = $(this).data('hs-bgv-id'),
          loop = $(this).data('hs-bgv-loop') ? 1 : 0;

        hsVimeoPlayers[i] = new Vimeo.Player(ID, {
          id: videoID,
          loop: loop,
          title: false,
          portrait: false,
          byline: false,
          autoplay: true,
          autopause: false
        });

        hsVimeoPlayers[i].setVolume(0);

        hsVimeoPlayers[i].play().then(function () {
          var thisW = hsVimeoPlayers[i].element.width,
            thisH = hsVimeoPlayers[i].element.height,
            ratio = thisW / thisH;

          ratioCalc(hsVimeoPlayers[i].element, ratio);

          $(window).resize(function () {
            ratioCalc(hsVimeoPlayers[i].element, ratio);
          });

          $('*').on('blur change click dblclick error focus focusin focusout hover keydown keypress keyup load mousedown mouseenter mouseleave mousemove mouseout mouseover mouseup resize scroll select submit', function () {
            ratioCalc(hsVimeoPlayers[i].element, ratio);
          });

          setTimeout(function () {
            $('#' + ID).prev().fadeOut(400);
          }, 3000);
        });
      });
    });
  }

  if (defaultVideo.length) {
    defaultVideo.not('[data-hs-bgv-type]').each(function () {
      var $this = $(this),
        path = $this.data('hs-bgv-path'),
        loop = $this.data('hs-bgv-loop') ? 'loop ' : '',
        template = '<video ' +
          'class="hs-html5 hs-bg-video"' +
          ' poster="" autoplay muted ' + loop + '>' +
          '<source src="' + path + '.mp4" type="video/mp4">' +
          '<source src="' + path + '.webm" type="video/webm">' +
          '<source src="' + path + '.ogv" type="video/ogg">' +
          'Your browser doesn\'t support HTML5 video.' +
          '</video>';

      $this
        .css('position', 'relative')
        .prepend(template);
    });
  }
};

//Ratio
function ratioCalc(target, ratio) {
  var windW = window.innerWidth,
    containerH = $(target).parents('[data-hs-bgv-id]').outerHeight(),
    containerW = $(target).parent('[data-hs-bgv-id]').outerWidth(),
    newW = ratio * containerH,
    newH = ratio * containerW;


  if (containerH > containerW) {
    $(target).css({
      'width': newW,
      'height': '130%'
    });
  } else {
    $(target).css({
      'width': newH,
      'height': windW > 1600 ? newH * .4 : newW
    });
  }
}

//YouTube
function hsYTAPICreate() {
  if ($('[data-hs-bgv-type="youtube"]').length) {
    var script = document.createElement('script');
    script.src = '//www.youtube.com/player_api';

    var before = document.getElementsByTagName('script')[0];
    before.parentNode.insertBefore(script, before);
  }
}

function hsYTReady(e) {
  e.target.mute();

  var thisW = e.target.a.width,
    thisH = e.target.a.height,
    ratio = thisW / thisH;

  ratioCalc(e.target.a, ratio);

  $(window).resize(function () {
    ratioCalc(e.target.a, ratio);
  });

  $('*').on('blur change click dblclick error focus focusin focusout hover keydown keypress keyup load mousedown mouseenter mouseleave mousemove mouseout mouseover mouseup resize scroll select submit', function () {
    ratioCalc(e.target.a, ratio);
  });
}

function hsYTPlay(e) {
  if (e.data == YT.PlayerState.PLAYING) {
    setTimeout(function () {
      $(e.target.a).next().fadeOut(400);
    }, 3000);
  }
}

function onYouTubePlayerAPIReady() {
  hsYTInit(true);
}

//Vimeo
function hsVimeoAPICreate() {
  if ($('[data-hs-bgv-type="vimeo"]').length) {
    var script = document.createElement('script');
    script.src = '//player.vimeo.com/api/player.js';

    var before = document.getElementsByTagName('script')[0];
    before.parentNode.insertBefore(script, before);
  }
}

hsVimeoInit(true);