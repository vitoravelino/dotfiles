import log from './logger';
import settings from './settings';

const startAuthentication = () => {
  lightdm.cancel_authentication();
  lightdm.authenticate(settings.get('username'));
};

const showMessage = (text) => {
  const $formMessage = document.querySelector('.form-message');

  log('show_message', text);
  $formMessage.textContent = text;
  $formMessage.style.display = 'block';
};

const register = () => {
  window.show_message = showMessage;
  window.autologin_timer_expired = startAuthentication;
  window.authentication_complete = () => {
    if (lightdm.is_authenticated) {
      settings.save();
      lightdm.start_session(settings.get('session'));
    } else {
      startAuthentication();
      showMessage('Wrong password');
    }
  };

  startAuthentication();
  log('authenticate', settings.get('username'));
};

export default {
  register,
};
