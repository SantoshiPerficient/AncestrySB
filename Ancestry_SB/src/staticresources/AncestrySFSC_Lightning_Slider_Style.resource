@charset "UTF-8";
/* CSS Document */

.csslider1 {
    display: inline-block;
    position: relative;
    max-width: 830px;
    
    width: 100%;
    margin-top: 10px;
}
.csslider1 > .cs_anchor {
    display: none;
}
.csslider1 > ul {
    position: relative;
    z-index: 1;
    font-size: 0;
    line-height: 0;
    margin: 0 auto;
    padding: 0;
    
    overflow: hidden;
    white-space: nowrap;
}
.csslider1 > ul > div {
    width: 100%;
    visibility: hidden;
    font-size: 0px;
    line-height: 0;
}
.csslider1 > ul > li.img img {
    width: 100%;
}
.csslider1 > ul > li.img {
    font-size: 0pt;
}
.csslider1 > ul > li {
    position: relative;
    display: inline-block;
    width: 100%;
    height: 100%;
    overflow: hidden;
    font-size: 15px;
    font-size: initial;
    line-height: normal;
    white-space: normal;
    vertical-align: top;
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
    
    -webkit-transform: translate3d(0,0,0);
    -moz-transform: translate3d(0,0,0);
    -ms-transform: translate3d(0,0,0);
    -o-transform: translate3d(0,0,0);
    transform: translate3d(0,0,0);
}
.csslider1 .cs_lnk{
    position: absolute;
    top: -9999px;
    left: -9999px;
    font-size: 0pt;
    opacity: 0;
    filter: alpha(opacity=0);
}

.csslider1 > ul > li.img,
.csslider1 > .cs_arrowprev,
.csslider1 > .cs_arrownext,
.csslider1 > .cs_bullets,
.csslider1 > .cs_play_pause {
    -webkit-touch-callout: none;
    -webkit-user-select: none;
    -khtml-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
}

.csslider1 > .cs_arrowprev,
.csslider1 > .cs_arrownext {
    position: absolute;
    top: 50%;
    -webkit-box-sizing: content-box;
    -moz-box-sizing: content-box;
    box-sizing: content-box;
    z-index: 5;
}
.csslider1 > .cs_arrowprev > label,
.csslider1 > .cs_arrownext > label {
    position: absolute;
    text-decoration: none;
    cursor: pointer;
    opacity: 0;
    z-index: -1;
}
.csslider1 > .cs_arrowprev {
    left: 0;
}
.csslider1 > .cs_arrownext {
    right: 0;
}

.csslider1 > .slide:checked ~ .cs_arrowprev > label,
.csslider1 > .slide:checked ~ .cs_arrownext > label {
    opacity: 0;
    z-index: -1;
}

.csslider1 > #cs_slide1_0:checked ~ .cs_arrowprev > label.num5,
.csslider1 > #cs_pause1_0:checked ~ .cs_arrowprev > label.num5,
.csslider1 > #cs_slide1_0:checked ~ .cs_arrownext > label.num1,
.csslider1 > #cs_pause1_0:checked ~ .cs_arrownext > label.num1, 
.csslider1 > #cs_slide1_1:checked ~ .cs_arrowprev > label.num0,
.csslider1 > #cs_pause1_1:checked ~ .cs_arrowprev > label.num0,
.csslider1 > #cs_slide1_1:checked ~ .cs_arrownext > label.num2,
.csslider1 > #cs_pause1_1:checked ~ .cs_arrownext > label.num2, 
.csslider1 > #cs_slide1_2:checked ~ .cs_arrowprev > label.num1,
.csslider1 > #cs_pause1_2:checked ~ .cs_arrowprev > label.num1,
.csslider1 > #cs_slide1_2:checked ~ .cs_arrownext > label.num3,
.csslider1 > #cs_pause1_2:checked ~ .cs_arrownext > label.num3, 
.csslider1 > #cs_slide1_3:checked ~ .cs_arrowprev > label.num2,
.csslider1 > #cs_pause1_3:checked ~ .cs_arrowprev > label.num2,
.csslider1 > #cs_slide1_3:checked ~ .cs_arrownext > label.num4,
.csslider1 > #cs_pause1_3:checked ~ .cs_arrownext > label.num4,
.csslider1 > #cs_slide1_4:checked ~ .cs_arrowprev > label.num3,
.csslider1 > #cs_pause1_4:checked ~ .cs_arrowprev > label.num3,
.csslider1 > #cs_slide1_4:checked ~ .cs_arrownext > label.num5,
.csslider1 > #cs_pause1_4:checked ~ .cs_arrownext > label.num5,
.csslider1 > #cs_slide1_5:checked ~ .cs_arrowprev > label.num4,
.csslider1 > #cs_pause1_5:checked ~ .cs_arrowprev > label.num4,
.csslider1 > #cs_slide1_5:checked ~ .cs_arrownext > label.num0,
.csslider1 > #cs_pause1_5:checked ~ .cs_arrownext > label.num0{
    opacity: 1;
    z-index: 5;
}

