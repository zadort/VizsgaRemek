import React, { useContext } from 'react';
import { DarkModeContext } from './DarkModeContext';
import './Kapcsolat.css';

const Kapcsolat = () => {
  const { isDarkMode } = useContext(DarkModeContext);

  return (
    <div className={`kapcsolat-container ${isDarkMode ? 'dark-mode' : ''}`}>
      <h1>Kapcsolat</h1>
      <p>Kérdése van vagy segítségre van szüksége? Lépjen kapcsolatba velünk!</p>

      <div className="kapcsolat-info">
        <h2>Elérhetőségek</h2>
        <p><strong>Cím:</strong> 1234 Budapest, Vásárló utca 1.</p>
        <p><strong>Telefon:</strong> +36 1 234 5678</p>
        <p><strong>E-mail:</strong> info@elektronikawebshop.hu</p>
        <p><strong>Nyitvatartás:</strong> Hétfőtől péntekig, 9:00 - 17:00</p>
      </div>

      <div className="kapcsolat-urmap">
        <h2>Írjon nekünk!</h2>
        <form>
          <div className="form-group">
            <label htmlFor="name">Név:</label>
            <input type="text" id="name" name="name" required />
          </div>
          <div className="form-group">
            <label htmlFor="email">E-mail:</label>
            <input type="email" id="email" name="email" required />
          </div>
          <div className="form-group">
            <label htmlFor="message">Üzenet:</label>
            <textarea id="message" name="message" rows="5" required></textarea>
          </div>
          <button type="submit">Üzenet küldése</button>
        </form>
      </div>
    </div>
  );
};

export default Kapcsolat;