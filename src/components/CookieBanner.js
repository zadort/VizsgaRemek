import React, { useState, useEffect } from 'react';
import './CookieBanner.css';

const CookieBanner = () => {
  const [isVisible, setIsVisible] = useState(false);

  useEffect(() => {
    const consent = localStorage.getItem('cookieConsent');
    if (!consent) {
      setIsVisible(true);
    }
  }, []);

  const acceptCookies = () => {
    localStorage.setItem('cookieConsent', 'accepted');
    setIsVisible(false);
  };


  const declineCookies = () => {
    localStorage.setItem('cookieConsent', 'declined');
    setIsVisible(false);
  };

  if (!isVisible) return null;

  return (
    <div className="cookie-banner">
      <p>
        A weboldal cookie-kat használ a felhasználói élmény javítása érdekében. A
        részletekért kérjük, olvassa el az {'adatkezeles'}-t.
        <a href="/adatkezeles">Adatvédelmi Szabályzatunkat</a>.
      </p>
      <div className="cookie-banner-buttons">
        <button onClick={acceptCookies}>Elfogadom</button>
        <button onClick={declineCookies}>Elutasítom</button>
      </div>
    </div>
  );
};

export default CookieBanner;