@-webkit-keyframes arrow {
    0%, 16.6666666666667% { opacity: 1; z-index: 5; }
    16.66666666667%, 100%	{ opacity: 0; z-index: -1; }
}
@-moz-keyframes arrow {
    0%, 16.6666666666667% { opacity: 1; z-index: 5; }
    16.66666666667%, 100%	{ opacity: 0; z-index: -1; }
}
@keyframes arrow {
     0%, 16.6666666666667% { opacity: 1; z-index: 5; }
    16.66666666667%, 100%	{ opacity: 0; z-index: -1; }
}


.csslider1 > #cs_play1:checked ~ .cs_arrowprev > label.num5,
.csslider1 > #cs_play1:checked ~ .cs_arrownext > label.num1 {
    -webkit-animation: arrow 20000ms infinite -1000ms;
    -moz-animation: arrow 20000ms infinite -1000ms;
    animation: arrow 20000ms infinite -1000ms;
    
}
.csslider1 > #cs_play1:checked ~ .cs_arrowprev > label.num0,
.csslider1 > #cs_play1:checked ~ .cs_arrownext > label.num2 {
    -webkit-animation: arrow 20000ms infinite 3100ms;
    -moz-animation: arrow 20000ms infinite 3100ms;
    animation: arrow 20000ms infinite 3100ms;
    
}
.csslider1 > #cs_play1:checked ~ .cs_arrowprev > label.num1,
.csslider1 > #cs_play1:checked ~ .cs_arrownext > label.num3 {
    -webkit-animation: arrow 20000ms infinite 7200ms;
    -moz-animation: arrow 20000ms infinite 7200ms;
    animation: arrow 20000ms infinite 7200ms;
    
}
.csslider1 > #cs_play1:checked ~ .cs_arrowprev > label.num2,
.csslider1 > #cs_play1:checked ~ .cs_arrownext > label.num4 {
    -webkit-animation: arrow 20000ms infinite 11300ms;
    -moz-animation: arrow 20000ms infinite 11300ms;
    animation: arrow 20000ms infinite 11300ms;
    
}
.csslider1 > #cs_play1:checked ~ .cs_arrowprev > label.num3,
.csslider1 > #cs_play1:checked ~ .cs_arrownext > label.num5 {
    -webkit-animation: arrow 20000ms infinite 15400ms;
    -moz-animation: arrow 20000ms infinite 15400ms;
    animation: arrow 20000ms infinite 15400ms;
    
}
.csslider1 > #cs_play1:checked ~ .cs_arrowprev > label.num4,
.csslider1 > #cs_play1:checked ~ .cs_arrownext > label.num0 {
    -webkit-animation: arrow 20000ms infinite 19500ms;
    -moz-animation: arrow 20000ms infinite 19500ms;
    animation: arrow 20000ms infinite 19500ms;
    
}
.csslider1 > .slide:checked ~ .cs_arrowprev > label,
.csslider1 > .slide:checked ~ .cs_arrownext > label,
.csslider1 > .pause:checked ~ .cs_arrowprev > label,
.csslider1 > .pause:checked ~ .cs_arrownext > label {
    -webkit-animation: none;
    -moz-animation: none;
    -ms-animation: none;
    -o-animation: none;
    animation: none;
}

