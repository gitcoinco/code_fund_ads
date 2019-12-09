export default function html(strings, ...values) {
    const string = strings.reduce((previous, current, index) => {
        return previous + current + (values[index] ? values[index] : '');
    }, '');

    const el = document.createElement('div');
    el.innerHTML = string;
    return el.firstChild;
}
