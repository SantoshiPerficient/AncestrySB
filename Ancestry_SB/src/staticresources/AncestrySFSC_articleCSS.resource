/*----- Article Modal Styles -----*/
img.modalButton {
    cursor: pointer;
}
.forceOutputRichText a {
    cursor: pointer;
}
.forceOutputRichText .modal-style {
    display: none; /* Hidden by default */
    position: fixed; /* Stay in place */
    z-index: 1; /* Sit on top */
    padding-top: 100px; /* Location of the box */
    left: 0;
    top: 0;
    width: 100%; /* Full width */
    height: 100%; /* Full height */
    overflow: auto; /* Enable scroll if needed */
    background-color: rgb(168, 183, 199); /* Fallback color */
    background: rgba(168, 183, 199, 0.7); /* Black w/ opacity */
    padding-left: 30px;
    padding-right: 30px;
    cursor: pointer;
}
/* Modal Content */
.forceOutputRichText .modal-content {
    margin: auto;
    box-sizing: border-box;
    width: 100%;
    margin-bottom: 10px;
    padding: 20px;
    transform: translate3d(0, 0, 0);
    color: #2b2e38;
    background: #fff;
    /*  box-shadow: 0 0 30px rgba(0, 0, 0, 0.6);  */
    clear: both;
    margin: 20px auto;
    max-width: 1040px;
    border-radius: 6px;
    text-align: center;
}
/* Modal Content IMG */
.forceOutputRichText .modal-content img {
    border-radius: 6px;
    max-width: 1000px;
}
/* The Close Button */
.forceOutputRichText .close {
    color: #fff;
    cursor: pointer;
    font-size: 46px;
    font-weight: lighter;
    line-height: 1.2;
    padding: 0;
    position: absolute;
    right: 10px;
    text-align: center;
    text-decoration: none !important;
    top: -60px;
    width: 28px;
}
.selfServiceArticleLayout .helpArticle .conBody img:not(.modal) {
    border: 1px solid #bebbb3;
    border-radius: 4px;
    display: inline-block;
    overflow: hidden;
}
/*----- Article Styles -------*/
.uiOutputRichText.forceOutputRichText p:empty {
        margin: 0;
}
.forceOutputRichText a {
    cursor: pointer;
}
/*---- Title Styles  ----*/

.selfServiceArticleLayout p > span {
    color: #648200;
    display: block;
    font-weight: bold;
    padding: 10px 0 0;
    font-size: 1.2em;    
}
.selfServiceArticleLayout .head1 {
       font-size: 22px;
    margin-top: 20px;
    padding-top: 20px;
}
.helpArticle .head1, .helpArticle .head2, .helpArticle .head3, .helpArticle .rn_RelatedAnswers2 h2, .helpArticle .rn_PreviousAnswers2 h2, .helpArticle .rn_AnswerFeedback2 .rn_Title {
    -moz-border-bottom-colors: none;
    -moz-border-left-colors: none;
    -moz-border-right-colors: none;
    -moz-border-top-colors: none;
    border-color: #f0eee9 -moz-use-text-color -moz-use-text-color;
    border-image: none;
    border-style: solid none none;
    border-width: 1px 0 0;
    color: #648200;
    display: block;
    font-size: 18px;
    font-weight: 400;
    margin: 10px -20px 0;
    padding: 10px 20px 0;
}