.csslider1 > .cs_bullets {
    position: absolute;
    left: 0;
    width: 100%;
    z-index: 6;
    font-size: 0;
    line-height: 8pt;
    text-align: center;
}
.csslider1 > .cs_bullets > div {
    margin-left: -50%;
    width: 100%;
}
.csslider1 > .cs_bullets > label {
    position: relative;
    display: inline-block;
    cursor: pointer;
}
.csslider1 > .cs_bullets > label > .cs_thumb {
    visibility: hidden;
    position: absolute;
    opacity: 0;
    z-index: 1;
    line-height: 0;
    left: -55px;
    top: -48px;
}
.csslider1 > .cs_bullets > label > .cs_thumb > img {
    max-width: none;
}
.csslider1.cs_handle {
}
.csslider1.cs_handle.cs_grab {
}

.csslider1 > ul > li.num0 {
    left: 0%;
}
.csslider1 > ul > li.num1 {
    left: 100%;
}
.csslider1 > ul > li.num2 {
    left: 200%;
}
.csslider1 > ul > li.num3 {
    left: 300%;
}
.csslider1 > ul > li.num4 {
    left: 400%;
}
.csslider1 > ul > li.num5 {
    left: 500%;
}
.csslider1 > #cs_slide1_0:checked ~ ul > li,
.csslider1 > #cs_pause1_0:checked ~ ul > li {
    -webkit-transform: translateX(0%);
    -moz-transform: translateX(0%);
    transform: translateX(0%);
    
}
.csslider1 > #cs_slide1_1:checked ~ ul > li,
.csslider1 > #cs_pause1_1:checked ~ ul > li {
    -webkit-transform: translateX(-100%);
    -moz-transform: translateX(-100%);
    transform: translateX(-100%);
    
}
.csslider1 > #cs_slide1_2:checked ~ ul > li,
.csslider1 > #cs_pause1_2:checked ~ ul > li {
    -webkit-transform: translateX(-200%);
    -moz-transform: translateX(-200%);
    transform: translateX(-200%);
    
}
.csslider1 > #cs_slide1_3:checked ~ ul > li,
.csslider1 > #cs_pause1_3:checked ~ ul > li {
    -webkit-transform: translateX(-300%);
    -moz-transform: translateX(-300%);
    transform: translateX(-300%);
    
}
.csslider1 > #cs_slide1_4:checked ~ ul > li,
.csslider1 > #cs_pause1_4:checked ~ ul > li {
    -webkit-transform: translateX(-400%);
    -moz-transform: translateX(-400%);
    transform: translateX(-400%);
    
}
.csslider1 > #cs_slide1_5:checked ~ ul > li,
.csslider1 > #cs_pause1_5:checked ~ ul > li {
    -webkit-transform: translateX(-500%);
    -moz-transform: translateX(-500%);
    transform: translateX(-500%);
    
}
.csslider1 > ul > li {
    position: absolute;
    top: 0;
    left: 0;
    display: inline-block;
    opacity: 1;
    
    -webkit-transition: -webkit-transform 1000ms;
    -moz-transition: -moz-transform 1000ms;
    transition: transform 1000ms;
    
    
    
    -webkit-transform: scale(1);
    -moz-transform: scale(1);
    transform: scale(1);
    
}


@-webkit-keyframes slide {
    0%, 16.666666666667%	{ -webkit-transform: translateX(0%); }
    16.666666666668%, 33.333333333333336%	{ -webkit-transform: translateX(-100%); }
    33.33333333333334%, 50.333333333333336%{ -webkit-transform: translateX(-200%); }
    
    
    50.33333333333334%, 66.66666666666667%	{ -webkit-transform: translateX(-300%); }
    66.6666666666667%, 83.33333333333336%	{ -webkit-transform: translateX(-400%); }
    
    83.33333333333337%, 91.869918699187%	{ -webkit-transform: translateX(-500%); }   
    
}
@-moz-keyframes slide {
   0%, 16.666666666667%	{ -moz-transform: translateX(0%); }
    16.666666666668%, 33.333333333333336%	{ -moz-transform: translateX(-100%); }
    33.33333333333334%, 50.333333333333336%{ -moz-transform: translateX(-200%); }
    
    
    50.33333333333334%, 66.66666666666667%	{ -moz-transform: translateX(-300%); }
    66.6666666666667%, 83.33333333333336%	{ -moz-transform: translateX(-400%); }
    
    83.33333333333337%, 91.869918699187%	{ -moz-transform: translateX(-500%); }  
    
}
@keyframes slide {
    0%, 16.666666666667%	{ transform: translateX(0%); }
    16.666666666668%, 33.333333333333336%	{ transform: translateX(-100%); }
    33.33333333333334%, 50.333333333333336%{ transform: translateX(-200%); }
    
    
    50.33333333333334%, 66.66666666666667%	{ transform: translateX(-300%); }
    66.6666666666667%, 83.33333333333336%	{ transform: translateX(-400%); }
    
    83.33333333333337%, 91.869918699187%	{ transform: translateX(-500%); }   
    
}


