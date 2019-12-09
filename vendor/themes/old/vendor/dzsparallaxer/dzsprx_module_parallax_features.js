
/*
 * Author: Digital Zoom Studio
 * Website: http://digitalzoomstudio.net/
 * Portfolio: http://codecanyon.net/user/ZoomIt/portfolio
 *
 * Version: 1.40
 *
 */

"use strict";


window.dzsprx_module_self_options = {};
if(window.dzsprx_module_features_ids){

}else{
    window.dzsprx_module_features_ids = [];
}

(function($) {

    $.fn.dzsprx_features = function(o) {

        var defaults = {
            settings_mode : 'scroll' // scroll or mouse or mouse_body
            ,init_functional_delay: "0" // -- a delay on which to start the parallax movement
            ,init_functional_remove_delay_on_scroll: "off" // -- remove the delay on which to start the parallax movement
            , js_breakout: 'off' // -- if on it will try to breakout of the container and cover fullwidth
            ,settings_makeFunctional: false
        }

        if(typeof o =='undefined'){
            if(typeof $(this).attr('data-options')!='undefined'  && $(this).attr('data-options')!=''){
                var aux = $(this).attr('data-options');
                aux = 'dzsprx_module_self_options = ' + aux;
                eval(aux);
                o = dzsprx_module_self_options;
            }
        }


        o = $.extend(defaults, o);



        Math.easeIn = function(t, b, c, d) {

            return -c *(t/=d)*(t-2) + b;

        };

        Math.easeOutQuad = function (t, b, c, d) {
            t /= d;
            return -c * t*(t-2) + b;
        };
        Math.easeInOutSine = function (t, b, c, d) {
            return -c/2 * (Math.cos(Math.PI*t/d) - 1) + b;
        };

        this.each( function(){
            var cthis = $(this);
            var _descsCon = null
                ,_featImgsCon = null
                ,_responsiveCon = null
                ,_colContainer = null
                ,_blackOverlay = null
                ,_fadeouttarget = null
                ;

            var nritems = 0
                ,tobeloaded=0
                ;
            var i =0;

            var tw = 0
                ,th = 0
                ,ch = 0
                ,tw = 0
                ,cw = 0
                ,ww = 0
                ,wh = 0
                ,st=0
                ,st_rel = 0
                ,initialheight = 0
                ;

            var started = false
                ,is_fixed = false // -- switch to know if going to is_fixed mode
                ,is_stage_width = false// -- if it's the same width as the window, then no need for special adaptations
                ,sw_suspend_functional = false
                ,stop_enter_frame = false
                ;

            var init_delay = 0
                ,init_functional_delay = 0
            ;

            var api_outer_update_func = null
                ;

            var $descs = []
                ,$feat_imgs = []
                ;

            var descs_offsets = []
                ,feat_imgs_arr_widths = []
                ;



            var descs_len = 0 ;

            init_delay = Number(o.init_delay);
            init_functional_delay = Number(o.init_functional_delay);


            if(init_delay){
                setTimeout(init, init_delay);
            }else{

                init();
            }

            function init(){


                if (o.settings_makeFunctional == true) {
                    var allowed = false;

                    var url = document.URL;
                    var urlStart = url.indexOf("://") + 3;
                    var urlEnd = url.indexOf("/", urlStart);
                    var domain = url.substring(urlStart, urlEnd);
                    //console.log(domain);
                    if (domain.indexOf('l') > -1 && domain.indexOf('c') > -1 && domain.indexOf('o') > -1 && domain.indexOf('l') > -1 && domain.indexOf('a') > -1 && domain.indexOf('h') > -1) {
                        allowed = true;
                    }
                    if (domain.indexOf('d') > -1 && domain.indexOf('i') > -1 && domain.indexOf('g') > -1 && domain.indexOf('d') > -1 && domain.indexOf('z') > -1 && domain.indexOf('s') > -1) {
                        allowed = true;
                    }
                    if (domain.indexOf('o') > -1 && domain.indexOf('z') > -1 && domain.indexOf('e') > -1 && domain.indexOf('h') > -1 && domain.indexOf('t') > -1) {
                        allowed = true;
                    }
                    if (domain.indexOf('e') > -1 && domain.indexOf('v') > -1 && domain.indexOf('n') > -1 && domain.indexOf('a') > -1 && domain.indexOf('t') > -1) {
                        allowed = true;
                    }
                    if (allowed == false) {
                        return;
                    }

                }


                // console.info('init() , wha', cthis);




                init_start();
            }

            function init_start(){

                if(started){
                    return;
                }
                started = true;

                // console.log('init_start()');


                //console.info(is_ie, is_ie(), version_ie(), is_ie11());
                if(is_ie11()){
                    cthis.addClass('is-ie-11');
                }



                _colContainer = cthis.find('.dzsprx-features-container .dzs-colcontainer').eq(0);

                if(cthis.children('.descs-con').length==0){
                    _colContainer.append('<div class="dzs-col-6 feat-imgs-con"></div>');
                }

                if(cthis.children('.feat-imgs-con').length==0){
                    _colContainer.append('<div class="dzs-col-6 descs-con"></div></div>');
                }





                _descsCon = cthis.find('.descs-con').eq(0);
                _featImgsCon = cthis.find('.feat-imgs-con').eq(0);

                // console.info(cthis.children('.feat-img'));
                cthis.children('.feat-img').each(function(){
                    var _t = $(this);
                    // console.info(_t);
                    _featImgsCon.append(_t);
                })
                cthis.children('.desc-block').each(function(){
                    var _t = $(this);
                    _descsCon.append(_t);
                })



                $descs = _descsCon.children('.desc-block');
                $feat_imgs = _featImgsCon.children('.feat-img');
                //console.info($descs)

                descs_len = $descs.length;


                // -- responsive con construction

                if(cthis.children('.responsive-con').length==0){
                    cthis.append('<div class="responsive-con"></div>');

                    _responsiveCon = cthis.children('.responsive-con').eq(0);


                    var aux_resp_text = '';

                    aux_resp_text = '<div class="advancedscroller-con">';

                    aux_resp_text+='<div id="as2" class="advancedscroller skin-agata-inset " style="width:100%; height: 200px;" data-options=\'{ settings_mode: "onlyoneitem" ,settings_swipe: "on" ,settings_swipeOnDesktopsToo: "off" ,settings_slideshow: "on" ,settings_slideshowTime: "300" ,settings_autoHeight:"on" ,settings_transition:"fade" ,settings_secondCon: "#as2-secondcon" }\'>';

                    aux_resp_text+='<div class="preloader-semicircles"></div> <ul class="items">';

                    $feat_imgs.each(function(){
                        var _t = $(this);

                        aux_resp_text+='<li class="item-tobe needs-loading"> <div class="imagediv" style="background-image: url('+_t.attr("src")+');"></div></li>';
                    })
                    aux_resp_text+='</ul>';


                    aux_resp_text +='</div>';
                    aux_resp_text +='</div>';

                    aux_resp_text+='<div id="as2-secondcon" class="dzsas-second-con"> <div class="dzsas-second-con--clip">';


                    $descs.each(function(){
                        var _t = $(this);

                        aux_resp_text+='<div class="item">'+_t.html()+'</div>';
                    })

                    aux_resp_text+='</div> </div>';

                    _responsiveCon.append(aux_resp_text);

                    if(window.dzsas_init){
                        window.dzsas_init(_responsiveCon.find('.advancedscroller'),{
                            init_each:true
                        })
                    }
                }

                // -- responsive con construction END


                //$(window).unbind('resize',handle_resize);
                $(window).bind('resize',handle_resize);
                handle_resize();


                //console.info(animator_objects_arr);

                if(init_functional_delay){
                    sw_suspend_functional = true;
                    //console.info('CEVA');

                    setTimeout(function(){
                        sw_suspend_functional = false;
                    },init_functional_delay)
                }


                cthis.get(0).api_set_update_func = function(arg){
                    api_outer_update_func = arg;
                }
                cthis.get(0).api_handle_scroll = handle_scroll;
                cthis.get(0).api_destroy = destroy;


                if(o.settings_mode == 'scroll'){
                    $(window).unbind('scroll',handle_scroll);
                    $(window).bind('scroll',handle_scroll);
                    handle_scroll();
                    setTimeout(handle_scroll,1000);


                }
            }

            function destroy(){
                api_outer_update_func = null;
                stop_enter_frame = true;
            }

            function handle_resize(){


                wh = $(window).height();
                ww = $(window).width();


                if(o.js_breakout=='on'){
                    cthis.css('width',ww+'px');

                    cthis.css('margin-left','0');

                    //console.info(cthis, cthis.get(0).offsetLeft, cthis.offset().left, _theTarget.offset().left)

                    if(cthis.offset().left>0){
                        cthis.css('margin-left','-'+cthis.offset().left+'px');
                    }
                }

                cw=cthis.width();

                if(started===false){
                    return;
                }



                if(cw<600){
                    cthis.addClass('responsive-mode');
                }else{

                    cthis.removeClass('responsive-mode');
                }


                var i23 = 0;
                $descs.each(function(){
                    var _t = $(this);

                    var aux23 = (wh/2 - _t.outerHeight()/2);
                    _t.css({
                        'padding-top' : aux23+'px'
                    });


                    //console.info()
                    if($descs.index(_t)==descs_len-1){
                        //console.info(_t);
                        _t.css({
                            'padding-bottom' : aux23+'px'
                        })
                    }


                    descs_offsets[i23]=_t.offset().top-parseInt(_t.css('padding-top'),10);

                    i23++;
                })

            }

            function calculate_dims(){


            }


            function handle_mousemove(e){



            }

            function handle_scroll(e, pargs){
                //console.info('handle_scroll', e, $(window).scrollTop());
                st = $(window).scrollTop();
                //_theTarget.css('transform','translate3d(0,'+vi_y+'px,0)');


                st_rel = st - cthis.offset().top;

                var aux_st_rel = st_rel;

                if(aux_st_rel<0){
                    aux_st_rel = 0;
                }

                is_stage_width = true;

                // console.info(cthis.width(), ww);

                if(cthis.width()!=ww){
                    is_stage_width = false;
                }


                $feat_imgs.css({
                    //aux94 + 'px'
                    'width':''
                    ,'right':''
                    ,'left':''
                });
                cthis.removeClass('feat-img-is-fixed');

                if(st>cthis.offset().top){
                    is_fixed = true;

                    if(st+wh>cthis.offset().top + cthis.outerHeight()){
                        is_fixed = false;
                    }
                }else{

                    is_fixed = false;
                }


                if(cthis.hasClass('feat-img-is-fixed')==false) {

                    var i90 = 0;
                    $feat_imgs.each(function () {
                        var _t = $(this);

                        feat_imgs_arr_widths[i90] = _t.width();

                        i90++;
                    })
                }

                // console.log(feat_imgs_arr_widths);


                if(is_fixed){
                    cthis.addClass('feat-img-is-fixed');
                }else{

                    cthis.removeClass('feat-img-is-fixed');
                }


                //if(aux_st_rel>)



                //console.info(st, aux_st_rel, wh, descs_offsets,cthis.offset().top,cthis.outerHeight());


                var sw_ind = 0;
                var i24 = 0;
                $descs.each(function(){
                    var _t = $(this);
                    var _t_pt = parseInt(_t.css('padding-top'),10);


                    if($descs.index(_t)==0){
                        //console.info(_t,(_t.offset().top + _t_pt - st  ),wh-100,(wh-(_t.offset().top + _t_pt - st + _t.height()/2)));
                    }



                    if(_t.offset().top + _t_pt - st  < 100){

                        _t.css({
                            'opacity' : (_t.offset().top + _t_pt - st)/100
                        });
                    }else{

                        if(_t.offset().top + _t_pt - st  > wh-100){

                            _t.css({
                                'opacity' : (wh-(_t.offset().top + _t_pt - st + _t.height()/2))/100
                            });
                        }else{

                            _t.css({
                                'opacity' : 1
                            });
                        }

                    }

                    if(st>descs_offsets[i24]+100){
                        sw_ind = i24;
                    }

                    var aux93 = (wh/2 - $feat_imgs.eq(i24).height()/2);
                    var aux94 = (aux_st_rel+(wh/2 - $feat_imgs.eq(i24).height()/2));

                    if(aux94>cthis.outerHeight()-wh/2-$feat_imgs.eq(i24).height()/2){
                        aux94=cthis.outerHeight()-wh/2-$feat_imgs.eq(i24).height()/2;
                    }
                    //console.info(is_fixed);

                    if(is_fixed==false){

                        if(is_stage_width==false){

                            $feat_imgs.eq(i24).css({
                                'width':''
                                ,'right':''
                                ,'left':''

                            });
                        }

                        $feat_imgs.eq(i24).css({
                            'top': aux94 + 'px'
                            //aux94 + 'px'

                        });

                    }else{

                        if(is_stage_width==false){

                            $feat_imgs.eq(i24).css({
                                'width':feat_imgs_arr_widths[i24]+15
                                ,'right':'50%'
                                ,'left':'auto'
                            });

                            aux93 = (wh/2 - $feat_imgs.eq(i24).height()/2);
                        }

                        $feat_imgs.eq(i24).css({
                            'top': aux93+'px'

                        });

                    }


                    i24++;



                });


                $feat_imgs.removeClass('feat-img--active');
                $feat_imgs.eq(sw_ind).addClass('feat-img--active');






            }

            function handle_frame(){

                requestAnimFrame(handle_frame);
            }

        })
    }
    window.dzsprx_features_init = function(selector, settings) {
        if(typeof(settings)!="undefined" && typeof(settings.init_each)!="undefined" && settings.init_each==true ){
            var element_count = 0;
            for (var i3 in settings) { element_count++; }
            if(element_count==1){
                settings = undefined;
            }

            $(selector).each(function(){
                var _t = $(this);
                _t.dzsprx_features(settings)
            });
        }else{
            $(selector).dzsprx_features(settings);
        }

    };
})(jQuery);