.selfServiceArticleLayout .conTitle {
    font-size: 30px;
    font-weight: 300;
    line-height: 1.1;
    margin-top: 0;
    padding-bottom: 10px;
}
.selfServiceArticleLayout .rn_Highlight {
    font-style: normal;
    font-weight: bold;
    text-decoration: inherit;
}
.selfServiceArticleLayout .helpTitle1, .selfServiceArticleLayout .helpTitle2 {
    margin-left: -10px;
    margin-right: -10px;
}
.selfServiceArticleLayout .helpTitle2, .selfServiceArticleLayout .helpSubContainerTitle {
    font-size: 22px;
}
.selfServiceArticleLayout .helpTitle1, .selfServiceArticleLayout .helpTitle2 {
    background: #4d4266 none repeat scroll 0 0;
    border-radius: 26px;
    color: #fff;
    display: block;
    font-size: 30px;
    margin: 20px 0 5px;
    padding: 10px 20px 10px;
}
.selfServiceArticleLayout .helpTitle2, .selfServiceArticleLayout .helpSubContainerTitle {
    font-size: 22px;
}
.selfServiceArticleLayout .helpSubContainer {
    background-color: rgba(240, 238, 233, 0.3);
    border: 1px solid #dedcd6;
    border-radius: 4px;
    margin: 20px 10px;
    padding: 15px;
}
/*----- Article Vote Buttons -------*/

.selfServiceArticleVotingIcon.upvote:focus .forceIcon, .selfServiceArticleVotingIcon.upvote .forceIcon:hover {
     color: #fff !important;
    border: none !important;
}
.selfServiceArticleVotingIcon.downvote:focus .forceIcon, .selfServiceArticleVotingIcon.downvote .forceIcon:hover {
     color: #fff !important;
    border: none !important;
}
.selfServiceArticleVotingIcon.upvote.active, .selfServiceArticleVotingIcon.upvote:focus, .selfServiceArticleVotingIcon.upvote:hover {
    background-color: #7B9526 !important;
     color: #fff !important;
    border: none !important;
}
.selfServiceArticleVotingIcon.downvote.active, .selfServiceArticleVotingIcon.downvote:focus, .selfServiceArticleVotingIcon.downvote:hover {
    background-color: #333333 !important;
     color: #fff !important;
    border: none !important;
}
.upvote.mainIcon.uiButton.selfServiceArticleVotingIcon {
    background-color: #9cbe30;
    color: #fff !important;
    transition: background-color 0.8s ease 0s;
    border: none !important;
}
.downvote.mainIcon.uiButton.selfServiceArticleVotingIcon {
    background-color: #52524e;
    color: #fff !important;
    transition: background-color 0.8s ease 0s;
    border: none !important;
}
/*---- Article Help Container ----*/

.selfServiceArticleLayout .helpSubContainer ul {
    list-style-type: disc;
}
.selfServiceArticleLayout .helpSubContainer ol, .selfServiceArticleLayout .helpSubContainer ul {
    padding-left: 2rem !important;
     }
.selfServiceArticleLayout .conDivider {
    clear: both;
    margin: 0 -20px 20px;
    padding-top: 20px;
}
.selfServiceArticleLayout hr {
    -moz-border-bottom-colors: none;
    -moz-border-left-colors: none;
    -moz-border-right-colors: none;
    -moz-border-top-colors: none;
    border-color: -moz-use-text-color -moz-use-text-color #f0eee9;
    border-image: none;
    border-style: none none solid;
    border-width: 0 0 1px;
    height: 0;
    margin: 20px 0;
}

.selfServiceArticleLayout .forcePageBlockSectionRow.full {
    padding: 0 !important;
}
.selfServiceArticleLayout .forcePageBlockSectionView.full .labelCol {
    display: none !important;
    margin-bottom: 10px;
}
 .selfServiceArticleLayout .helpSteps img: {
 border: 1px solid #bebbb3;
 border-radius: 4px;
 display: inline-block;
 overflow: hidden;
}
.forceOutputRichText .close:hover, .forceOutputRichText .close:focus {
    /* background-color: #9CBE30; */
    transition: opacity 0.2s ease 0s;
}
/*---- Article Help Steps ----*/