.csslider1  > #cs_play1:checked ~ ul > li {
    -webkit-animation: slide 20000ms infinite;
    -moz-animation: slide 20000ms infinite;
    animation: slide 20000ms infinite;
    
}


.csslider1 > #cs_play1:checked ~ ul > li,
.csslider1 > .pause:checked ~ ul > li {
    -webkit-transition: none;
    -moz-transition: none;
    transition: none;
    
}


/* /calculate autoplay */
.csslider1 > .cs_arrowprev,
.csslider1 > .cs_arrownext {
    top: 0;
    bottom: 0;
    width: 15%;
    opacity: .5;
}
.csslider1 > .cs_arrowprev:hover,
.csslider1 > .cs_arrownext:hover {
    opacity: .9;
}
.csslider1 > .cs_arrowprev {
    left: 0;
    background-image: -webkit-linear-gradient(left, rgba(0,0,0,0.5) 0, rgba(0,0,0,0.0001) 100%);
    background-image: linear-gradient(to right, rgba(0,0,0,0.5) 0, rgba(0,0,0,0.0001) 100%);
    filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#80000000', endColorstr='#00000000', GradientType=1);
    background-repeat: repeat-x;
}
.csslider1 > .cs_arrownext {
    right: 0;
    background-image: -webkit-linear-gradient(left, rgba(0,0,0,0.0001) 0, rgba(0,0,0,0.5) 100%);
    background-image: linear-gradient(to right, rgba(0,0,0,0.0001) 0, rgba(0,0,0,0.5) 100%);
    filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#00000000', endColorstr='#80000000', GradientType=1);
    background-repeat: repeat-x;
}

.csslider1 > .cs_arrowprev > label,
.csslider1 > .cs_arrownext > label {
    top: 0;
    left: 0;
    bottom: 0;
    width: 100%;
}
.csslider1 > .cs_arrowprev > label span,
.csslider1 > .cs_arrownext > label span {
    display: block;
    position: absolute;
    width: 100%;
    height: 100%;
}
.csslider1 > .cs_arrowprev > label span {
    float: left;
}
.csslider1 > .cs_arrownext > label span {
    float: right;
}

.csslider1 > .cs_arrowprev > label span:after,
.csslider1 > .cs_arrownext > label span:after {
    display: block;
    position: absolute;
    width: 30px;
    height:30px;
    top: 50%;
    margin-top: -23px;
    color: #fff;
    text-align: center;
    content:'';
}

.csslider1 > .cs_arrowprev > label span:after {
    background: url('https://s3.amazonaws.com/www.betaoutcdn.com/210522016/02/1455161770.png');
    background-size:100% auto; 
}
.csslider1 > .cs_arrownext > label span:after {
    background: url('https://s3.amazonaws.com/www.betaoutcdn.com/210522016/02/1455161750.png');
    background-size:100% auto; 
}
.csslider1 > .cs_bullets {
    bottom: 20px;
    width: 70%;
    left: 15%;
}
.csslider1 > .cs_bullets > label {
    margin: 0 2px;
    padding: 5px;
    border-radius: 50%;
    background: transparent;
    -webkit-box-shadow: inset 0 0 0 1px #fff;
    box-shadow: inset 0 0 0 1px #fff; 
}

.csslider1 > .cs_bullets > label > .cs_thumb {
    border: 3px solid #fff;
    margin-top: -13px;
    -webkit-transition: opacity .3s, visibility .3s;
    -moz-transition: opacity .3s, visibility .3s;
    transition: opacity .3s, visibility .3s;
    
}
.csslider1 > .cs_bullets > label > .cs_thumb:before {
    content: '';
    position: absolute;
    width: 0; 
    height: 0; 
    left: 50%;
    margin-left: -5px;
    bottom: -10px;
    border-left: 7px solid transparent;
    border-right: 7px solid transparent;
    
    border-top: 7px solid #fff;
}
.csslider1 > .cs_bullets > label:hover > .cs_thumb {
    opacity: 1;
    visibility: visible;
}

