let currentTime;
let previousTime;

const padLeft = (number) => {
  if (number < 10) {
    return `0${number}`;
  }

  return number;
};

setInterval(() => {
  const date = new Date();
  const hours = date.getHours();
  const minutes = date.getMinutes();

  previousTime = currentTime;
  currentTime = hours + minutes;

  if (currentTime !== previousTime) {
    const part = hours >= 12 ? 'PM' : 'AM';
    const normalizedHours = hours === 12 || hours === 0 ? 12 : hours % 12;
    const timeStr = `${padLeft(normalizedHours)}:${padLeft(minutes)} ${part}`;
    const dateStr = date.toLocaleDateString('en-US', {
      weekday: 'short',
      day: 'numeric',
      month: 'short',
    });

    const $time = document.querySelector('.date-block .label-block-content');
    $time.textContent = `${dateStr} ${timeStr}`;
  }
}, 1000);