.selfServiceArticleLayout .helpSteps.helpSteps {
    counter-reset: helpSteps;
    margin-left: 52px;
    max-width: none !important;
}
.selfServiceArticleLayout .helpSteps > li {
    list-style: none;
    margin-top: 10px;
    padding-top: 24px;
    position: relative;
}
.selfServiceArticleLayout .helpSteps > li::after {
    color: #60527e;
    content: 'STEP';
    font-size: 18px;
    left: -52px;
    position: absolute;
    top: 0;
}
.selfServiceArticleLayout .helpSteps > li::before {
    background: #60527e;
    border-radius: 50%;
    color: #fff;
    content: counter(helpSteps);
    counter-increment: helpSteps;
    font-size: 24px;
    font-weight: bold;
    height: 36px;
    left: -52px;
    line-height: 36px;
    position: absolute;
    text-align: center;
    width: 36px;
}
.selfServiceArticleLayout .helpSteps img {
    border: 1px solid #bebbb3;
    border-radius: 4px;
}
.selfServiceArticleLayout .helpStepsTitle {
    background-color: #f0eee9;
    border-radius: 20px;
    display: block;
    line-height: 1.5;
    margin: 0 0 0 -52px;
    padding: 6px 8px 6px 52px;
    max-width: none !important;
}
.selfServiceArticleLayout.zoom.article-column {
    padding: 30px 20px;
}
.selfServiceArticleLayout .badgeSize1.icon::before {
    font-size: 12px;
    top: 0;
}
.selfServiceArticleLayout .iconZoomIn::before {
    content: "";
}
.selfServiceArticleLayout .icon::before {
    margin-right: 0.25em;
}
.selfServiceArticleLayout .icon::before, .selfServiceArticleLayout .iconAfter::after {
    -moz-osx-font-smoothing: grayscale;
    font: 107%/0 "ancestry-icon";
    position: relative;
    text-transform: none;
    top: 0.075em;
}
.selfServiceArticleLayout .helpSteps.helpSteps {
    counter-reset: helpSteps;
    margin-left: 52px;
    padding-left: 0;
}
.selfServiceArticleLayout .helpSteps .badgeSize1 {
    font-size: 15px;
    line-height: 20px;
    min-width: 20px;
    padding: 0 8px;
}
.selfServiceArticleLayout .helpSteps .badgeColor3 {
    background-color: #706b63;
}
.selfServiceArticleLayout .helpSteps .badge {
    -moz-appearance: none;
    background-origin: padding-box;
    border: 0 none;
    border-radius: 15px;
    color: #fff !important;
    display: inline-block;
    font-family: inherit;
    font-style: normal;
    font-weight: bold;
    line-height: 20px;
    padding: 2px 10px;
    position: relative;
    text-align: center;
    text-decoration: none !important;
    text-indent: 0;
    text-shadow: 0 0 3px rgba(0, 0, 0, 0.3);
    text-transform: uppercase;
    top: -0.125em;
    vertical-align: middle;
}
.selfServiceArticleLayout .helpSteps .topSpacing {
    margin-top: 10px !important;
}
.selfServiceArticleLayout .helpArticle .conBody img:not(.modal) {
    border: 1px solid #bebbb3;
    border-radius: 4px;
    display: inline-block;
    overflow: hidden;
}
.selfServiceArticleLayout .photo {
    border-radius: 8px;
    display: inline-block;
    font-size: 0;
    line-height: 0;
    max-width: 100%;
    overflow: hidden;
    vertical-align: top;
    margin-top: 10px;
}
.selfServiceArticleLayout .helpArticle li {
    margin-top: 5px !important;
}
.helpArticle li {
    margin-top: 5px !important;
}
.selfServiceArticleLayout .helpArticle ol, .selfServiceArticleLayout .helpArticle ul {
    margin: 10px 0 0 24px;
}

/*---- Hides Empty Paragraphs ----*/
.selfServiceArticleLayout p:empty { display: none !important; }

.selfServiceArticleLayout p:-moz-only-whitespace { display: none !important; } /* Mozilla-only pseudo-class that works like :blank will */

.helpSubContainer > p {
    margin: 0;
}

/*---- Ordered List Styles  ----*/
.uiOutputRichText.forceOutputRichText ol li > span {
    color: #648200;
    display: block;
    font-weight: bold;
    padding: 10px 0 0;
}
@media (max-width: 767px) {
}

@media (max-width: 480px) {
.forceOutputRichText .modal-content {
    padding: 10px;
}
}
