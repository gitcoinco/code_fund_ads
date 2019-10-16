
/*
 * Author: Digital Zoom Studio
 * Website: http://digitalzoomstudio.net/
 * Portfolio: http://codecanyon.net/user/ZoomIt/portfolio
 *
 * Version: 2.63
 *
 */

"use strict";

window.dzsprx_self_options = {};
window.dzsprx_index = 0;

(function($) {

    $.fn.dzsparallaxer = function(o) {

        var defaults = {
            settings_mode : 'scroll' // scroll or mouse or mouse_body or oneelement
            , mode_scroll : 'normal' // -- normal or fromtop
            , easing : 'easeIn' // -- easeIn or easeOutQuad or easeInOutSine
            , animation_duration : '20' // -- animation duration in ms
            , direction: 'normal' // -- normal or reverse
            , js_breakout: 'off' // -- if on it will try to breakout of the container and cover fullwidth
            , breakout_fix: 'off' // -- if you are using a div breakout this will add classes and tagnames back
            , is_fullscreen: 'off' // -- if this is fullscreen parallaxer, then we can just follow
            ,settings_movexaftermouse: "off" // -- if on the parallax will move after the mouse
            ,animation_engine: "js" // -- js or css
            ,init_delay: "0" // -- a delay on which to start the init function
            ,init_functional_delay: "0" // -- a delay on which to start the parallax movement
            ,settings_substract_from_th: 0 // -- if you only want to show some part of the image you can substract pixels from the total height
            ,settings_detect_out_of_screen: true // -- detect if the parallax is outside the viewable area and not animate handleframe
            ,init_functional_remove_delay_on_scroll: "off" // -- remove the delay on which to start the parallax movement
            ,settings_makeFunctional: false
            ,settings_scrollTop_is_another_element_top: null // -- an object on which the scroll is actually simulated into an elements top position

            ,settings_clip_height_is_window_height: false // -- replace the clip height to the window height
            ,settings_listen_to_object_scroll_top: null // -- replace the scroll top listening with a value from the outside
            ,settings_mode_oneelement_max_offset : '20'
            ,simple_parallaxer_convert_simple_img_to_bg_if_possible:"on"
        }

        if(typeof o =='undefined'){
            if(typeof $(this).attr('data-options')!='undefined'  && $(this).attr('data-options')!=''){
                var aux = $(this).attr('data-options');
                aux = 'window.dzsprx_self_options = ' + aux;
                eval(aux);
                o = $.extend({},window.dzsprx_self_options);
                window.dzsprx_self_options = $.extend({},{});
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

        o.settings_mode_oneelement_max_offset = parseInt(o.settings_mode_oneelement_max_offset,10);
        var simple_parallaxer_max_offset = parseInt(o.settings_mode_oneelement_max_offset,10);

        this.each( function(){
            var cthis = $(this);
            var _theTarget = null
                ,_theTargetClone = null // -- only for horizontal
                ,_blackOverlay = null
                ,_fadeouttarget = null
            ;

            var cthis_index = window.dzsprx_index++;

            var nritems = 0
                ,tobeloaded=0
            ;
            var i =0;

            var tw = 0 // -- target width
                ,th = 0
                ,ch = 0
                ,cw = 0 // -- clip width
                ,ww = 0
                ,wh = 0
                ,nw = 0 // -- natural width
                ,nh = 0
                ,last_wh = 0 // -- compare to the last known last wh
                ,last_cthis_ot = 0 // -- compare to the last known last wh
                ,initialheight = 0
            ;

            var int_calculate_dims = 0;


            // Starting time and duration.

            // Starting Target, Begin, Finish & Change
            // --- easing params

            var duration_viy = 0
            ;

            var target_viy = 0
                ,target_vix = 0
                ,target_bo = 0
            ;

            var begin_viy = 0
                ,begin_vix = 0
                ,begin_bo = 0
            ;

            var finish_viy = 0
                ,finish_vix = 0
                ,finish_bo = 0
            ;

            var change_viy = 0
                ,change_vix = 0
                ,change_bo = 0
            ;

            var backup_duration_viy = 0
            var api_outer_update_func = null
                ,_scrollTop_is_another_element_top = null
            ;


            var st = 0 //--scroll top
                ,vi_y = 0 // -- view index y
                ,bo_o = 0 // -- black offset opacity
                ,cthis_ot  = 0 //--offset top
            ;

            var lazyloading_setsource = '';

            var started = false
                ,debug_var = false
            ;

            var animator_objects_arr = null;

            var stop_enter_frame = false
                ,sw_suspend_functional = false
                ,sw_stop_enter_frame = false
                ,destroyed = false
                ,sw_out_of_display = false

            ;

            var init_delay = 0
                ,init_functional_delay = 0
            ;

            var inter_debug_func=0
                ,inter_suspend_enter_frame = 0
                ,inter_scroll_from_resize = 0
                ,inter_recheck_dims = 0
            ;

            // -- some rresponsive scaling options

            var responsive_reference_width = 0
                ,responsive_optimal_height = 0
            ;

            var parallaxer_aftermouse_elements = [];

            var _loadTarget = null; // -- new image()
            var _loadTarget_src = '';


            init_delay = Number(o.init_delay);
            init_functional_delay = Number(o.init_functional_delay);


            if(init_delay){
                setTimeout(init, init_delay);
            }else{

                init();
            }

            function init(){


                //console.warn('init()',cthis);
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


                if(o.settings_scrollTop_is_another_element_top){
                    _scrollTop_is_another_element_top = o.settings_scrollTop_is_another_element_top;
                }



                _theTarget = cthis.find('.dzsparallaxer--target').eq(0);
                if(cthis.find('.dzsparallaxer--blackoverlay').length>0){
                    _blackOverlay = cthis.find('.dzsparallaxer--blackoverlay').eq(0);
                }
                if(cthis.find('.dzsparallaxer--fadeouttarget').length>0){
                    _fadeouttarget = cthis.find('.dzsparallaxer--fadeouttarget').eq(0);
                }
                if(cthis.find('.dzsparallaxer--aftermouse').length){
                    cthis.find('.dzsparallaxer--aftermouse').each(function(){
                        var _t = $(this);

                        parallaxer_aftermouse_elements.push(_t);
                    })
                }

                // console.info(parallaxer_aftermouse_elements);

                if(!cthis.hasClass('wait-readyall')){
                    setTimeout(function(){
                        duration_viy = Number(o.animation_duration);
                    },300);
                }

                cthis.addClass('mode-'+o.settings_mode);
                cthis.addClass('animation-engine-'+o.animation_engine);

                //console.info(cthis,_theTarget, o);


                //console.info(duration_viy);

                //console.info(cthis,_theTarget,_blackOverlay, o);


                ch = cthis.height();
                if(o.settings_movexaftermouse=='on'){
                    cw = cthis.width();
                }


                if(_theTarget){
                    th = _theTarget.height();
                    if(o.settings_movexaftermouse=='on'){
                        tw = _theTarget.width();
                    }
                }
                if(o.settings_substract_from_th){
                    th-= o.settings_substract_from_th;
                }


                //console.info(cthis,ch);


                initialheight = ch;

                if(o.breakout_fix=='2'){
                    console.info(cthis.prev());
                }

                if(cthis.attr('data-responsive-reference-width')){
                    responsive_reference_width = Number(cthis.attr('data-responsive-reference-width'));
                }
                if(cthis.attr('data-responsive-optimal-height')){
                    responsive_optimal_height = Number(cthis.attr('data-responsive-optimal-height'));
                }

                //console.log(cthis, responsive_reference_width, responsive_optimal_height);


                //console.info(is_touch_device());

                if(cthis.find('.dzsprxseparator--bigcurvedline').length){

                    cthis.find('.dzsprxseparator--bigcurvedline').each(function(){
                        var _t2 = $(this);

                        var color = "#FFFFFF";

                        if(_t2.attr('data-color')){
                            color = _t2.attr('data-color');
                        }

                        var aux = '<svg class="display-block" width="100%"  viewBox="0 0 2500 100" preserveAspectRatio="none" ><path class="color-bg" fill="'+color+'" d="M2500,100H0c0,0-24.414-1.029,0-6.411c112.872-24.882,2648.299-14.37,2522.026-76.495L2500,100z"/></svg>';


                        _t2.append(aux);

                    });

                }

                if(cthis.find('.dzsprxseparator--2triangles').length){




                    cthis.find('.dzsprxseparator--2triangles').each(function(){
                        var _t2 = $(this);

                        var color = "#FFFFFF";

                        if(_t2.attr('data-color')){
                            color = _t2.attr('data-color');
                        }

                        var aux = '<svg class="display-block" width="100%"  viewBox="0 0 1500 100" preserveAspectRatio="none" ><polygon class="color-bg" fill="'+color+'" points="1500,100 0,100 0,0 750,100 1500,0 "/></svg>';


                        _t2.append(aux);

                    });


                }

                if(cthis.find('.dzsprxseparator--triangle').length){





                    cthis.find('.dzsprxseparator--triangle').each(function(){
                        var _t2 = $(this);

                        var color = "#FFFFFF";

                        if(_t2.attr('data-color')){
                            color = _t2.attr('data-color');
                        }

                        var aux = '<svg class="display-block" width="100%"  viewBox="0 0 2200 100" preserveAspectRatio="none" ><polyline class="color-bg" fill="'+color+'" points="2200,100 0,100 0,0 2200,100 "/></svg>';


                        _t2.append(aux);

                    });



                }


                if(cthis.get(0)){
                    cthis.get(0).api_set_scrollTop_is_another_element_top = function(arg){
                        //console.info('actually!! api_set_scrollTop_is_another_element_top', arg);
                        _scrollTop_is_another_element_top = arg;
                    }
                }


                if(o.settings_mode == 'horizontal') {

                    _theTarget.wrap('<div class="dzsparallaxer--target-con"></div>');

                    if(o.animation_duration!='20'){
                        cthis.find('.horizontal-fog,.dzsparallaxer--target').css({
                            'animation':'slideshow '+(Number(o.animation_duration)/1000)+'s linear infinite'
                        })
                    }
                }
                // console.info('is_touch_device - ', is_touch_device());

                if(is_touch_device()){
                    cthis.addClass('is-touch');
                }
                if(is_mobile()){
                    cthis.addClass('is-mobile');
                }

                if(cthis.find('.divimage').length>0 || cthis.find('img').length>0){
                    var _loadTarget = cthis.children('.divimage, img').eq(0);
                    if(_loadTarget.length==0){
                        _loadTarget = cthis.find('.divimage, img').eq(0);
                    }
                    //console.info(_loadTarget.attr('data-src'));

                    if(_loadTarget.attr('data-src')){
                        lazyloading_setsource = _loadTarget.attr('data-src');
                        $(window).on('scroll.dzsprx'+cthis_index,handle_scroll);
                        handle_scroll();

                    }else{
                        init_start();
                    }
                }else{

                    init_start();
                }



                if(o.settings_mode == 'horizontal') {


                    _theTarget.before(_theTarget.clone());
                    _theTarget.prev().addClass('cloner');
                    _theTargetClone = _theTarget.parent().find('.cloner').eq(0);
                }

            }

            function init_start(){

                if(started){
                    return;
                }
                started = true;

                //console.info(is_ie, is_ie(), version_ie(), is_ie11());
                if(is_ie11()){
                    cthis.addClass('is-ie-11');
                }



                //$(window).unbind('resize',handle_resize);
                $(window).on('resize',handle_resize);
                handle_resize();

                inter_recheck_dims = setInterval(function(){
                    handle_resize(null, {
                        'call_from': 'autocheck'
                    })
                },2000);

                if(cthis.hasClass('wait-readyall')){
                    setTimeout(function(){
                        handle_scroll();
                    },700);
                }

                setTimeout(function(){
                    cthis.addClass('dzsprx-readyall');
                    handle_scroll();

                    if(cthis.hasClass('wait-readyall')) {
                        duration_viy = Number(o.animation_duration);
                    }
                },1000);

                if(cthis.find('*[data-parallaxanimation]').length>0) {
                    cthis.find('*[data-parallaxanimation]').each(function () {
                        var _t = $(this);
                        //console.info(_t);

                        if(_t.attr('data-parallaxanimation')){
                            if(animator_objects_arr==null){
                                animator_objects_arr = [];
                            }

                            animator_objects_arr.push(_t);


                            var aux = _t.attr('data-parallaxanimation');
                            aux = 'window.aux_opts2 = ' + aux;
                            aux = aux.replace(/'/g, '"')
                            // console.info(aux);
                            try {
                                eval(aux);
                            }
                            catch(err) {
                                console.info(aux, err);
                                window.aux_opts2=null;
                            }
                            //console.info(aux_opts2);

                            if(window.aux_opts2){
                                for(i=0;i<window.aux_opts2.length;i++){
                                    if(isNaN(Number(window.aux_opts2[i].initial))==false){
                                        window.aux_opts2[i].initial = Number(window.aux_opts2[i].initial);
                                    }
                                    if(isNaN(Number(window.aux_opts2[i].mid))==false){
                                        window.aux_opts2[i].mid = Number(window.aux_opts2[i].mid);
                                    }
                                    if(isNaN(Number(window.aux_opts2[i].final))==false){
                                        window.aux_opts2[i].final = Number(window.aux_opts2[i].final);
                                    }
                                }
                                _t.data('parallax_options', window.aux_opts2);
                                //console.info(_t, _t.data('parallax_options'));
                            }

                        }

                    });
                }

                //console.info(animator_objects_arr);

                if(init_functional_delay){
                    sw_suspend_functional = true;
                    //console.info('CEVA');

                    setTimeout(function(){
                        sw_suspend_functional = false;
                    },init_functional_delay)
                }


                if(!cthis.hasClass('simple-parallax')){
                    handle_frame();
                }else{
                    _theTarget.wrap('<div class="simple-parallax-inner"></div>');


                    if(o.simple_parallaxer_convert_simple_img_to_bg_if_possible=='on' && _theTarget.attr('data-src') && _theTarget.children().length==0){
                        _theTarget.parent().addClass('is-image');
                    }



                    if(simple_parallaxer_max_offset>0){
                        handle_frame();
                    }
                }

                inter_debug_func = setInterval(debug_func, 1000);


                setTimeout(function(){
                    //finish.y = -300;
                }, 1500);


                if(cthis.hasClass('use-loading')){
                    if(cthis.find('.divimage').length>0 || cthis.children('img').length>0){
                        if(cthis.find('.divimage').length>0){
                            if(lazyloading_setsource){
                                cthis.find('.divimage').eq(0).css('background-image','url('+lazyloading_setsource+')');
                                cthis.find('.dzsparallaxer--target-con .divimage').css('background-image','url('+lazyloading_setsource+')');
                            }
                            _loadTarget_src = (String(cthis.find('.divimage').eq(0).css('background-image')).split('"'))[1];
                            if(_loadTarget_src == undefined){
                                _loadTarget_src = (String(cthis.find('.divimage').eq(0).css('background-image')).split('url('))[1];
                                _loadTarget_src = (String(_loadTarget_src).split(')'))[0];
                            }
                            _loadTarget = new Image();

                            //console.info(cthis.find('.divimage').eq(0).css('background-image'), _loadTarget_src);

                            _loadTarget.onload = function(e){
                                init_loaded();
                            };





                            //console.info('_loadTarget_src - ',_loadTarget_src);
                            _loadTarget.src = _loadTarget_src;

                        }
                    }else{

                        cthis.addClass('loaded');
                    }

                    setTimeout(function(){
                        cthis.addClass('loaded');
                        calculate_dims();
                    }, 10000)
                }

                //console.info(_theTarget);





                cthis.get(0).api_set_update_func = function(arg){
                    api_outer_update_func = arg;
                }
                cthis.get(0).api_handle_scroll = handle_scroll;
                cthis.get(0).api_destroy = destroy;
                cthis.get(0).api_destroy_listeners = destroy_listeners;
                cthis.get(0).api_handle_resize = handle_resize;


                if(o.settings_mode == 'scroll' || o.settings_mode=='oneelement'){
                    $(window).off('scroll.dzsprx'+cthis_index);
                    $(window).on('scroll.dzsprx'+cthis_index,handle_scroll);
                    handle_scroll();
                    setTimeout(handle_scroll,1000);

                    if(document && document.addEventListener){

                        document.addEventListener("touchmove", handle_mousemove, false);
                    }


                }

                if(o.settings_mode == 'mouse_body' || o.settings_movexaftermouse=='on' || parallaxer_aftermouse_elements.length){
                    $(document).on('mousemove', handle_mousemove);
                }
            }

            function init_loaded(){

                cthis.addClass('loaded');



                if(o.settings_mode == 'horizontal'){


                    console.info(_loadTarget, _loadTarget_src, _loadTarget.naturalWidth, cw, tw);

                    nw = _loadTarget.naturalWidth;
                    nh = _loadTarget.naturalHeight;
                    tw = nw/nh * ch;

                    console.log(nw,nh,tw, ch);
                    if(_theTarget.hasClass('divimage')){

                    }



                    console.info(_theTargetClone);
                    _theTargetClone.css({

                        'left':'calc(-100% + 1px)'
                        //'left':'-100%',
                    })
                    _theTarget.css({
                        'width':'100%'
                    })

                    if(_theTarget.hasClass('repeat-pattern')){

                        console.info('nw - ',nw, 'cw - ',cw);

                        tw = Math.ceil(cw / nw ) * nw;
                        console.info('tw - ',tw);

                    }


                    cthis.find('.dzsparallaxer--target-con').css({
                        'width':tw
                    })
                    //_theTargetClone.animate({
                    //    'left':'0'
                    //},{
                    //    queue:false
                    //    ,duration: Number(o.animation_duration)
                    //    ,easing: 'linear'
                    //    ,complete:function(e,ui){
                    //    }
                    //})
                    //_theTarget.animate({
                    //    'left':tw
                    //},{
                    //    queue:false
                    //    ,duration: Number(o.animation_duration)
                    //    ,easing: 'linear'
                    //    ,complete:function(e,ui){
                    //        var _t = $(this);
                    //    }
                    //})
                }
            }

            function destroy(){
                api_outer_update_func = null;
                stop_enter_frame = true;
                api_outer_update_func = null;
                destroyed = true;
                $(window).off('scroll.dzsprx'+cthis_index,handle_scroll);
                if(document && document.addEventListener){

                    document.removeEventListener("touchmove", handle_mousemove, false);
                }
            }
            function debug_func(){
                //console.info(debug_var);
                debug_var = true;
            }
            function destroy_listeners(){

                console.info('DESTROY LISTENERS', cthis);
                destroyed = true;

                clearInterval(inter_debug_func);
                $(window).off('scroll.dzsprx'+cthis_index);
                sw_stop_enter_frame = true;
            }

            function handle_resize(e, pargs){
                cw=cthis.width();
                ww = window.innerWidth;
                wh = window.innerHeight;

                var margs = {
                    'call_from': 'event'
                };

                if(pargs){
                    margs = $.extend(margs,pargs);
                }


                if(started===false){
                    return;
                }


                if(o.settings_mode=='oneelement'){
                    var last_translate = cthis.css('transform');
                    cthis.css('transform','translate3d(0,0,0)');
                }


                cthis_ot = parseInt(cthis.offset().top,10);


                if(margs.call_from=='autocheck'){
                    if(Math.abs(last_wh-wh)<4 && Math.abs(last_cthis_ot-cthis_ot)<4){
                        if(o.settings_mode=='oneelement') {
                            cthis.css('transform', last_translate);
                        }
                        return false;
                    }
                }
                // console.warn('handle_resize', last_wh, wh, st, last_cthis_ot, cthis_ot, margs);
                last_wh = wh;
                last_cthis_ot = cthis_ot;




                // console.info(cthis_ot, cthis);

                // console.warn('responsive_reference_width - ', responsive_reference_width, 'responsive_optimal_height - ',responsive_optimal_height, 'cw - ',cw);

                if(responsive_reference_width && responsive_optimal_height){
                    if(cw<responsive_reference_width){
                        var aux = cw/responsive_reference_width*responsive_optimal_height;
                        // console.log('aux  ( calculate optimal ) - ',aux);

                        cthis.height(aux);
                    }else{

                        cthis.height(responsive_optimal_height);
                    }
                }

                if(cw<760){
                    cthis.addClass('under-760')
                }else{

                    cthis.removeClass('under-760')
                }
                if(cw<500){
                    cthis.addClass('under-500')
                }else{

                    cthis.removeClass('under-500')
                }

                if(int_calculate_dims){
                    clearTimeout(int_calculate_dims);
                }

                int_calculate_dims = setTimeout(calculate_dims,700);


                if(o.js_breakout=='on'){
                    cthis.css('width',ww+'px');

                    cthis.css('margin-left','0');

                    //console.info(cthis, cthis.get(0).offsetLeft, cthis.offset().left, _theTarget.offset().left)

                    if(cthis.offset().left>0){
                        cthis.css('margin-left','-'+cthis.offset().left+'px');
                    }
                }

                if(o.is_fullscreen=='on'){
                    //console.log(_theTarget,_theTarget.height(), target_viy, ch, th, wh);

                    // -- trying to fix damage ..
                    //if(th + target_viy < wh){
                    //    target_viy = wh-th;
                    //    vi_y = wh-th;
                    //    //console.info('WHAT HERE', duration_viy, vi_y);
                    //    if(duration_viy>0){
                    //
                    //        backup_duration_viy = duration_viy;
                    //    }
                    //    duration_viy = 0;
                    //    //console.log('yesyes', _theTarget,th, target_viy, ch, th, wh);
                    //    handle_scroll(null, {force_vi_y : vi_y});
                    //    setTimeout(function(){
                    //        //console.info('WHAT', backup_duration_viy);
                    //        duration_viy = backup_duration_viy;
                    //    },50)
                    //    //console.info(target_viy, th-_theTarget.height())
                    //}
                }
            }

            function calculate_dims(){

                //console.info(_theTarget);
                ch = cthis.outerHeight();
                th = _theTarget.outerHeight();
                wh = window.innerHeight;

                if(o.settings_substract_from_th){
                    th-= o.settings_substract_from_th;
                }

                if(o.settings_clip_height_is_window_height){
                    ch = window.innerHeight;
                }




                //return;

                //console.info(initialheight);
                if(cthis.hasClass('allbody')==false && cthis.hasClass('dzsparallaxer---window-height')==false && responsive_reference_width==0){

                    // console.info("hier");
                    if(th<=initialheight && th > 0){
                        if(o.settings_mode!='oneelement' && cthis.hasClass('do-not-set-js-height')==false && cthis.hasClass('height-is-based-on-content')==false) {
                            cthis.height(th);
                        }
                        ch = cthis.height();
                        //_theTarget.css('top',0);



                        if(is_ie()&&version_ie()<=10){

                            _theTarget.css('top','0');
                        }else{

                            // _theTarget.css('transform','translate3d(0,'+0+'px,0)');
                            _theTarget.css('transform','');
                        }

                        if(_blackOverlay){
                            _blackOverlay.css('opacity','0');
                        }
                    }else{

                        //console.log(cthis, 'why do we do this ? ');

                        // console.info(cthis.hasClass('do-not-set-js-height'));
                        if(o.settings_mode!='oneelement' && cthis.hasClass('do-not-set-js-height')==false && cthis.hasClass('height-is-based-on-content')==false){

                            // cthis.height(initialheight);
                        }

                    }
                }
                if(_theTarget.attr('data-forcewidth_ratio')){
                    _theTarget.width(Number(_theTarget.attr('data-forcewidth_ratio')) * _theTarget.height());
                    if(_theTarget.width()<cthis.width()){
                        _theTarget.width(cthis.width());
                    }
                }

                clearTimeout(inter_scroll_from_resize);
                inter_scroll_from_resize = setTimeout(handle_scroll,200);
                // setTimeout(function(){
                //
                // }, 300);

            }

            //console.info(th, ch);

            function handle_mousemove(e){



                // console.info(e, o.settings_movexaftermouse);


                if(o.settings_mode == 'mouse_body' ){
                    st = e.pageY - $(window).scrollTop();

                    var vi_y = 0;

                    if(th==0){
                        return;
                    }

                    vi_y = st/wh  * (ch-th);

                    bo_o = st/ch;

                    //console.info(ch,th,vi_y);

                    if(vi_y > 0){ vi_y = 0 };
                    if(vi_y < ch-th){ vi_y = ch-th };
                    if(bo_o > 1){ bo_o = 1 };
                    if(bo_o < 0){ bo_o = 0 };

                    finish_viy = vi_y;


                    //console.info('finish_viy - ',finish_viy,ch,th, vi_y);
                    //_theTarget.css('transform','translate3d(0,'+vi_y+'px,0)');
                }


                if( o.settings_movexaftermouse=='on'){
                    var mx = e.pageX;


                    var vi_x = 0;


                    vi_x = (mx/ww) * (cw-tw);


                    if(vi_x > 0){ vi_x = 0 };
                    if(vi_x < cw-tw){ vi_x = cw-tw };

                    // console.info(vi_x);


                    finish_vix = vi_x;


                    //console.info(mx, ww, cw, tw, vi_x);

                }

                if(parallaxer_aftermouse_elements){

                    var mx = e.pageX;
                    var my = e.clientY;


                    vi_x = ((mx/ww) * simple_parallaxer_max_offset * 2) - simple_parallaxer_max_offset;
                    vi_y = ((my/wh) * simple_parallaxer_max_offset * 4) - simple_parallaxer_max_offset * 2;

                    // console.info(vi_x);

                    // console.info(my, wh, vi_y);

                    if(vi_x > simple_parallaxer_max_offset){ vi_x = simple_parallaxer_max_offset };
                    if(vi_x < -simple_parallaxer_max_offset){ vi_x = -simple_parallaxer_max_offset };

                    if(vi_y > simple_parallaxer_max_offset){ vi_y = simple_parallaxer_max_offset };
                    if(vi_y < -simple_parallaxer_max_offset){ vi_y = -simple_parallaxer_max_offset };

                    // console.info(parallaxer_aftermouse_elements);
                    for(var i3=0;i3<parallaxer_aftermouse_elements.length;i3++){
                        var _c = parallaxer_aftermouse_elements[i3];

                        // console.info(_c);
                        _c.css({
                            'top': vi_y
                            ,'left':vi_x
                        },{
                            queue:false
                            ,duration: 100
                        })
                    }

                }

            }

            function handle_scroll(e, pargs){
                //console.info('handle_scroll', cthis, e, $(window).scrollTop());
                st = $(window).scrollTop();
                vi_y = 0;




                // console.info(st,cthis_ot-cthis.outerHeight(), st, cthis_ot+cthis.outerHeight() );


                //|| o.mode_scroll=='fromtop'
                if( (cthis_ot > st-wh && st<cthis_ot+cthis.outerHeight()) ){


                    sw_out_of_display = false;
                    sw_suspend_functional = false;
                }else{





                    if(o.settings_detect_out_of_screen){
                        sw_out_of_display = true;
                        sw_suspend_functional = true;
                    }
                }


                if(_scrollTop_is_another_element_top){
                    st = -parseInt(_scrollTop_is_another_element_top.css('top'),10);
                    //console.info('handle_scroll', cthis, e, _scrollTop_is_another_element_top, _scrollTop_is_another_element_top.css('top'), st);
                    if(_scrollTop_is_another_element_top.data('targettop')){
                        st = -_scrollTop_is_another_element_top.data('targettop');
                    }

                }

                //console.info('scroll top is - ',st, o.settings_listen_to_object_scroll_top, _scrollTop_is_another_element_top.css('top'),'target top->',_scrollTop_is_another_element_top.data('targettop'));


                if(o.settings_listen_to_object_scroll_top){
                    st = o.settings_listen_to_object_scroll_top.val;
                }


                if(isNaN(st)){
                    st = 0;
                }

                if(e){
                    if(o.init_functional_remove_delay_on_scroll=='on'){
                        //console.info("REMOVE SUSPEND FUNCTIONAL !!! ", cthis, sw_suspend_functional, e);
                        sw_suspend_functional = false;
                    }
                }



                var margs = {
                    force_vi_y: null
                    ,from: ''
                    ,force_ch: null
                    ,force_th: null
                    ,force_th_only_big_diff: true
                };



                if(pargs){
                    margs = $.extend(margs,pargs);
                }


                if(o.settings_clip_height_is_window_height){
                    ch = window.innerHeight;
                }

                //console.info('ch pre force_ch',ch);
                if(margs.force_ch!=null){
                    ch = margs.force_ch;
                }
                if(margs.force_th!=null){

                    if(margs.force_th_only_big_diff){
                        // console.warn('forced th diff - ',Math.abs(margs.force_th - th));

                        if(Math.abs(margs.force_th - th)>20){
                            th = margs.force_th;
                        }
                    }else{

                        th = margs.force_th;
                    }

                    // console.warn('forced th - ',th);
                }

                //console.info('ch post force_ch',ch);


                //console.info(margs);


                if(started===false){
                    wh = window.innerHeight;
                    if((st+wh)>=cthis.offset().top){
                        init_start();
                    }
                }

                //console.info(th);


                if(th==0){
                    return;
                }


                //console.warn(st+wh, cthis_ot, started)
                if(started===false || (o.settings_mode!='scroll' && o.settings_mode!='oneelement') ){
                    return;
                }
                //console.warn(st+wh, cthis_ot, 'what')

                if(o.settings_mode=='oneelement'){


                    var aux_r = (st-cthis_ot+wh) / wh;

                    if(cthis.attr('id')=='debug') {
                        // console.info((st-cthis_ot+wh), st,cthis_ot, wh, aux_r);
                    }

                    if(aux_r<0){
                        aux_r = 0;
                    }
                    if(aux_r>1){
                        aux_r = 1;
                    }


                    if (o.direction == 'reverse') {
                        aux_r = Math.abs(1-aux_r);
                    }

                    vi_y = (aux_r * ( o.settings_mode_oneelement_max_offset*2) ) - o.settings_mode_oneelement_max_offset ;

                    finish_viy = vi_y;
                    //console.warn(st+wh, cthis_ot, aux_r)


                    if(cthis.attr('id')=='debug'){

                        // console.info(vi_y);
                    }

                }


                if(o.settings_mode=='scroll') {








                    if (o.mode_scroll == 'fromtop') {
                        vi_y = ((st / ch)) * (ch - th);

                        if (o.is_fullscreen == 'on') {

                            vi_y = st / (th - wh) * (ch - th);


                            if (_scrollTop_is_another_element_top) {


                                vi_y = st / (_scrollTop_is_another_element_top.height() - wh) * (ch - th);

                            }
                        }

                        if (o.direction == 'reverse') {
                            vi_y = (1 - (st / ch)) * (ch - th);
                            //console.info(st,th)


                            if (o.is_fullscreen == 'on') {

                                vi_y = (1 - (st / (th - wh)) ) * (ch - th);


                                //console.info(_scrollTop_is_another_element_top);
                                if (_scrollTop_is_another_element_top) {


                                    vi_y = (1 - (st / (_scrollTop_is_another_element_top.height() - wh)) ) * (ch - th);

                                    //console.log(st,_scrollTop_is_another_element_top.height(),wh,ch,th, vi_y);
                                    //vi_y = st / ( - wh)  * (ch-th);

                                }
                            }
                        }


                    }


                    cthis_ot = cthis.offset().top;


                    if (_scrollTop_is_another_element_top) {
                        cthis_ot = -parseInt(_scrollTop_is_another_element_top.css('top'), 10);
                    }

                    // console.log(st, cthis_ot, wh, ch);
                    var auxer5 = (st - (cthis_ot - wh)) / ((cthis_ot + ch) - (cthis_ot - wh));


                    //console.info('is fullscreen ?? - ', o.is_fullscreen);
                    if (o.is_fullscreen == 'on') {



                        //console.info('scrolltop - ',st);

                        auxer5 = st / ($('body').height() - wh);

                        //console.info($('body').height(), wh);

                        if (_scrollTop_is_another_element_top) {


                            auxer5 = st / (_scrollTop_is_another_element_top.outerHeight() - wh);

                            //cthis_ot = -parseInt(_scrollTop_is_another_element_top.css('top'),10);
                        }
                    }

                    // console.info('st and auxer5 - ',st, auxer5, vi_y, o.settings_listen_to_object_scroll_top);
                    if (auxer5 > 1) {
                        auxer5 = 1;
                    }
                    if (auxer5 < 0) {
                        auxer5 = 0;
                    }
                    // console.info('st and auxer5 - ',st, auxer5, vi_y, o.settings_listen_to_object_scroll_top);

                    if (animator_objects_arr) {

                        // console.info(animator_objects_arr);
                        for (i = 0; i < animator_objects_arr.length; i++) {

                            var _c = animator_objects_arr[i];
                            var cdata = _c.data('parallax_options');


                            //console.info(cdata);
                            if (cdata) {
                                for (var j = 0; j < cdata.length; j++) {

                                    if (auxer5 <= 0.5) {
                                        var auxer5_doubled = auxer5 * 2;
                                        var auxer5_doubled_inverse = (auxer5 * 2) - 1;
                                        if (auxer5_doubled_inverse < 0) {
                                            auxer5_doubled_inverse = -auxer5_doubled_inverse;
                                        }

                                        //var auxval = cdata[j].initial + (auxer5*2) * cdata[j].mid;
                                        //if(cdata[j].initial > cdata[j].mid){
                                        //    auxval = (auxer5*2) * cdata[j].mid - cdata[j].initial;
                                        //}

                                        var auxval = auxer5_doubled_inverse * cdata[j].initial + auxer5_doubled * cdata[j].mid;
                                        var cval = cdata[j].value;

                                        cval = cval.replace(/{{val}}/g, auxval);
                                        //console.log(cval);
                                        //console.info(cdata[j].property, auxval);
                                        _c.css(cdata[j].property, cval);
                                    } else {

                                        var auxer5_doubled = (auxer5 - 0.5) * 2;
                                        var auxer5_doubled_inverse = auxer5_doubled - 1;
                                        if (auxer5_doubled_inverse < 0) {
                                            auxer5_doubled_inverse = -auxer5_doubled_inverse;
                                        }

                                        //var auxval = cdata[j].initial + (auxer5*2) * cdata[j].mid;
                                        //if(cdata[j].initial > cdata[j].mid){
                                        //    auxval = (auxer5*2) * cdata[j].mid - cdata[j].initial;
                                        //}

                                        var auxval = auxer5_doubled_inverse * cdata[j].mid + auxer5_doubled * cdata[j].final;

                                        //console.info(auxval,auxer5_doubled_inverse,auxer5_doubled)
                                        var cval = cdata[j].value;
                                        cval = cval.replace(/{{val}}/g, auxval);
                                        _c.css(cdata[j].property, cval);
                                    }
                                }

                            }


                            //console.info(animator_objects_arr[i],);
                        }
                    }

                    //console.info(auxer5, ch,th);

                    //console.info('pre calculate vi_y', auxer5, ch, th);
                    if (o.mode_scroll == 'normal') {


                        vi_y = auxer5 * (ch - th);
                        //consoel.info(auxer5, vi_y);

                        if (o.direction == 'reverse') {

                            vi_y = (1 - (auxer5)) * (ch - th);
                        }

                        // console.info(vi_y, 'auxer5 - ', auxer5, ch, th, cthis_ot, cthis.attr('class'));

                        if (cthis.hasClass('debug-target')) {
                            console.info(o.mode_scroll, st, cthis_ot, wh, ch, (cthis_ot + ch), auxer5);
                        }


                    }
                    if (o.mode_scroll == 'fromtop') {



                        if (vi_y < ch - th) {
                            vi_y = ch - th
                        }

                        // console.info(ch,th);

                    }


                    // console.info('vi_y - ',vi_y);

                    if(cthis.hasClass('simple-parallax')){
                        aux_r = (st+wh-cthis_ot) / (wh+th);


                        // console.info('scroll top - ',st);
                        // console.info('window height - ',wh);
                        // console.info('cthis offset top - ',cthis_ot);
                        // console.info('total height - ',th);

                        if(aux_r<0){
                            aux_r = 0;
                        }
                        if(aux_r>1){
                            aux_r = 1;
                        }

                        aux_r = Math.abs(1-aux_r);


                        // console.info(aux_r);

                        if(cthis.hasClass('is-mobile')){
                            simple_parallaxer_max_offset = cthis.height()/2;
                        }

                        vi_y = (aux_r * ( simple_parallaxer_max_offset*2) ) - simple_parallaxer_max_offset ;

                        // console.warn(aux_r, vi_y);
                    }

                    //console.info('calculate vi_y', vi_y);

                    if (_fadeouttarget) {

                        var auxer4 = Math.abs(((st - cthis_ot) / cthis.outerHeight()) - 1);
                        if (auxer4 > 1) {
                            auxer4 = 1;
                        }
                        if (auxer4 < 0) {
                            auxer4 = 0;
                        }


                        _fadeouttarget.css('opacity', auxer4);
                    }


                    bo_o = st / ch;
                    // console.info('crds - ',st, vi_y,ch,th);


                    if(cthis.hasClass('simple-parallax')==false){
                        if (vi_y > 0) {
                            vi_y = 0
                        }
                        ;
                        if (vi_y < ch - th) {
                            vi_y = ch - th
                        }
                        ;

                        // console.info(vi_y);
                    }

                    if (bo_o > 1) {
                        bo_o = 1
                    }
                    ;
                    if (bo_o < 0) {
                        bo_o = 0
                    }
                    ;

                    //console.log(vi_y);


                    if (margs.force_vi_y) {
                        vi_y = margs.force_vi_y;
                    }

                    finish_viy = vi_y;
                    finish_bo = bo_o;


                    // console.info(finish_viy);

                    // console.info('check ' , duration_viy);

                    if (duration_viy === 0 || o.animation_engine=='css') {

                        target_viy = finish_viy;

                        if (sw_suspend_functional == false || 0) {
                            //console.info('DURATION VIY = 0', st, vi_y, target_viy)
                            // if (is_ie() && version_ie() <= 10) {
                            //     _theTarget.css('top', '' + target_viy + 'px');
                            // } else {
                            //
                            //
                            //     _theTarget.css('transform', 'translate3d(0,' + target_viy + 'px,0)');
                            // }


                            // console.info('check 2' , duration_viy);



                            if(cthis.hasClass('simple-parallax')){

                                if(_theTarget.parent().hasClass('is-image') || cthis.hasClass('simple-parallax--is-only-image')){
                                    //_theTarget.css('background-position-y',target_viy+'px')
                                    _theTarget.css('background-position-y','calc(50% - '+parseInt(target_viy,10)+'px)')
                                }

                            }else{
                                if(is_ie()&&version_ie()<=10){
                                    _theTarget.css('top',''+target_viy+'px');
                                }else{
                                    _theTarget.css('transform','translate3d('+target_vix+'px,'+target_viy+'px,0)');


                                    if(o.settings_mode=='oneelement'){
                                        cthis.css('transform','translate3d('+target_vix+'px,'+target_viy+'px,0)');
                                    }
                                }
                            }
                        }


                    }

                    //clearTimeout(inter_suspend_enter_frame);
                    //if(sw_suspend_functional==false){
                    //    inter_suspend_enter_frame = setTimeout(switch_suspend_enter_frame,700);
                    //}
                    //sw_suspend_functional = false;

                }
                var time=0;
                //console.info(vi_y);

                //console.info(st/ch, vi_y);
                //_theTarget.css('top',vi_y);
                //_theTarget.css('transform','translate3d(0,'+vi_y+'px,0)');

            }

            function switch_suspend_enter_frame(){
                sw_suspend_functional=true;
            }

            function handle_frame(){


                if(sw_suspend_functional){
                    requestAnimFrame(handle_frame);
                    return false;
                }

                //console.info('handle_frame', finish_viy, duration_viy, target_viy);
                //console.info('handle_frame()' , cthis);

                if(isNaN(target_viy)){
                    target_viy=0;
                }

                if(debug_var){
                    //console.log('animation running');
                    debug_var=false;
                }


                if(o.settings_mode=='horizontal'){
                    return false;
                }

                //console.info(duration_viy);
                if(duration_viy===0 || o.animation_engine=='css' ){

                    //console.info("RETURN");
                    if(api_outer_update_func){
                        api_outer_update_func(target_viy);
                    }
                    requestAnimFrame(handle_frame);
                    return false;
                }

                begin_viy = target_viy;
                change_viy = finish_viy - begin_viy;

                begin_bo = target_bo;
                change_bo = finish_bo - begin_bo;


                //console.info(finish_viy, begin_viy, change_viy);
                //console.log(duration_viy);
                if(o.easing=='easeIn'){
                    target_viy =  Number(Math.easeIn(1, begin_viy, change_viy, duration_viy).toFixed(5));
                    //target_viy =  Number(Math.easeIn(1, begin_viy, change_viy, duration_viy));
                    target_bo =  Number(Math.easeIn(1, begin_bo, change_bo, duration_viy).toFixed(5));

                    // console.info(target_viy);
                }
                if(o.easing=='easeOutQuad'){
                    target_viy = Math.easeOutQuad(1, begin_viy, change_viy, duration_viy);
                    target_bo = Math.easeOutQuad(1, begin_bo, change_bo, duration_viy);
                }
                if(o.easing=='easeInOutSine'){
                    target_viy = Math.easeInOutSine(1, begin_viy, change_viy, duration_viy);
                    target_bo = Math.easeInOutSine(1, begin_bo, change_bo, duration_viy);
                }


                target_vix = 0;
                if(o.settings_movexaftermouse=='on'){
                    begin_vix = target_vix;
                    change_vix = finish_vix - begin_vix;

                    //console.info(begin_vix, change_vix, duration_viy);
                    target_vix = Math.easeIn(1, begin_vix, change_vix, duration_viy);
                }


                //console.log(begin_viy, change_viy, target_viy);

                // console.info('DURATION VIY = many', duration_viy, vi_y, target_viy)

                if(cthis.hasClass('simple-parallax')){

                    if(_theTarget.parent().hasClass('is-image')){
                        //_theTarget.css('background-position-y',target_viy+'px')
                        _theTarget.css('background-position-y','calc(50% - '+parseInt(target_viy,10)+'px)')
                    }

                }else{
                    if(is_ie()&&version_ie()<=10){
                        _theTarget.css('top',''+target_viy+'px');
                    }else{
                        _theTarget.css('transform','translate3d('+target_vix+'px,'+target_viy+'px,0)');


                        if(o.settings_mode=='oneelement'){
                            cthis.css('transform','translate3d('+target_vix+'px,'+target_viy+'px,0)');
                        }
                    }
                }




                //console.info(_blackOverlay,target_bo);;

                if(_blackOverlay){
                    _blackOverlay.css('opacity',target_bo);
                }

                if(api_outer_update_func){
                    api_outer_update_func(target_viy);
                }

                if(stop_enter_frame){
                    return false;
                }

                requestAnimFrame(handle_frame);
            }

        })
    }
    window.dzsprx_init = function(selector, settings) {
        if(typeof(settings)!="undefined" && typeof(settings.init_each)!="undefined" && settings.init_each==true ){
            var element_count = 0;
            for (var e in settings) { element_count++; }
            if(element_count==1){
                settings = undefined;
            }

            $(selector).each(function(){
                var _t = $(this);
                _t.dzsparallaxer(settings)
            });
        }else{
            $(selector).dzsparallaxer(settings);
        }

    };
})(jQuery);

function is_mobile() {
    var userAgent = navigator.userAgent || navigator.vendor || window.opera;

    // Windows Phone must come first because its UA also contains "Android"
    if (/windows phone/i.test(userAgent)) {
        return true;
    }

    if (/android/i.test(userAgent)) {
        return true;
    }

    // iOS detection from: http://stackoverflow.com/a/9039885/177710
    if (/iPad|iPhone|iPod/.test(userAgent) && !window.MSStream) {
        return true;
    }

    return false;
}

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

    $('.dzsparallaxer---window-height').each(function(){
        var _t = $(this);
        //return false;

        $(window).on('resize',handle_resize);
        handle_resize();

        function handle_resize(){
            var wh = window.innerHeight;

            _t.height(wh);
        }
    })
    dzsprx_init('.dzsparallaxer.auto-init', {init_each: true});

});