.csslider1 > #cs_slide1_0:checked ~ .cs_bullets > label.num0,
.csslider1 > #cs_pause1_0:checked ~ .cs_bullets > label.num0,
.csslider1 > #cs_slide1_1:checked ~ .cs_bullets > label.num1,
.csslider1 > #cs_pause1_1:checked ~ .cs_bullets > label.num1,
.csslider1 > #cs_slide1_2:checked ~ .cs_bullets > label.num2,
.csslider1 > #cs_pause1_2:checked ~ .cs_bullets > label.num2,
.csslider1 > #cs_slide1_3:checked ~ .cs_bullets > label.num3,
.csslider1 > #cs_pause1_3:checked ~ .cs_bullets > label.num3,
.csslider1 > #cs_slide1_4:checked ~ .cs_bullets > label.num4,
.csslider1 > #cs_pause1_4:checked ~ .cs_bullets > label.num4,
.csslider1 > #cs_slide1_5:checked ~ .cs_bullets > label.num5,
.csslider1 > #cs_pause1_5:checked ~ .cs_bullets > label.num5{
    background: #fff;
    padding: 6px;
    -webkit-box-shadow: none;
    box-shadow: none; 
}

@-webkit-keyframes bullet {
    0%, 33.32333333333334%	{
        -webkit-box-shadow: none;
        background: #fff;
        padding: 6px;
    }
    33.333333333333336%, 100% {
        -webkit-box-shadow: inset 0 0 0 1px #fff;
        background: transparent;
        padding: 5px;
        margin-bottom: 0;
    }
}
@-moz-keyframes bullet {
    0%, 33.32333333333334%	{
        -moz-box-shadow: none;
        background: #fff;
        padding: 6px;
    }
    33.333333333333336%, 100% {
        -moz-box-shadow: inset 0 0 0 1px #fff;
        background: transparent;
        padding: 5px;
        margin-bottom: 0;
    }
}
@keyframes bullet {
    0%, 16.66666666666667%	{
        box-shadow: none;
        background: #fff;
        padding: 6px;
    }
    16.66666666666667%, 100% {
        box-shadow: inset 0 0 0 1px #fff;
        background: transparent;
        padding: 5px;
        margin-bottom: 0;
    }
}

.csslider1 > #cs_play1:checked ~ .cs_bullets > label.num0 {
    -webkit-animation: bullet 20000ms infinite -1000ms;
    -moz-animation: bullet 20000ms infinite -1000ms;
    animation: bullet 20000ms infinite -1000ms;
    
}
.csslider1 > #cs_play1:checked ~ .cs_bullets > label.num1 {
    -webkit-animation: bullet 20000ms infinite 3100ms;
    -moz-animation: bullet 20000ms infinite 3100ms;
    animation: bullet 20000ms infinite 3100ms;
    
}
.csslider1 > #cs_play1:checked ~ .cs_bullets > label.num2 {
    -webkit-animation: bullet 20000ms infinite 7200ms;
    -moz-animation: bullet 20000ms infinite 7200ms;
    animation: bullet 20000ms infinite 7200ms;
    
}
.csslider1 > #cs_play1:checked ~ .cs_bullets > label.num3 {
    -webkit-animation: bullet 20000ms infinite 11300ms;
    -moz-animation: bullet 20000ms infinite 11300ms;
    animation: bullet 20000ms infinite 11300ms;
}
.csslider1 > #cs_play1:checked ~ .cs_bullets > label.num4 {
    -webkit-animation: bullet 20000ms infinite 15400ms;
    -moz-animation: bullet 20000ms infinite 15400ms;
    animation: bullet 20000ms infinite 15400ms;
    
}
.csslider1 > #cs_play1:checked ~ .cs_bullets > label.num5 {
    -webkit-animation: bullet 20000ms infinite 19500ms;
    -moz-animation: bullet 20000ms infinite 19500ms;
    animation: bullet 20000ms infinite 19500ms;
    
}
.csslider1 > #cs_play1:checked ~ .cs_bullets > label > .cs_point,
.csslider1 > .pause:checked ~ .cs_bullets > label > .cs_point {
    -webkit-transition: none;
    -moz-transition: none;
    transition: none;
    
}

