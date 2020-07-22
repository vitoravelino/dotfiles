const settings = {
  username: null,
  session: null,
};

const set = (key, value) => {
  settings[key] = value;
};

const get = (key) => {
  return settings[key];
};

const load = () => {
  const savedSettings = JSON.parse(localStorage.getItem('customSettings')) || {};
  const defaultUser =
    lightdm.users.find((u) => u.username === savedSettings.username) || lightdm.users[0];

  settings.username = defaultUser.username;
  settings.session = defaultUser.session || lightdm.default_session;
};

const save = () => {
  const settingsToSave = JSON.stringify(settings);

  localStorage.setItem('customSettings', settingsToSave);
};

export default {
  save,
  load,
  set,
  get,
};
