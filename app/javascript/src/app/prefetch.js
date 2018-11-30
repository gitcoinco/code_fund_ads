const hoverTime = 300;
const fetchers = {};

function prefetch(url) {
  const iframe = document.createElement('iframe');
  iframe.hidden = true;
  iframe.src = url;
  iframe.addEventListener('load', () => {
    const snapshot = Turbolinks.Snapshot.fromHTMLElement(iframe.contentDocument.documentElement);
    Turbolinks.controller.cache.put(url, snapshot);
  });
  document.body.appendChild(iframe);
}

function prefetched(url) {
  return Turbolinks.controller.cache.has(url);
}

function cleanup(event) {
  const element = event.target;
  clearTimeout(fetchers[element.href]);
  element.removeEventListener('mouseleave', cleanup);
}

document.addEventListener('mouseover', event => {
  if (!event.target.dataset.prefetch) return;
  let url = event.target.href;
  if (prefetched(url)) return;
  cleanup(event);
  event.target.addEventListener('mouseleave', cleanup);
  fetchers[url] = setTimeout(() => prefetch(url), hoverTime);
});