.csslider1 > .slide:checked ~ .cs_bullets > label > .cs_point,
.csslider1 > .pause:checked ~ .cs_bullets > label > .cs_point {
    -webkit-animation: none;
    -moz-animation: none;
    -ms-animation: none;
    -o-animation: none;
    animation: none;
}


/* ------------- Play ------------- */
.csslider1 > .cs_play_pause{display:block;}

.csslider1 > .cs_play_pause {
    position: absolute;
    bottom: 0;
    right: 0;
    z-index: 5;
}
.csslider1 > .cs_play_pause > label {
    cursor: pointer;
}
.csslider1 > #cs_play1:checked ~ .cs_play_pause > .cs_pause,
.csslider1 > .slide:checked ~ .cs_play_pause > .cs_play,
.csslider1 > .pause:checked ~ .cs_play_pause > .cs_play {
    display: block;
    z-index: 5;
}
.csslider1 > #cs_play1:checked ~ .cs_play_pause > .cs_play,
.csslider1 > .slide:checked ~ .cs_play_pause > .cs_pause,
.csslider1 > .pause:checked ~ .cs_play_pause > .cs_pause {
    display: none;
    z-index: -1;
}



@-webkit-keyframes pauseChange {
    0%, 33.32333333333334% { opacity: 1; z-index: 5; }
    33.333333333333336%, 100%  { opacity: 0; z-index: -1; }
}
@keyframes pauseChange {
    0%, 33.32333333333334% { opacity: 1; z-index: 5; }
    33.333333333333336%, 100%  { opacity: 0; z-index: -1; }
}


.csslider1 > #cs_play1:checked ~ .cs_play_pause{display:none;}

.csslider1 > #cs_play1:checked ~ .cs_play_pause > .cs_pause.num0 {
    opacity: 0;
    z-index: -1;
    -webkit-animation: pauseChange 18800ms infinite -1900ms;
    animation: pauseChange 18800ms infinite -1900ms;
}

.csslider1 > #cs_play1:checked ~ .cs_play_pause > .cs_pause.num1 {
    opacity: 0;
    z-index: -1;
    -webkit-animation: pauseChange 18800ms infinite 1700ms;
    animation: pauseChange 18800ms infinite 1700ms;
}
.csslider1 > #cs_play1:checked ~ .cs_play_pause > .cs_pause.num2 {
    opacity: 0;
    z-index: -1;
    -webkit-animation: pauseChange 18800ms infinite 5300ms;
    animation: pauseChange 18800ms infinite 5300ms;
}
.csslider1 > #cs_play1:checked ~ .cs_play_pause > .cs_pause.num3 {
    opacity: 0;
    z-index: -1;
    -webkit-animation: pauseChange 18800ms infinite 8900ms;
    animation: pauseChange 18800ms infinite 8900ms;
}

.csslider1 > #cs_play1:checked ~ .cs_play_pause > .cs_pause.num4 {
    opacity: 0;
    z-index: -1;
    -webkit-animation: pauseChange 18800ms infinite 12500ms;
    animation: pauseChange 18800ms infinite 12500ms;
}
.csslider1 > #cs_play1:checked ~ .cs_play_pause > .cs_pause.num5 {
    opacity: 0;
    z-index: -1;
    -webkit-animation: pauseChange 18800ms infinite 16100ms;
    animation: pauseChange 18800ms infinite 16100ms;
}
.csslider1 > .slide:checked ~ .cs_play_pause > .cs_pause,
.csslider1 > .pause:checked ~ .cs_play_pause > .cs_pause {
    -webkit-animation: none;
    animation: none;
}

/* ------------- Play Pause CSS ------------- */
.csslider1{position:relative}
.csslider1 > .slide:checked ~ .cs_play_pause > .cs_play{
    display: block;
    background: rgba(0,0,0,0.5);
    z-index: 5;
    color: #fff;
    padding: 5px;
    font-family: arial;
    font-size: 9px;
}
.csslider1 > .slide:checked ~ .cs_play_pause > .cs_play:hover{ background: rgba(0,0,0,1);}
.csslider1 > .cs_play_pause {
    position: absolute;
    bottom: 0;
    z-index: 5;
    margin-right: 0;
    z-index: 111;
}