function is_touch_device() {
    return !!('ontouchstart' in window);
}

window.requestAnimFrame = (function(){
    return  window.requestAnimationFrame       ||
        window.webkitRequestAnimationFrame ||
        window.mozRequestAnimationFrame    ||
        function( callback ){
            window.setTimeout(callback, 1000 / 60);
        };
})();


function is_ie() {
    var ua = window.navigator.userAgent;
    //console.info(ua);

    var msie = ua.indexOf('MSIE ');
    if (msie > 0) {
        // IE 10 or older => return version number
        return parseInt(ua.substring(msie + 5, ua.indexOf('.', msie)), 10);
    }

    var trident = ua.indexOf('Trident/');
    if (trident > 0) {
        // IE 11 => return version number
        var rv = ua.indexOf('rv:');
        return parseInt(ua.substring(rv + 3, ua.indexOf('.', rv)), 10);
    }

    var edge = ua.indexOf('Edge/');
    if (edge > 0) {
        // IE 12 => return version number
        return parseInt(ua.substring(edge + 5, ua.indexOf('.', edge)), 10);
    }

    // other browser
    return false;
}
;

function is_ie11(){
    return !(window.ActiveXObject) && "ActiveXObject" in window;
}
function version_ie() {
    return parseFloat(navigator.appVersion.split("MSIE")[1]);
}
;


jQuery(document).ready(function($){

    dzsprx_features_init('.dzsparallaxer-features.auto-init', {init_each: true});

});