const $overlay = document.querySelector('.overlay');

let hideCallback = null;
let showCallback = null;

const states = {
  current: 'shutdown',
  shutdown: {
    left: 'restart',
    right: 'suspend',
    select() {
      lightdm.shutdown();
    },
  },
  restart: {
    left: null,
    right: 'shutdown',
    select() {
      lightdm.restart();
    },
  },
  suspend: {
    left: 'shutdown',
    right: null,
    select() {
      lightdm.suspend();
    },
  },
};

const move = (direction) => {
  const current = states[states.current];

  if (current[direction]) {
    states.current = current[direction];
    document.querySelector('.selected').classList.remove('selected');
    document.querySelector(`.${states.current}`).classList.add('selected');
  }
};

const select = () => {
  states[states.current].select();
};

const hide = () => {
  $overlay.style.display = 'none';

  if (hideCallback) {
    hideCallback();
  }
};

const onHide = (callback) => {
  hideCallback = callback;
};

const show = () => {
  $overlay.style.display = 'flex';

  if (showCallback) {
    showCallback();
  }
};

const onShow = (callback) => {
  showCallback = callback;
};

const isOpen = () => $overlay.style.display === 'flex';

// event listeners
document.querySelector('.suspend').addEventListener('click', states.suspend.select);
document.querySelector('.restart').addEventListener('click', states.restart.select);
document.querySelector('.shutdown').addEventListener('click', states.shutdown.select);
document.addEventListener('keyup', (e) => {
  const LEFT = 37;
  const RIGHT = 39;
  const ENTER = 13;
  const ESC = 27;

  if (!isOpen()) {
    return;
  }

  switch (e.keyCode) {
    case LEFT:
      move('left');
      break;
    case RIGHT:
      move('right');
      break;
    case ESC:
      hide();
      break;
    case ENTER:
      select();
      break;
    default:
      break;
  }
});

export default {
  hide,
  show,
  onHide,
  onShow,
};
