// import './scripts/lightdm-mock';
import './scripts/x-chooser';
import './scripts/datetime';

import settings from './scripts/settings';
import powerOverlay from './scripts/power-overlay';
import lightdmCallbacks from './scripts/lightdm-callbacks';

const createWMChooser = () => {
  const wmChooser = document.createElement('x-chooser');
  wmChooser.icon = '';
  wmChooser.displayKey = 'name';
  wmChooser.collectionKey = 'key';
  wmChooser.options = lightdm.sessions;
  wmChooser.preselect(settings.get('session'));
  document.querySelector('header').appendChild(wmChooser);

  return wmChooser;
};

const createUserChooser = () => {
  const userChooser = document.createElement('x-chooser');
  userChooser.icon = '';
  userChooser.displayKey = 'display_name';
  userChooser.collectionKey = 'username';
  userChooser.options = lightdm.users;
  userChooser.preselect(settings.get('username'));
  document.querySelector('.logo').after(userChooser);

  return userChooser;
};

const main = () => {
  settings.load();
  lightdmCallbacks.register();

  const wmChooser = createWMChooser();
  const userChooser = createUserChooser();

  wmChooser.addEventListener('optionSelected', (e) => {
    const session = e.detail.value;

    settings.set('session', session.key);
  });
  userChooser.addEventListener('optionSelected', (e) => {
    const $password = document.querySelector('.password-input');
    const user = e.detail.value;

    settings.set('username', user.username);
    wmChooser.select(user.session);
    lightdm.cancel_authentication();
    lightdm.authenticate(user.username);
    $password.focus();
  });

  powerOverlay.onHide(() => {
    document.querySelector('.form').style.display = 'block';
  });
  powerOverlay.onShow(() => {
    document.querySelector('.form').style.display = 'none';
  });

  document.querySelector('.form').addEventListener('submit', (e) => {
    const $password = document.querySelector('.password-input');
    const $formMessage = document.querySelector('.form-message');

    e.preventDefault();
    lightdm.respond($password.value);
    $formMessage.style.display = 'none';
    $password.value = '';
  });

  document.querySelector('.power-button').addEventListener('click', powerOverlay.show);
};

// needed to avoid undefined data on lightdm object
// GreeterReady event wasn't working =/
document.addEventListener('DOMContentLoaded', () => {
  setTimeout(main, 3);
});
