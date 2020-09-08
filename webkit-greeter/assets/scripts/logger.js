export default function log(...parameters) {
  const $log = document.querySelector('.log');
  console.log(parameters);

  if ($log) {
    document.querySelector('.log').innerHTML += `<p>${parameters.join(' ### ')}</p>`;
  }
}
