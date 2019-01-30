import { Controller } from 'stimulus';

export default class extends Controller {
  shareTwitter(event) {
    event.preventDefault();
    const { url, text } = event.target.dataset;
    open(
      'https://twitter.com/intent/tweet?related=codefundio&url=' +
        encodeURI(url) +
        '&text=' +
        encodeURI(text),
      'tshare',
      'height=400,width=550,resizable=1,toolbar=0,menubar=0,status=0,location=0'
    );
  }

  shareFacebook(event) {
    event.preventDefault();
    const { url, image, text } = event.target.dataset;
    open(
      'https://facebook.com/sharer.php?s=100&p[url]=' +
        encodeURI(url) +
        '&p[images][0]=' +
        encodeURI(image) +
        '&p[title]=' +
        encodeURI(text),
      'fbshare',
      'height=380,width=660,resizable=0,toolbar=0,menubar=0,status=0,location=0,scrollbars=0'
    );
  }

  shareLinkedIn(event) {
    event.preventDefault();
    const { url, text } = event.target.dataset;
    open(
      'https://www.linkedin.com/shareArticle?mini=true&source=CodeFund+Jobs&title=' +
        encodeURI(text) +
        '&url=' +
        encodeURI(url),
      'lshare',
      'height=380,width=660,resizable=0,toolbar=0,menubar=0,status=0,location=0,scrollbars=0'
    );
  }

  shareEmail(event) {
    event.preventDefault();
    const { url, text } = event.target.dataset;
    const mailUrl = 'mailto:?body=' + encodeURI(text + '\n\n' + url + '\n');
    window.location.href = mailUrl;
  }
}
