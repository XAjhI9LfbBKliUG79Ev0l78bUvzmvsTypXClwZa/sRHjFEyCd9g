const phoneNumber = '+79042437917';
const emailAddress = 'advokatshkoda@duck.com';
const workAddress = 'набережная имени Генерал-лейтенанта М.М. Рудченко, 14, Энгельс, Саратовская область';

const signalPhoneNumber = phoneNumber.replace(/\D/g, '');
const signalLink = `https://signal.me/#p/${signalPhoneNumber}`;

const formattedPhoneNumber = '+7 (904) 243-79-17';

export const contactInfo = {
  phoneNumber,
  emailAddress,
  signalLink,
  signalPhoneNumber,
  workAddress,
  formattedPhoneNumber,
};
